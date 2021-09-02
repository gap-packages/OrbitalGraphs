#
# OrbitalGraphs: Computations with orbital graphs
#
# Declarations
#

#! @Description
#!   This attribute is an immutable list of all orbital graphs of
#!   a transformation semigroup or permutation group
DeclareAttribute("OrbitalGraphs", IsPermGroup);
#DeclareAttribute("OrbitalGraphsRepresentative", IsPermGroup);
DeclareAttribute("OrbitalGraphs", IsTransformationSemigroup);

#! @Description
#!   The <E>orbital closure</E> of a permutation group <M>G</M>
#!   is the intersection of the automorphism groups of all
#!   orbital graphs of the group.
DeclareAttribute("OrbitalClosure", IsPermGroup);

#! @Description
#!   The <E>orbital index</E> of a permutation group <M>G</M>
#!   is the index <M>G</M> in <C>OrbitalClosure(G)</C>.
DeclareAttribute("OrbitalIndex", IsPermGroup);

#! @Description
#!   The group <M>G</M> is <E>orbital graph recognisable</E>
#!   if <M>G = OrbitalClosure(G)</M>.
DeclareProperty("IsOrbitalGraphRecognisable", IsPermGroup);


#! @Description
#!  TODO
DeclareProperty("IsStronglyOrbitalGraphRecognisable", IsPermGroup);

#! @Description
#!  TODO
DeclareProperty("IsAbsolutelyOrbitalGraphRecognisable", IsPermGroup);

# TODO: Sebastian tells me this is dangerous.
DeclareSynonym("IsOGR", IsOrbitalGraphRecognisable);
DeclareSynonym("IsStronglyOGR", IsStronglyOrbitalGraphRecognisable);
DeclareSynonym("IsAbsolutelyOGR", IsAbsolutelyOrbitalGraphRecognisable);


