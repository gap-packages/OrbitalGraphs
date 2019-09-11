#
# OrbitalGraphs: Computations with Orbital Graphs
#
# Declarations
#

#! @Description
#!   This attribute is an immutable list of all orbital graphs of
#!   a transformation semigroup or permutation group.
DeclareAttribute("OrbitalGraphs", IsPermGroup);

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


