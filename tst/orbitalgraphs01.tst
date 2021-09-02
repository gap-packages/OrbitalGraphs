# OrbitalGraphs, chapter 1
#
# DO NOT EDIT THIS FILE - EDIT EXAMPLES IN THE SOURCE INSTEAD!
#
# This file has been generated by AutoDoc. It contains examples extracted from
# the package documentation. Each example is preceded by a comment which gives
# the name of a GAPDoc XML file and a line range from which the example were
# taken. Note that the XML file in turn may have been generated by AutoDoc
# from some other input.
#
gap> START_TEST("orbitalgraphs01.tst");

# doc/_Chapter_Orbital_graphs.xml:110-122
gap> OrbitalClosure(PSL(2,5)) = SymmetricGroup(6);
true
gap> C6 := CyclicGroup(IsPermGroup, 6);;
gap> OrbitalClosure(C6) = C6;
true
gap> A4_6 := Action(AlternatingGroup(4), Combinations([1..4], 2), OnSets);;
gap> closure := OrbitalClosure(A4_6);
Group([ (3,4), (2,5), (1,2,3)(4,6,5) ])
gap> IsConjugate(SymmetricGroup(6),
>                closure, WreathProduct(Group([(1,2)]), Group([(1,2,3)])));
true

# doc/_Chapter_Orbital_graphs.xml:138-147
gap> OrbitalIndex(PSL(2,5));
12
gap> OrbitalIndex(PGL(2,5));
6
gap> OrbitalIndex(AlternatingGroup(6));
2
gap> OrbitalIndex(DihedralGroup(IsPermGroup, 6));
1

# doc/_Chapter_Orbital_graphs.xml:174-181
gap> IsOrbitalGraphRecognisable(QuaternionGroup(IsPermGroup, 8));
true
gap> IsOGR(AlternatingGroup(8));
false
gap> IsOGR(TrivialGroup(IsPermGroup));
true

# doc/_Chapter_Orbital_graphs.xml:205-212
gap> IsStronglyOrbitalGraphRecognisable(CyclicGroup(IsPermGroup, 8));
true
gap> IsStronglyOGR(QuaternionGroup(IsPermGroup, 8));
false
gap> IsStronglyOGR(TrivialGroup(IsPermGroup));
true

# doc/_Chapter_Orbital_graphs.xml:236-243
gap> IsAbsolutelyOrbitalGraphRecognisable(DihedralGroup(IsPermGroup, 8));
true
gap> IsAbsolutelyOGR(CyclicGroup(IsPermGroup, 8));
false
gap> IsAbsolutelyOGR(TrivialGroup(IsPermGroup));
true

#
gap> STOP_TEST("orbitalgraphs01.tst", 1);
