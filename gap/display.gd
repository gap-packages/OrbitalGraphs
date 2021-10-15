# OrbitalGraphs: Computations with orbital graphs in GAP
# A GAP package by Paula Hähndel, Markus Pfeiffer, and Wilf A. Wilson.
#
# SPDX-License-Identifier: MPL-2.0
#
# Declarations

#! @Chapter Visualising orbital graphs

#! @Section Visualing an orbital graph via the DOT format

#! @Arguments D
#! @Returns A string
#! @Description
#! <B>Warning:</B> This function requires version 1.4.0 of the Digraphs package,
#! or newer.
#!
#! Given an orbital graph <A>D</A>, this function returns a string
#! that contains a description of <A>D</A> in DOT format.
#!
#! The edge of <A>D</A> corresponding to its
#! <Ref Attr="BasePair" Label="for IsOrbitalGraph"/>
#! is coloured red, while the remaining edges are coloured black.
#!
#! The DOT string for <A>D</A> can then be compiled and displayed with the
#! <Ref Func="Splash" BookName="Digraphs"/> function of the Digraphs package.
#!
#! See <URL>https://en.wikipedia.org/wiki/DOT_(graph_description_language)</URL>
#! for more information about this format.
#! @BeginLogSession
#! gap> G := Group([(1,2,3)]);;
#! gap> o := OrbitalGraphs(G);;
#! gap> Print(DotOrbitalGraph(o[1]));
#! //dot
#! digraph hgn{
#! node [shape=circle]
#! 1 [label="1"]
#! 2 [label="2"]
#! 3 [label="3"]
#! 1 -> 2 [color=red]
#! 2 -> 3
#! 3 -> 1
#! }
#! gap> Splash(DotOrbitalGraph(o[1])); # To visualise
#! @EndLogSession
DeclareAttribute("DotOrbitalGraph", IsOrbitalGraph);
