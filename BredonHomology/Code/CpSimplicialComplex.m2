needsPackage "SimplicialComplexes"

CpSimplicialComplex = new Type of HashTable

isWellDefined CpSimplicialComplex := Boolean => X -> (
    -- Ensure all the keys are present
    if not (X#?PrimeOrder and X#?Action and X#?Underlying) then (
        print "-- Hashtable does not have correct keys"; return false
    );

    -- Check that the input p is actually a prime number
    if not (instance(X.PrimeOrder,ZZ) and isPrime(X.PrimeOrder)) then (
        print "-- p is not prime"; return false
    );

    -- Check underlying is a well-defined simplicial complex
    if not instance(X.Underlying, SimplicialComplex) then return false;
    if not isWellDefined X.Underlying then return false;

    -- Check action is a well-defined simplicial map with correct (co)domain
    if not instance(X.Action, SimplicialMap) then return false;
    if not isWellDefined X.Action then return false;
    if source X.Action != X.Underlying or target X.Action != X.Underlying then 
        return false;

    -- Check action has correct order
    if not X.Action^(X.PrimeOrder) == id_(X.Underlying) then (
        print "-- action does not have order p"; return false
    );

    true
)

makeCpSimplicialComplex = method()

-- make a CpSimplicialComplex by specifying an order p simplicial self-map
makeCpSimplicialComplex(ZZ,SimplicialMap) := CpSimplicialComplex => (p,a) ->(
    X := new CpSimplicialComplex from {
        symbol PrimeOrder => p,
        symbol Underlying => source a,
        symbol Action => a,
        symbol cache => new CacheTable
        };
    if not isWellDefined X then error "CpSimplicialComplex not well-defined";
    X
)

-- make a CpSimplicialComplex from:
-- a list of faces and
-- a list specifying an order p permutation of variables
makeCpSimplicialComplex(ZZ,List,List) := CpSimplicialComplex => (p,F,a) ->(
	U := simplicialComplex F;
	X := new CpSimplicialComplex from {
		symbol PrimeOrder => p,
		symbol Underlying => U,
		symbol Action => map(U,U,a),
		symbol cache => new CacheTable
	};
	if not isWellDefined X then error "CpSimplicialComplex not well-defined";
	X
)

-- Equality
CpSimplicialComplex == CpSimplicialComplex := Boolean => (X,Y) -> (
    X.PrimeOrder == Y.PrimeOrder and 
    X.Underlying == Y.Underlying and 
    X.Action == Y.Action
)

