This file describes changes in the OrbitalGraphs package.

## Unreleased

- Use the MathJax version of the HTML manual by default

## 0.1.2 (2022-02-01)

- Add `OrbitalGraph` for a group, a base pair and a positive integer
- Add `DotOrbitalGraph`
- Add categories `IsOrbitalGraph`, `IsOrbitalGraphOfGroup` and
  `IsOrbitalGraphOfSemigroup`, attributes `BasePair`, `UnderlyingGroup` and
  `UnderlyingSemigroup`, and `IsSelfPaired` as an alias for
  `IsSymmetricDigraph`
- Add a dedicated `ViewString` for orbital graphs
- Fix `OrbitalGraphs` of a semigroup returning duplicates; improve
  `OrbitalGraphs` for a trivial group
- Require GAP >= 4.11.0

## 0.1.1 (2021-09-02)

- Fix `OrbitalGraphs` for groups that fix points smaller than
  `LargestMovedPoint` (#19, #20)
- Add `OrbitalClosure` and `IsStronglyOGR` for the trivial group (#29)
- Add implications `IsAbsolutelyOGR` -> `IsStronglyOGR` -> `IsOGR` (#3)
- Return orbital graphs as a sorted list
- Add documentation for the package functions (#7)
- License the package under MPL-2.0 (#15)

## 0.1 (2018-07-26)
