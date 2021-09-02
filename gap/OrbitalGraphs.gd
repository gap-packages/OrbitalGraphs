#
# OrbitalGraphs: Computations with orbital graphs
#
# Declarations
#

#! @Chapter Orbital graphs

#! @Section Constructing orbital graphs

# TODO: Give a definition of orbital graphs
# TODO: Implement constructing the orbital graph with a given base pair
# TODO: Implement allowing the set of points (vertices) to be specified
#! @BeginGroup orbitals
#! @Arguments G
#! @Returns A list of digraphs
#! @Description
#!   This attribute is an immutable list of all orbital graphs of
#!   the permutation group <A>G</A>
#!   or transformation semigroup <A>S</A>.
#!
#!   The order of the returned list is not specified.
DeclareAttribute("OrbitalGraphs", IsPermGroup);
#! @EndGroup
#! @Arguments S
#! @Group orbitals
#! @BeginLogSession
#! gap> OrbitalGraphs(DihedralGroup(IsPermGroup, 8));
#! [ <immutable digraph with 4 vertices, 4 edges>, 
#!   <immutable digraph with 4 vertices, 8 edges> ]
#! @EndLogSession
DeclareAttribute("OrbitalGraphs", IsTransformationSemigroup);

#DeclareAttribute("OrbitalGraphsRepresentative", IsPermGroup);


#! @Section Values computed from orbital graphs

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
