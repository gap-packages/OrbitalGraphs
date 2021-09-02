# Helper functions and prototypes that will be (re)moved.

# TODO
# LoadPackage("francy");

# SplashDigraph := function(d)
#     local canvas, graph, nodes, v, e, i;
# 
#     v := DigraphVertices(d);;
#     e := DigraphEdges(d);;
# 
#     graph := Graph(GraphType.DIRECTED);;
#     canvas := Canvas(Concatenation("Splash Digraph"));;
#     Add(canvas, graph);;
# 
#     nodes := [];;
# 
#     for i in v do
#         nodes[i] := Shape(ShapeType.CIRCLE, String(i));;
#         Add(graph, nodes[i]);;
#     od;
# 
#    for i in e do
#       Add(graph, Link(nodes[i[1]], nodes[i[2]]));;
#    od;
#
#    return Draw(canvas);
#end;

#nubb := function(L)
#    local cls, ccls, ll;
#
#    ll := ShallowCopy(L);
#    cls := [];
#
#    while not IsEmpty(ll) do
#        Add(cls, ll[1]);
#        ccls := ll[1];
#        ll := Filtered(ll, x -> not IsIsomorphicDigraph(x, ccls));
#    od;
#
#    return cls;
#end;
#
