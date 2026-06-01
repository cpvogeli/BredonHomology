newPackage(
    "BredonHomology",
    Version=>"1.0",
    Date=>"May 20, 2026",
    Authors=>{
        {Name=>"Chase Vogeli",
            Email=>"cpv29@cornell.edu",
            HomePage=>"https://chasevoge.li"}
    },
    Headline => "Bredon equivariant homology of simplicial complexes",
    Keywords => {"Homotopy Theory", "Equivariant Cohomology"},
    PackageExports => {"SimplicialComplexes", "CpMackeyFunctors"},
    AuxiliaryFiles => true,
)

load "./BredonHomology/Code/SimplicialExtras.m2"

load "./BredonHomology/Code/CpSimplicialComplex.m2"
export {
    "CpSimplicialComplex",
    "makeCpSimplicialComplex",
    "Action",
}

load "./BredonHomology/Code/Homology.m2"
export {
    "bredonHomology",
    "bredonCohomology"
}

beginDocumentation()

load "./BredonHomology/Tests/HomologyTests.m2"


end
