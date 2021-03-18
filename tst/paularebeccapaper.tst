# Examples from "Questions on Orbital Graphs"
# by Paula Hähndel and Rebecca Waldecker
#
gap> START_TEST("OrbitalGraphs package: paularebeccapaper.tst");
gap> LoadPackage("orbitalgraphs", false);;

# Example 10
# a)
gap> G := Group((1,2)(3,4), (1,4)(2,3));;
gap> IsOrbitalGraphRecognisable(G);
true
gap> IsStronglyOrbitalGraphRecognisable(G);
false
gap> IsAbsolutelyOrbitalGraphRecognisable(G);
false

# b)
gap> G := Group((1,2,3,4));;
gap> IsOrbitalGraphRecognisable(G);
true
gap> IsStronglyOrbitalGraphRecognisable(G);
true
gap> IsAbsolutelyOrbitalGraphRecognisable(G);
false

# c)
gap> G := Group((1,3), (1,2)(3,4));;
gap> IsOrbitalGraphRecognisable(G);
true
gap> IsStronglyOrbitalGraphRecognisable(G);
true
gap> IsAbsolutelyOrbitalGraphRecognisable(G);
true

# d)
gap> G := AlternatingGroup(5);;
gap> IsOrbitalGraphRecognisable(G);
false

#
gap> STOP_TEST("OrbitalGraphs package: paularebeccapaper.tst", 0);
