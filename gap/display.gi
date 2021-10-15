# OrbitalGraphs: Computations with orbital graphs in GAP
# A GAP package by Paula Hähndel, Markus Pfeiffer, and Wilf A. Wilson.
#
# SPDX-License-Identifier: MPL-2.0
#
# Implementations

if not IsBound(DIGRAPHS_DotDigraph) then
    BindGlobal("DIGRAPHS_DotDigraph", function(arg...)
        ErrorNoReturn("DotOrbitalGraph requires Digraphs v1.4.0 or newer");
    end);
    BindGlobal("DIGRAPHS_DotSymmetricDigraph", DIGRAPHS_DotDigraph);
fi;

InstallMethod(DotOrbitalGraph, "for an orbital graph", [IsOrbitalGraph],
function(D)
    local func, pair, vfunc, efunc, out;
    
    if IsSelfPaired(D) and not DigraphHasLoops(D) then
        func := DIGRAPHS_DotSymmetricDigraph;
        pair := Set(BasePair(D));
    else
        func := DIGRAPHS_DotDigraph;
        pair := BasePair(D);
    fi;

    out := OutNeighbours(D);
    vfunc := i -> StringFormatted(" [label=\"{}\"]", DigraphVertexLabel(D, i));
    efunc := function(i, j)
        if pair[1] = i and pair[2] = out[i][j] then
            return " [color=red]";
        fi;
        return "";
    end;

    return func(D, [vfunc], [efunc]);
end);
