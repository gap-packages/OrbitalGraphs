#
# OrbitalGraphs: Computations with orbital graphs
#
# Implementations
#

# The code below was originally essentially stolen from ferret.
# Do we want to give different versions of this:
#   a naive version that just computes all orbital graphs,
#   a version that only gives a representative in the isomorphism class, and
#   a version that gives the ones actually used in backtrack?
#
InstallMethod(OrbitalGraphs, "for a permutation group (super basic)", [IsPermGroup],
function(G)
  local pts, graphs, stab, innerorbits, orb, iorb;

  # Commented out lines give the behaviour of the original OrbitalGraphs method

  pts := MovedPoints(G);
  #pts := [1 .. LargestMovedPoint(G)];
  graphs := [];
  for orb in Orbits(G, pts) do
    stab := Stabilizer(G, orb[1]);
    innerorbits := Orbits(stab, MovedPoints(stab));
    #innerorbits := Orbits(stab, Difference(pts, [orb[1]]));
    for iorb in innerorbits do
      AddSet(graphs, EdgeOrbitsDigraph(G, [orb[1], iorb[1]]));
    od;
  od;
  return graphs;
end);

# TODO decide what to do about non-moved points

InstallMethod(OrbitalGraphs, "for a permutation group (uses stab chain)", [IsPermGroup],
function(G)
    local orb, orbitsG, iorb, graph, graphlist, val, p, i, innerorblist,
          orbreps, fillRepElts, maxval;

  # TODO: Option?
  maxval := LargestMovedPoint(G);

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
  innerorblist := List(orbitsG, o -> Orbits(Stabilizer(G, o[1]), [1..LargestMovedPoint(G)]));

  for i in [1..Length(orbitsG)] do
    orb := orbitsG[i];
    orbreps := [];

    for iorb in innerorblist[i] do
      if orb[1] <> iorb[1] then
        graph := List([1..LargestMovedPoint(G)], x -> []);
        if IsEmpty(orbreps) then
          orbreps := fillRepElts(G, orb);
        fi;
        for val in orb do
          p := orbreps[val];
          graph[val] := List(iorb, x -> x ^ p);
        od;
        AddSet(graphlist, Digraph(graph));
      fi;
    od;
  od;
  return graphlist;
end);


InstallMethod(OrbitalGraphs, "for a permutation group (no stab chain)", [IsPermGroup],
function(G)
  local n, gens, seen, reps, graphs, root, D, orbit, schreier_gens, b, schreier_gen, innerorbits, a, i, inner;

  n := LargestMovedPoint(G);
  gens := GeneratorsOfGroup(G);
  seen := BlistList([1 .. n], []);
  reps := [];
  graphs := [];

  repeat
    root := First([1 .. n], x -> not seen[x]);
    seen[root] := true;
    reps[root] := ();
    orbit := [root];
    schreier_gens := [];

    # Construct a basic Schreier tree for <root> and Schreier generators for stabiliser of <root>
    for a in orbit do
      for i in [1 .. Length(gens)] do
        b := a ^ gens[i];
        if not seen[b] then
          reps[b] := reps[a] * gens[i];
          seen[b] := true;
          Add(orbit, b);
        else
          schreier_gen := reps[a] * gens[i] * reps[b] ^ -1;
          Add(schreier_gens, schreier_gen);
        fi;
      od;
    od;

    # Compute the orbits of the stabilizer of <root>, and hence the orbital graphs
    if not IsTrivial(orbit) then
      innerorbits := Orbits(Group(schreier_gens));
      for inner in innerorbits do
        AddSet(graphs, EdgeOrbitsDigraph(G, [orbit[1], inner[1]]));
      od;
    fi;

  until SizeBlist(seen) = n;
  return graphs;
end);

InstallMethod(OrbitalClosure, "for a permutation group", [IsPermGroup],
G -> Intersection(List(OrbitalGraphs(G), AutomorphismGroup)));
# TODO: TwoClosure as implemented by Heiko Theißen requires the group
#       to be transitive.
# H := TwoClosure(G);

InstallMethod(OrbitalIndex, "for a permutation group", [IsPermGroup],
{G} -> Index(OrbitalClosure(G), G));

InstallMethod(IsOrbitalGraphRecognisable, "for a permutation group",
[IsPermGroup],
# It holds that G <= OrbitalClosure(G), hence testing for size is sufficient
{G} -> Size(OrbitalClosure(G)) = Size(G));

InstallMethod(IsStronglyOrbitalGraphRecognisable, "for a permutation group",
[IsPermGroup],
# TODO check that this is right
{G} -> ForAny(OrbitalGraphs(G), x -> Size(G) = Size(AutomorphismGroup(x))));

InstallMethod(IsAbsolutelyOrbitalGraphRecognisable, "for a permutation group",
[IsPermGroup],
# TODO check that this is right.
{G} -> ForAll(OrbitalGraphs(G), x -> Size(G) = Size(AutomorphismGroup(x))));

InstallTrueMethod(IsStronglyOrbitalGraphRecognisable,
                  IsAbsolutelyOrbitalGraphRecognisable);
InstallTrueMethod(IsOrbitalGraphRecognisable,
                  IsStronglyOrbitalGraphRecognisable);

# Transformation Semigroups

InstallMethod(OrbitalGraphs, "for a transformation semigroup",
[IsTransformationSemigroup],
function(S)
    # FIXME This is currently super-naive
    local bpts;

    bpts := Arrangements([1..LargestMovedPoint(S)], 2);
    return List(bpts, x -> DigraphByEdges(AsList(Enumerate(Orb(S, x, OnTuples)))));
end);
