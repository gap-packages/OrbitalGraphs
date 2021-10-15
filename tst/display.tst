#
gap> START_TEST("OrbitalGraphs package: display.tst");
gap> LoadPackage("orbitalgraphs", false);;

# DotOrbitalGraph
gap> G := Group((1,2,3,4));;
gap> o := OrbitalGraphs(G);;
gap> List(o, BasePair);
[ [ 1, 2 ], [ 1, 3 ], [ 1, 4 ] ]
#@if IsPackageLoaded("digraphs", "1.4.0")
gap> Print(DotOrbitalGraph(o[1]));
//dot
digraph hgn{
node [shape=circle]
1 [label="1"]
2 [label="2"]
3 [label="3"]
4 [label="4"]
1 -> 2 [color=red]
2 -> 3
3 -> 4
4 -> 1
}
gap> Print(DotOrbitalGraph(o[2]));
//dot
graph hgn{
node [shape=circle]

1 [label="1"]
2 [label="2"]
3 [label="3"]
4 [label="4"]
1 -- 3 [color=red]
2 -- 4
}
#@else
gap> DotOrbitalGraph(o[1]);
Error, DotOrbitalGraph requires Digraphs v1.4.0 or newer
#@fi

#
gap> STOP_TEST("OrbitalGraphs package: display.tst", 0);
