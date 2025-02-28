# OrbitalGraphs: Computations with orbital graphs in GAP
# A GAP package by Paula Hähndel, Markus Pfeiffer, and Wilf A. Wilson.
#
# SPDX-License-Identifier: MPL-2.0
#
# Implementations


## Constructing orbital graphs

# Permutation groups

# FIXME: Currently, if ValueOptions are set, then this can set the wrong value
# of this attribute!
InstallMethod(OrbitalGraphs, "for a permutation group", [IsPermGroup],
{G} -> OrbitalGraphs(G, MovedPoints(G)));

InstallMethod(OrbitalGraphs, "for a permutation group and an int",
[IsPermGroup, IsInt],
function(G, n)
    if n < 0 then
        ErrorNoReturn("the second argument <n> must be a nonnegative integer");
    fi;
    return OrbitalGraphs(G, [1 .. n]);
end);

# The code below is essentially stolen from ferret; do we want to give:
#     * a naive version that just computes all orbital graphs
#     * a version one that only gives a representative in the isomorphism class
#     * a version that gives the ones actually used in backtrack?
#
InstallMethod(OrbitalGraphs, "for a permutation group and a homogeneous list",
[IsPermGroup, IsHomogeneousList],
function(G, points)
    local orb, orbitsG, iorb, graph, graphlist, val, p, i, orbsizes, D, cutoff,
          biggestOrbit, shouldSkipOneLargeOrbit, allowLoopyGraphs, search,
          orbpos, innerorblist, orbitsizes, orbreps, fillRepElts, maxval, moved;

    if IsEmpty(points) then
        return [];
    elif not ForAll(points, IsPosInt) then
        ErrorNoReturn("the second argument <points> must be a list of ",
                      "positive integers");
    fi;
    points := Set(points);
    maxval := Maximum(points);
    if not (maxval >= LargestMovedPoint(G) or
            ForAll(GeneratorsOfGroup(G), g -> OnSets(points, g) = points)) then
        ErrorNoReturn("the second argument <points> must be fixed setwise ",
                      "by the first argument <G>");
    fi;
    moved := Intersection(points, MovedPoints(G));

    # Optimisation from BacktrackKit
    # Warning: in the future, if we wish to allow supporting orbital graphs
    # with loops, and choosing base points that are allowed to be fixed, then
    # this would mean that a trivial group could have some orbital graphs to
    # return, and so this optimisation would be invalid.
    if IsTrivial(G) then
        return [];
    fi;

    fillRepElts := function(G, orb)
        local val, g, reps, buildorb, gens;
        reps := [];
        reps[orb[1]] := ();
        buildorb := [orb[1]];
        gens := GeneratorsOfGroup(G);
        for val in buildorb do
            for g in gens do
                if not IsBound(reps[val ^ g]) then
                    reps[val ^ g] := reps[val] * g;
                    Add(buildorb, val ^ g);
                fi;
            od;
        od;
        return reps;
    end;

    # Option `cutoff`:
    # Have a limit for the number of edges that an orbital graph that this
    # function will create. The default is infinity.
    if IsPosInt(ValueOption("cutoff")) then
        cutoff := ValueOption("cutoff");
    else
        cutoff := infinity;
    fi;

    # TODO: Implement this
    # Option `loops`:
    # Create OrbitalGraphs with base pair is a loop (i.e. a repeated vertex).
    # People do not normally want these kinds of orbital graphs, since they
    # only tell you about the orbit of that point.
    #allowLoopyGraphs := ValueOption("loops") = true;

    # Option `search`:
    # If `true`, then OrbitalGraphs will not create some orbital graphs
    # that are useless from the point of view of a backtrack search algorithm.
    search := ValueOption("search") = true;

    # Option `skipone`
    # If `true`, then OrbitalGraphs will not create one of the orbital graphs
    # that has the largest possible number of edges. In a backtrack search,
    # one such orbital graph can be ignored without losing anything.
    shouldSkipOneLargeOrbit := search or ValueOption("skipone") = true;

    # Make sure that the orbits of G are stably sorted, so that the resulting
    # list of orbital graphs for a group always comes in the same order,
    # with the same base pairs.
    orbitsG := Set(Orbits(G, moved), Set);

    # Efficently store size of orbits of values
    orbsizes := [];
    orbpos := [];
    for orb in [1 .. Length(orbitsG)] do
        for i in orbitsG[orb] do
            orbsizes[i] := Length(orbitsG[orb]);
            orbpos[i] := orb;
        od;
    od;

    # FIXME: In the following line, BacktrackKit uses [1..LargestMovedPoint(G)]
    # instead of moved (which omits non-moved points). Is this a problem?
    innerorblist := List(orbitsG, o -> Set(Orbits(Stabilizer(G, o[1]), moved), Set));
    orbitsizes := List([1 .. Length(orbitsG)],
                       x -> List(innerorblist[x], y -> Length(orbitsG[x]) * Length(y)));
    biggestOrbit := Maximum(List(orbitsizes, Maximum));

    graphlist := [];
    for i in [1 .. Length(orbitsG)] do
        orb := orbitsG[i];
        orbreps := [];
        for iorb in innerorblist[i] do
            # Find reasons to not construct this orbital graph...
            # (These conditions are split to allow for future Info statements
            # explaining what is happening, and also to make sure we have
            # good code coverage, and therefore that we have good tests.)
            if Size(orb) * Size(iorb) > cutoff then
                # orbital graph is too big
                continue;
            elif search and orbpos[orb[1]] = orbpos[iorb[1]] and Size(iorb) + 1 = orbsizes[iorb[1]] then
                # orbit size only removed one point
                # TODO: Is this only relevant to 2-or-more-transitive groups, in which case there is just a unique orbital graph?
                continue;
            elif Length(iorb) = 1 and orb[1] = iorb[1] then
                # don't want to take the fixed point orbit
                continue;
            elif search and Size(iorb) = orbsizes[iorb[1]] then
                # orbit size unchanged
                # TODO: Give an explanation of what this means
                continue;
            elif shouldSkipOneLargeOrbit and Size(orb) * Size(iorb) = biggestOrbit then
                # FIXME: Is it safe putting this here, not as the first check?
                # largest possible; skip
                shouldSkipOneLargeOrbit := false;
                continue;
            fi;

            # Construct the orbital graph as a Digraphs package object
            if IsEmpty(orbreps) then
                orbreps := fillRepElts(G, orb);
            fi;
            graph := List([1 .. maxval], x -> []);
            for val in orb do
                p := orbreps[val];
                graph[val] := List(iorb, x -> x ^ p);
            od;
            D := Digraph(graph);
            SetFilterObj(D, IsOrbitalGraphOfGroup);
            SetUnderlyingGroup(D, G);
            Add(graphlist, D);
        od;
    od;
    # Note: `graphlist` should already be stably ordered because of the uses of `Set`
    return graphlist;
end);


# Individual orbital graphs

InstallMethod(OrbitalGraph,
"for a permutation group, homogeneous list, and pos int",
[IsPermGroup, IsHomogeneousList, IsPosInt],
function(G, basepair, k)
  local D;
    if not (Length(basepair) = 2 and ForAll(basepair, IsPosInt)) then
        ErrorNoReturn("the second argument <basepair> must be a pair of ",
                      "positive integers");
    elif basepair[1] > k or basepair[2] > k or
      ForAny(GeneratorsOfGroup(G), g -> ForAny([1 .. k], i -> i ^ g > k)) then
        ErrorNoReturn("the third argument <k> must be such that [1..k] ",
                      "contains the entries of <basepair> and is preserved ",
                      "by G");
    fi;

    D := EdgeOrbitsDigraph(G, basepair, k);
    SetFilterObj(D, IsOrbitalGraphOfGroup);
    SetUnderlyingGroup(D, G);
    SetBasePair(D, basepair);
    return D;
end);


# Transformation semigroups

InstallMethod(OrbitalGraphs, "for a transformation semigroup",
[IsTransformationSemigroup],
function(S)
    # FIXME This is currently super-naive
    local bpts, out, D, x;

    bpts := Arrangements([1..LargestMovedPoint(S)], 2);
    out := [];
    for x in bpts do
      D := DigraphByEdges(AsList(Enumerate(Orb(S, x, OnTuples))));
      SetFilterObj(D, IsOrbitalGraphOfSemigroup);
      SetUnderlyingSemigroup(D, S);
      SetBasePair(D, x);
      AddSet(out, D);
    od;
    return out;
end);


## Information stored about orbital graphs at creation


InstallMethod(BasePair, "for an orbital graph of a group",
[IsOrbitalGraphOfGroup],
function(D)
    local i, j, nbs;
    nbs := OutNeighbours(D);
    i := First(DigraphVertices(D), x -> not IsEmpty(nbs[x]));
    j := Minimum(nbs[i]);
    return [i, j];
end);


## Values computed from the orbital graphs of a group


InstallMethod(OrbitalClosure, "for a permutation group",
[IsPermGroup],
function(G)
    if IsTrivial(G) then
        return G;
    fi;
    return Intersection(List(OrbitalGraphs(G), AutomorphismGroup));
end);


InstallMethod(OrbitalIndex, "for a permutation group", [IsPermGroup],
{G} -> Index(OrbitalClosure(G), G));


## Recognising a group from its orbital graphs


InstallTrueMethod(IsOGR, IsStronglyOGR);
InstallMethod(IsOGR, "for a permutation group", [IsPermGroup],
function(G)
    if IsTransitive(G) and Transitivity(G) > 1 then
        return IsNaturalSymmetricGroup(G);
    fi;
    # it holds that G <= OrbitalClosure(G), so testing for size is sufficient
    return Size(G) = Size(OrbitalClosure(G));
end);

InstallTrueMethod(IsStronglyOGR, IsAbsolutelyOGR);
InstallMethod(IsStronglyOGR, "for a permutation group", [IsPermGroup],
function(G)
    if IsTransitive(G) and Transitivity(G) > 1 then
        return IsNaturalSymmetricGroup(G);
    fi;
    return IsTrivial(G) or
           ForAny(OrbitalGraphs(G), x -> Size(G) = Size(AutomorphismGroup(x)));
end);

InstallTrueMethod(IsAbsolutelyOGR, IsPermGroup and IsNaturalSymmetricGroup);
InstallTrueMethod(IsAbsolutelyOGR, IsPermGroup and IsTrivial);
InstallMethod(IsAbsolutelyOGR, "for a permutation group", [IsPermGroup],
function(G)
    if IsTransitive(G) and Transitivity(G) > 1 then
        return IsNaturalSymmetricGroup(G);
    fi;
    return ForAll(OrbitalGraphs(G), x -> Size(G) = Size(AutomorphismGroup(x)));
end);





## Attributes and properties of individual orbital graphs


# TODO Is it possible to cleverly determine this at creation?
# I guess we can set it to be false if we know that the points of the base pair
# are in different orbits?
InstallMethod(IsSymmetricDigraph, "for an orbital graph of a group",
[IsOrbitalGraphOfGroup],
{D} -> IsDigraphEdge(D, Reversed(BasePair(D))));

InstallMethod(IsSelfPaired, "for an orbital graph",
[IsOrbitalGraph], IsSymmetricDigraph);


# TODO Make sure that I am doing the appropriate GAP-like thing
InstallMethod(ViewString, "for an orbital graph",
[IsOrbitalGraph],
function(D)
    local G, list_vertices, str;

    list_vertices := IsRange(DigraphVertices(D)) or DigraphNrVertices(D) < 10;
    if IsOrbitalGraphOfGroup(D) then
        G := UnderlyingGroup(D);
    elif IsOrbitalGraphOfSemigroup(D) then
        G := UnderlyingSemigroup(D);
    else
        ErrorNoReturn("Unknown kind of orbital graph! ",
                      "No known underlying group or semigroup");
    fi;

    str := "<";
    if IsSelfPaired(D) then
        Append(str, "self-paired ");
    fi;
    Append(str, "orbital graph \>of ");
    if HasName(G) then
        Append(str, Name(G));
    elif HasStructureDescription(G) then
        Append(str, StructureDescription(G));
    else
        Append(str, ViewString(G));
    fi;
    Append(str, "\< on \>");
    Append(str, String(DigraphNrVertices(D)));
    Append(str, " vertices\<");
    Append(str, " \>with \>base-pair \>(");
    Append(str, String(BasePair(D)[1]));
    Append(str, ",");
    Append(str, String(BasePair(D)[2]));
    Append(str, "),\<\< ");
    Append(str, PrintString(DigraphNrEdges(D)));
    Append(str, " arcs>\<");
    return str;
end);
