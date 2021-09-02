# OrbitalGraphs: Computations with orbital graphs
# A GAP package by Paula Hähndel, Markus Pfeiffer, and Wilf A. Wilson.
#
# SPDX-License-Identifier: MPL-2.0
#
# This file is a script which compiles the package manual.

if fail = LoadPackage("AutoDoc", "2016.02.16") then
    Error("AutoDoc version 2016.02.16 or newer is required.");
fi;

AutoDoc( rec(
    autodoc := true,
    scaffold := true,
    extract_examples := rec(
        skip_empty_in_numbering := false,
    ),
    gapdoc := rec(
        gap_root_relative_path := true,
    ),
) );
