#@local G, S
gap> START_TEST("OrbitalGraphs package: prop.tst");
gap> LoadPackage("orbitalgraphs", false);;

#
gap> G := SymmetricGroup(10);;
gap> IsOrbitalGraphRecognisable(G);
true
gap> IsStronglyOrbitalGraphRecognisable(G);
true
gap> IsAbsolutelyOrbitalGraphRecognisable(G);
true
gap> OrbitalIndex(G);
1
gap> IsomorphismGroups(G, OrbitalClosure(G)) <> fail;
true

#
gap> G := DihedralGroup(IsPermGroup, 12);;
gap> IsOrbitalGraphRecognisable(G);
true
gap> IsStronglyOrbitalGraphRecognisable(G);
true
gap> IsAbsolutelyOrbitalGraphRecognisable(G);
false
gap> OrbitalIndex(G);
1
gap> IsomorphismGroups(G, OrbitalClosure(G)) <> fail;
true

#
gap> G := TransitiveGroup(30, 126);;
gap> IsOrbitalGraphRecognisable(G);
false
gap> IsStronglyOrbitalGraphRecognisable(G);
false
gap> IsAbsolutelyOrbitalGraphRecognisable(G);
false
gap> OrbitalIndex(G);
119439360000
gap> IsomorphismGroups(G, OrbitalClosure(G)) <> fail;
false

#
gap> S := Semigroup(Transformation([1,1,1]), Transformation([3,3,3]));;
gap> OrbitalGraphs(S);;

#
gap> G := Group(GeneratorsOfGroup(SymmetricGroup(20)));;
gap> IsOGR(G);
true
gap> IsStronglyOGR(G);
true
gap> IsAbsolutelyOGR(G);
true

#
gap> G := Group(GeneratorsOfGroup(AlternatingGroup(20)));;
gap> IsOGR(G);
false
gap> IsStronglyOGR(G);
false
gap> IsAbsolutelyOGR(G);
false

#
gap> STOP_TEST("OrbitalGraphs package: prop.tst", 0);
