#
# OrbitalGraphs: Computations with Orbital Graphs
#
# Implementations
#

# The code below is essentially stolen from ferret;
#       Do we want to give a naive version that
#       just computes all orbital graphs, one that only
#       gives a representative in the isomorphism class,
#       and a version that gives the ones actually used in
#       backtrack?
#
InstallMethod( OrbitalGraphs, "for a permutation group"
             , [ IsPermGroup ],
function(G)
    local orb, orbitsG, iorb, graph, graphlist, val, p, i, orbsizes,
          orbpos, innerorblist, orbitsizes, iggestOrbit, skippedOneLargeOrbit,
          orbreps, stabtime, timefunc, fillRepElts, maxval;

    # TODO: Option?
    maxval := NrMovedPoints(G);

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
    orbitsG := Orbits(G, [1..maxval]);

    orbsizes := [];
    orbpos := [];

    # Efficently store size of orbits of values
    for orb in [1..Length(orbitsG)] do
        for i in orbitsG[orb] do
            orbsizes[i] := Size(orbitsG[orb]);
            orbpos[i] := orb;
        od;
    od;

    innerorblist := List(orbitsG, o -> Orbits(Stabilizer(G, o[1]), [1..LargestMovedPoint(G)]));
    orbitsizes := List([1..Length(orbitsG)],
                       x -> List(innerorblist[x], y -> Size(orbitsG[x])*Size(y)));

    for i in [1..Size(orbitsG)] do
        orb := orbitsG[i];
        orbreps := [];

        for iorb in innerorblist[i] do
            if not(orb[1] = iorb[1] and Size(iorb) = 1)
            then
                graph := List([1..LargestMovedPoint(G)], x -> []);
                if IsEmpty(orbreps) then
                    orbreps := fillRepElts(G, orb);
                fi;
                for val in orb do
                    p := orbreps[val];
                        graph[val] := List(iorb, x -> x^p);
                od;
                Add(graphlist, Digraph(graph));
            fi;
        od;
    od;
    return graphlist;
end);

InstallMethod( OrbitalGraphs, "for a transformation semigroup",
               [ IsTransformationSemigroup ],
function(S)
    # TODO: This is currently super-naive
    local bpts;

    bpts := Filtered(Tuples([1..LargestMovedPoint(S)], 2), x -> x[1] <> x[2]);

    return List(bpts, x -> DigraphByEdges(AsList(Enumerate(Orb(S, x, OnTuples)))));
end);

InstallMethod( OrbitalClosure, "for a permutation group",
               [ IsPermGroup ],
G -> Intersection(List(OrbitalGraphs(G), AutomorphismGroup)) );
# TODO: TwoClosure as implemented by Heiko Theißen requires the group
#       to be transitive.
# H := TwoClosure(G);

InstallMethod( IsOrbitalGraphRecognisable, "for a permutation group",
               [ IsPermGroup ],
function(G)
    # it holds that G <= OrbitalClosure(G), hence
    # testing for size is sufficient
    return Size(OrbitalClosure(G)) = Size(G);
end);

InstallTrueMethod(IsOrbitalGraphRecognisable,
                  IsStronglyOrbitalGraphRecognisable);

InstallMethod( OrbitalIndex, "for a permutation group",
               [ IsPermGroup ],
function(G)
    return Index(OrbitalClosure(G), G);
end);

InstallMethod( IsStronglyOrbitalGraphRecognisable, "for a permutation group",
               [ IsPermGroup ],
function(G)
    # TODO check that this is right.
    return ForAny(OrbitalGraphs(G), x -> Size(G) = Size(AutomorphismGroup(x)));
end);

InstallTrueMethod(IsStronglyOrbitalGraphRecognisable,
                  IsAbsolutelyOrbitalGraphRecognisable);

InstallMethod( IsAbsolutelyOrbitalGraphRecognisable, "for a permutation group",
               [ IsPermGroup ],
function(G)
    # TODO check that this is right.
    return ForAll(OrbitalGraphs(G), x -> Size(G) = Size(AutomorphismGroup(x)));
end);

