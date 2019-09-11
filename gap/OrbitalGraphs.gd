# OrbitalGraphs: Computations with orbital graphs in GAP
# A GAP package by Paula Hähndel, Markus Pfeiffer, and Wilf A. Wilson.
#
# SPDX-License-Identifier: MPL-2.0
#
# Declarations

#! @Chapter Orbital graphs


#! @Section Categories of orbital graphs


#! @Arguments D
#! @Description
#!   Every orbital graph that is constructed with the &OrbitalGraphs; package
#!   is a <Package>Digraphs</Package> package digraph
#!   (see <Ref Filt="IsDigraph" BookName="Digraphs" Style="Number"/>)
#!   that additionally lies in the category
#!   <Ref Filt="IsOrbitalGraph" Label="for IsDigraph"/>.
#!
#!   This makes it easy to recognise orbital graphs that were created
#!   with this package.
DeclareCategory("IsOrbitalGraph", IsDigraph);

#! @Arguments D
#! @Description
#!   Every orbital graph that is constructed from a permutation group
#!   with the &OrbitalGraphs; package lies in the category
#!   <Ref Filt="IsOrbitalGraphOfGroup" Label="for IsOrbitalGraph"/>,
#!   which is a subcategory of
#!   <Ref Filt="IsOrbitalGraph" Label="for IsDigraph"/>.
DeclareCategory("IsOrbitalGraphOfGroup", IsOrbitalGraph);

#! @Arguments D
#! @Description
#!   Every orbital graph that is constructed from a transformation semigroup
#!   with the &OrbitalGraphs; package lies in the category
#!   <Ref Filt="IsOrbitalGraphOfGroup" Label="for IsOrbitalGraph"/>,
#!   which is a subcategory of
#!   <Ref Filt="IsOrbitalGraph" Label="for IsDigraph"/>.
DeclareCategory("IsOrbitalGraphOfSemigroup", IsOrbitalGraph);


#! @Section Constructing orbital graphs


# TODO: Give a definition of orbital graphs
# TODO Document allowing the set of points (vertices) to be specified
#! @BeginGroup orbitals
#! @Arguments G
#! @Returns A list of orbital graphs
#! @Description
#!   This returns a list of all orbital graphs of the permutation group
#!   <A>G</A> or transformation semigroup <A>S</A>.
#!
#!   The order of the returned list is not specified.
DeclareAttribute("OrbitalGraphs", IsPermGroup);
#! @Arguments S
DeclareAttribute("OrbitalGraphs", IsTransformationSemigroup);
#! @Arguments G, vertices
DeclareOperation("OrbitalGraphs", [IsPermGroup, IsHomogeneousList]);
#! @EndGroup
#! @Group orbitals
#! @Arguments G, max
#! @BeginExampleSession
#! gap> D8 := Group([ (1,2,3,4), (2,4) ]);; StructureDescription(D8);
#! "D8"
#! gap> OrbitalGraphs(D8);
#! [ <self-paired orbital graph of D8 on 4 vertices with base-pair (1,3), 4 arcs>
#!     , <self-paired orbital graph of D8 on 4 vertices 
#!     with base-pair (1,2), 8 arcs> ]
#! @EndExampleSession
DeclareOperation("OrbitalGraphs", [IsPermGroup, IsInt]);


#DeclareAttribute("OrbitalGraphsRepresentative", IsPermGroup);


# TODO Once orbital graphs can be defined on arbitrary vertices:
# * Allow specifying a set of points rather than a pos int k.
# * Implement a 2-arg version with MovedPoints(G) taken as the third arg.
#! @BeginGroup orbital
#! @Returns An orbital graph
#! @Arguments G, basepair, k
#! @Description
#!   If <A>G</A> is a permutation group, <A>basepair</A> is a pair of
#!   positive integers, and `k` is a positive integer such that `[1..<A>k</A>]`
#!   is preserved by <A>G</A> and contains the entries of <A>basepair</A>,
#!   then this function returns the orbital graph of <A>G</A> with the given
#!   <A>basepair</A>, on the vertices `[1..<A>k</A>]`.
#!
#!   The resulting orbital graph will have <A>basepair</A> set as its
#!   <Ref Attr="BasePair" Label="for IsOrbitalGraph"/> attribute.
#! @EndGroup
#! @Group orbital
#! @BeginExampleSession
#! gap> D8 := DihedralGroup(IsPermGroup, 8);
#! Group([ (1,2,3,4), (2,4) ])
#! gap> OrbitalGraph(D8, [1, 3], 4);
#! <self-paired orbital graph of Group([ (1,2,3,4), (2,4) ]) on 4 vertices 
#! with base-pair (1,3), 4 arcs>
#! gap> OrbitalGraph(D8, [1, 3], 5);
#! <self-paired orbital graph of Group([ (1,2,3,4), (2,4) ]) on 5 vertices 
#! with base-pair (1,3), 4 arcs>
#! gap> G := Group([ (1,2)(3,4) ]);;
#! gap> OrbitalGraph(G, [1, 2], 2);
#! <self-paired orbital graph of Group([ (1,2)(3,4) ]) on 2 vertices 
#! with base-pair (1,2), 2 arcs>
#! @EndExampleSession
DeclareOperation("OrbitalGraph", [IsPermGroup, IsHomogeneousList, IsPosInt]);
#@Arguments G, basepair, points
#DeclareOperation("OrbitalGraph", [IsPermGroup, IsHomogeneousList, IsHomogeneousList]);
#@Arguments G, basepair
#DeclareOperation("OrbitalGraph", [IsPermGroup, IsHomogeneousList]);


#! @Section Information stored about orbital graphs at creation


# TODO define a base pair
#! @Returns A list of two positive integers
#! @Arguments D
#! @Description
#!   If <A>D</A> is an orbital graph that was constructed with respect to
#!   a specific base pair,
#!   then this attribute stores that value.
#!
#!   Otherwise, is <A>D</A> is an orbital graph of a group, then this attribute
#!   stores the least edge of <A>D</A>,
#!   i.e. `Minimum(DigraphEdges(<A>D</A>))`;
#!   see <Ref Attr="DigraphEdges" BookName="Digraphs" Style="Number"/>.
#!   If <A>D</A> is an orbital graph of a group, then this attribute stores
#!   an arbitrary base-pair of <A>D</A>.
#!
#!   Note that equal orbital graphs may have different base pairs, depending
#!   on how they were constructed.
#! @BeginExampleSession
#! gap> true;
#! true
#! @EndExampleSession
DeclareAttribute("BasePair", IsOrbitalGraph);

#! @Returns A permutation group
#! @Arguments D
#! @Description
#!   For an orbital graph <A>D</A> created from a permutation group `G`,
#!   this attribute stores the value `G`.
#!   Note that equal orbital graphs may have been created from different
#!   groups, and may therefore have different underlying groups.
#! @BeginExampleSession
#! gap> true;
#! true
#! @EndExampleSession
DeclareAttribute("UnderlyingGroup", IsOrbitalGraphOfGroup);

#! @Returns A transformation semigroup
#! @Arguments D
#! @Description
#!   For an orbital graph <A>D</A> created from a transformation semigroup `S`,
#!   this attribute stores the value `S`.
#!   Note that equal orbital graphs may have been created from different
#!   semigroups, and may therefore have different underlying semigroups.
#! @BeginExampleSession
#! gap> true;
#! true
#! @EndExampleSession
DeclareAttribute("UnderlyingSemigroup", IsOrbitalGraphOfSemigroup);


#! @Section Values computed from the orbital graphs of a group

#! @Arguments G
#! @Returns A permutation group
#! @Description
#!   The <E>orbital closure</E> of a nontrivial permutation group <A>G</A>
#!   is the intersection of the automorphism groups of all
#!   orbital graphs of the group.
#!   See <Ref Attr="OrbitalGraphs" Label="for IsPermGroup"/>.
#!   A trivial permutation group is defined to be its own orbital closure.
#!
#!   For a transitive permutation group,
#!   <Ref Attr="OrbitalClosure" Label="for IsPermGroup"/> returns the same
#!   as the &GAP; function
#!   <Ref Attr="TwoClosure" BookName="Ref" Style="Number"/>
#!   (which only applies to transitive groups).
#! @BeginExampleSession
#! gap> OrbitalClosure(PSL(2,5)) = SymmetricGroup(6);
#! true
#! gap> C6 := CyclicGroup(IsPermGroup, 6);;
#! gap> OrbitalClosure(C6) = C6;
#! true
#! gap> A4_6 := Action(AlternatingGroup(4), Combinations([1..4], 2), OnSets);;
#! gap> closure := OrbitalClosure(A4_6);
#! Group([ (3,4), (2,5), (1,2,3)(4,6,5) ])
#! gap> IsConjugate(SymmetricGroup(6),
#! >                closure, WreathProduct(Group([(1,2)]), Group([(1,2,3)])));
#! true
#! @EndExampleSession
DeclareAttribute("OrbitalClosure", IsPermGroup);

#! @Description
#!  Computes the orbital closure of a permutation group by constructing
#!  a single edge-coloured graph from all orbital graphs by assigning an edge
#!  colour to each orbital graph and taking the uninion of these coloured edges
#!  to obtain the resulting graph.
#!  The automorphism group of this graph is the same as the intersecion of the
#!  automorphism groups of all orbital graphs, but in some cases where a group
#!  has many orbital graphs, the direct computation of the automorphism group
#!  of the edge-coloured graph might be more efficient than first computing
#!  separate automorphism groups and then intersecting them in a separate step.
#!
#!  Since this is an experimental feature we just provide a separate function
#!  and don't hook this method up yet, before we evaluated whether this method
#!  works properly and mostly faster.
DeclareGlobalFunction("OrbitalClosureByColouredEdges");

#! @Arguments G
#! @Returns A positive integer
#! @Description
#!   The <E>orbital index</E> of a permutation group is its
#!   <Ref Oper="Index" BookName="Ref" Style="Number"
#!        Label="for a group and its subgroup"/>
#!   in its <Ref Attr="OrbitalClosure" Label="for IsPermGroup"/>.
#! @BeginExampleSession
#! gap> OrbitalIndex(PSL(2,5));
#! 12
#! gap> OrbitalIndex(PGL(2,5));
#! 6
#! gap> OrbitalIndex(AlternatingGroup(6));
#! 2
#! gap> OrbitalIndex(DihedralGroup(IsPermGroup, 6));
#! 1
#! @EndExampleSession
DeclareAttribute("OrbitalIndex", IsPermGroup);


#! @Section Recognising a group from its orbital graphs

#! @Arguments G
#! @Description
#!   <Index Key="IsOGR">`IsOGR`, for IsPermGroup</Index>
#!   A permutation group is **orbital graph recognisable**
#!   if and only if it is equal to its
#!   <Ref Attr="OrbitalClosure" Label="for IsPermGroup"/>,
#!   i.e. if and only if its
#!   <Ref Attr="OrbitalIndex" Label="for IsPermGroup"/> is `1`.
#!
#!   `IsOGR` is a synonym for
#!   <Ref Prop="IsOrbitalGraphRecognisable" Label="for IsPermGroup"/>.
#! @BeginExampleSession
#! gap> IsOrbitalGraphRecognisable(QuaternionGroup(IsPermGroup, 8));
#! true
#! gap> IsOGR(AlternatingGroup(8));
#! false
#! gap> IsOGR(TrivialGroup(IsPermGroup));
#! true
#! @EndExampleSession
DeclareProperty("IsOrbitalGraphRecognisable", IsPermGroup);
# TODO: When AutoDoc supports it, this should be properly linked into the doc:
DeclareSynonymAttr("IsOGR", IsOrbitalGraphRecognisable);

#! @Arguments G
#! @Description
#!   <Index Key="IsStronglyOGR">`IsStronglyOGR`, for IsPermGroup</Index>
#!   The nontrivial permutation group <A>G</A> is
#!   **strongly orbital graph recognisable (strongly OGR)** if and only if
#!   there exists **some** orbital graph of <A>G</A> whose automorphism group is
#!   <A>G</A>.
#!   The trivial permutation group is defined to be strongly OGR.
#!
#!   Note that every strongly OGR group is also orbital graph recognisable,
#!   see <Ref Prop="IsOrbitalGraphRecognisable" Label="for IsPermGroup"/>.
#!
#!   `IsStronglyOGR` is a synonym for
#!   <Ref Prop="IsStronglyOrbitalGraphRecognisable" Label="for IsPermGroup"/>.
#! @BeginExampleSession
#! gap> IsStronglyOrbitalGraphRecognisable(CyclicGroup(IsPermGroup, 8));
#! true
#! gap> IsStronglyOGR(QuaternionGroup(IsPermGroup, 8));
#! false
#! gap> IsStronglyOGR(TrivialGroup(IsPermGroup));
#! true
#! @EndExampleSession
DeclareProperty("IsStronglyOrbitalGraphRecognisable", IsPermGroup);
# TODO: When AutoDoc supports it, this should be properly linked into the doc:
DeclareSynonymAttr("IsStronglyOGR", IsStronglyOrbitalGraphRecognisable);

#! @Arguments G
#! @Description
#!   <Index Key="IsAbsolutelyOGR">`IsAbsolutelyOGR`, for IsPermGroup</Index>
#!   The permutation group <A>G</A> is
#!   **absolutely orbital graph recognisable (absolutely OGR)** if and only if
#!   **every** orbital graph of <A>G</A> has automorphism group equal to
#!   <A>G</A>.
#!
#!   Note that every absolutely OGR group is also strongly orbital graph
#!   recognisable, see
#!   <Ref Prop="IsStronglyOrbitalGraphRecognisable" Label="for IsPermGroup"/>.
#!
#!   `IsAsolutelyOGR` is a synonym for
#!   <Ref Prop="IsAbsolutelyOrbitalGraphRecognisable" Label="for IsPermGroup"/>.
#! @BeginExampleSession
#! gap> IsAbsolutelyOrbitalGraphRecognisable(DihedralGroup(IsPermGroup, 8));
#! true
#! gap> IsAbsolutelyOGR(CyclicGroup(IsPermGroup, 8));
#! false
#! gap> IsAbsolutelyOGR(TrivialGroup(IsPermGroup));
#! true
#! @EndExampleSession
DeclareProperty("IsAbsolutelyOrbitalGraphRecognisable", IsPermGroup);
# TODO: When AutoDoc supports it, this should be properly linked into the doc:
DeclareSynonymAttr("IsAbsolutelyOGR", IsAbsolutelyOrbitalGraphRecognisable);


#! @Section Attributes and properties of individual orbital graphs


#TODO document
#!
DeclareProperty("IsSelfPaired", IsOrbitalGraph);
