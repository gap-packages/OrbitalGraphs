#
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
