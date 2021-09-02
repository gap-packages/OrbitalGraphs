#
# OrbitalGraphs: Computations with orbital graphs
#
_STANDREWSCS := Concatenation("School of Computer Science, ",
                              "University of St Andrews, ",
                              "St Andrews, Fife, KY16 9SX, Scotland");
SetPackageInfo( rec(

PackageName := "OrbitalGraphs",
Subtitle := "Computations with orbital graphs",
Version := "0.1.1",
Date := "02/09/2021", # dd/mm/yyyy format

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Markus",
    LastName := "Pfeiffer",
    WWWHome := "https://markusp.morphism.de",
    Email := "markus.pfeiffer@st-andrews.ac.uk",
    PostalAddress := _STANDREWSCS,
    Place := "St Andrews",
    Institution := "University of St Andrews",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Paula",
    LastName := "Hähndel",
    WWWHome := "https://algebra.mathematik.uni-halle.de/haehndel",
    Email := "paula.haehndel@mathematik.uni-halle.de",
    PostalAddress := Concatenation(
               "Martin-Luther-Universität Halle-Wittenberg\n",
               "06099 Halle (Saale)"),
    Place := "Halle (Saale)",
    Institution := "Martin-Luther Universität Halle-Wittenberg",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Wilf A.",
    LastName := "Wilson",
    WWWHome := "https://wilf.me",
    Email := "gap@wilf-wilson.net",
    PostalAddress := _STANDREWSCS,
    Place := "St Andrews",
    Institution := "University of St Andrews",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
#SupportEmail   := "TODO",
PackageWWWHome  := ~.SourceRepository.URL,
#TODO Publish the following webpage and use this URL instead:
#PackageWWWHome  := "https://gap-packages.github.io/OrbitalGraphs",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "OrbitalGraphs",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Computations with Orbital Graphs",
),

Dependencies := rec(
  GAP := ">=4.8.2",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ]
                         , [ "Digraphs", ">= 0.12.1"]
# We do not really need ferret, only for intersections
# of automorphism groups
#                         , [ "ferret", ">= 0.0" ]
                         ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


