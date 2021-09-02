#
gap> START_TEST("OrbitalGraphs package: orbitalgraphs.tst");
gap> LoadPackage("orbitalgraphs", false);;

# Issue 19
gap> graphs := OrbitalGraphs(Group([(3,4), (5,6)]));;
gap> Length(graphs);
4
gap> Set(graphs, x -> Minimum(DigraphEdges(x)));
[ [ 3, 4 ], [ 3, 5 ], [ 5, 3 ], [ 5, 6 ] ]
gap> Number(graphs, IsSymmetricDigraph);
2

# S50product: disjoint S50 x C2 x C2 x S50 x C2 x C2 x D8 on [3 .. 114]
gap> S50product := Group(
> [ ( 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,
>      27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,
>      51,52), (3,4), (53,54), (55,56),
>   ( 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
>       75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92,
>      93, 94, 95, 96, 97, 98, 99,100,101,102,103,104,105,106), (57,58),
>   (107,108), (109,110), (111,112,113,114), (112,114) ] );
<permutation group with 10 generators>
gap> orbitals := OrbitalGraphs(S50product);;
gap> ForAll(orbitals, D -> IsDigraph(D) and DigraphNrVertices(D) = 114);
true
gap> List(orbitals, DigraphNrEdges);
[ 2, 2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8, 
  8, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 
  100, 100, 200, 200, 200, 200, 2450, 2450, 2500, 2500 ]
gap> Number(orbitals, IsSymmetricDigraph);
8
gap> Set(orbitals, x -> Minimum(DigraphEdges(x)));
[ [ 3, 4 ], [ 3, 53 ], [ 3, 55 ], [ 3, 57 ], [ 3, 107 ], [ 3, 109 ], 
  [ 3, 111 ], [ 53, 3 ], [ 53, 54 ], [ 53, 55 ], [ 53, 57 ], [ 53, 107 ], 
  [ 53, 109 ], [ 53, 111 ], [ 55, 3 ], [ 55, 53 ], [ 55, 56 ], [ 55, 57 ], 
  [ 55, 107 ], [ 55, 109 ], [ 55, 111 ], [ 57, 3 ], [ 57, 53 ], [ 57, 55 ], 
  [ 57, 58 ], [ 57, 107 ], [ 57, 109 ], [ 57, 111 ], [ 107, 3 ], [ 107, 53 ], 
  [ 107, 55 ], [ 107, 57 ], [ 107, 108 ], [ 107, 109 ], [ 107, 111 ], 
  [ 109, 3 ], [ 109, 53 ], [ 109, 55 ], [ 109, 57 ], [ 109, 107 ], 
  [ 109, 110 ], [ 109, 111 ], [ 111, 3 ], [ 111, 53 ], [ 111, 55 ], 
  [ 111, 57 ], [ 111, 107 ], [ 111, 109 ], [ 111, 112 ], [ 111, 113 ] ]

# Klein 4-group
gap> G := Group([(1,2)(3,4), (1,3)(2,4)]);;
gap> Set(OrbitalGraphs(G), Graph6String);
[ "CK", "CQ", "C`" ]

# Trivial group
gap> trivial := TrivialGroup(IsPermGroup);;
gap> OrbitalClosure(TrivialGroup(IsPermGroup)) = trivial;
true
gap> IsOGR(TrivialGroup(IsPermGroup));
true
gap> IsStronglyOGR(TrivialGroup(IsPermGroup));
true
gap> IsAbsolutelyOGR(TrivialGroup(IsPermGroup));
true

#
gap> STOP_TEST("OrbitalGraphs package: orbitalgraphs.tst", 0);
