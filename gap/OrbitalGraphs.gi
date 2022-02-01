# OrbitalGraphs: Computations with orbital graphs in GAP
# A GAP package by Paula Hähndel, Markus Pfeiffer, and Wilf A. Wilson.
#
# SPDX-License-Identifier: MPL-2.0
#
# Implementations


## Constructing orbital graphs

# Permutation groups

InstallMethod(OrbitalGraphs, "for a permutation group",
[IsPermGroup],
{G} -> OrbitalGraphs(G, MovedPoints(G)));

InstallMethod(OrbitalGraphs, "for a permutation group and an int",
[IsPermGroup, IsInt],
function(G, n)
    if n < 0 then
        ErrorNoReturn("the second argument <n> must be a nonnegative integer");
    fi;
    return OrbitalGraphs(G, [1 .. n]);
end);

# The code below was originally essentially stolen from ferret.
# Do we want to give different versions of this:
#   a naive version that just computes all orbital graphs,
#   a version that only gives a representative in the isomorphism class, and
#   a version that gives the ones actually used in backtrack?
#
InstallMethod(OrbitalGraphs, "for a permutation group and a homogeneous list",
[IsPermGroup, IsHomogeneousList],
function(G, points)
    local orb, orbitsG, iorb, graph, graphlist, val, p, i, orbsizes, D,
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

    fillRepElts := function(G, orb)
        local val, g, reps, buildorb, gens;
        reps := [];
        reps[orb[1]] := ();
        buildorb := [orb[1]];
        gens := GeneratorsOfGroup(G);
        for val in buildorb do
            for g in gens do
                if not IsBound(reps[val^g]) then
                    reps[val^g] := reps[val] * g;
                    Add(buildorb, val^g);
                fi;
            od;
        od;
        return reps;
    end;

    graphlist := [];
    moved := Intersection(points, MovedPoints(G));
    orbitsG := Orbits(G, moved);

    # FIXME: Currently unused
    orbsizes := [];
    # FIXME: Currently unused
    orbpos := [];

    # Efficently store size of orbits of values
    for orb in [1..Length(orbitsG)] do
        for i in orbitsG[orb] do
            orbsizes[i] := Size(orbitsG[orb]);
            orbpos[i] := orb;
        od;
    od;

    innerorblist := List(orbitsG, o -> Orbits(Stabilizer(G, o[1]), moved));
    # FIXME: Currently unused
    orbitsizes := List([1..Length(orbitsG)],
                       x -> List(innerorblist[x], y -> Size(orbitsG[x])*Size(y)));

    for i in [1..Length(orbitsG)] do
        orb := orbitsG[i];
        orbreps := [];

        for iorb in innerorblist[i] do
            if not (Size(iorb) = 1 and orb[1] = iorb[1]) # No loopy orbitals
            then
                graph := List([1..maxval], x -> []);
                if IsEmpty(orbreps) then
                    orbreps := fillRepElts(G, orb);
                fi;
                for val in orb do
                    p := orbreps[val];
                    graph[val] := List(iorb, x -> x^p);
                od;
                D := Digraph(graph);
                SetUnderlyingGroup(D, G);
                AddSet(graphlist, D);
            fi;
        od;
    od;
    Perform(graphlist, function(x) SetFilterObj(x, IsOrbitalGraphOfGroup); end);
    return graphlist;
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
