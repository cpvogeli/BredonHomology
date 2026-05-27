-- functoriality of orbits and fixed points
-- conjugations c on target and d on source
-- equivariant map f
makeOrbitMackeyFunctor(ZZ,Matrix,Matrix,Matrix) := MackeyFunctorHomomorphism => (p,c,d,f) -> (
	M := makeOrbitMackeyFunctor(p,c); -- target
	N := makeOrbitMackeyFunctor(p,d); -- source
	map(M, N, f, inducedMap(M.Fixed, N.Fixed, f))
)

makeFixedPointMackeyFunctor(ZZ,Matrix,Matrix,Matrix) := MackeyFunctorHomomorphism => (p,c,d,f) -> (
	M := makeFixedPointMackeyFunctor(p,c); -- target
	N := makeFixedPointMackeyFunctor(p,d); -- source
	map(M, N, f, inducedMap(M.Fixed, N.Fixed, f))
)

-- given two composable morphisms f,g such that f*g == 0, return ker(f)/im(g)
computeHomology = method()
computeHomology(MackeyFunctorHomomorphism,MackeyFunctorHomomorphism) := CpMackeyFunctor => (f,g) -> (
	comp := f*g;
	if (comp != map(target comp, source comp, 0)) then (
		error "inputted maps do not form a complex"
	);
	i := inducedMap(source(f),ker(f));
	phi := inducedMap(ker(f),source(g),g);
	coker phi
)

-- Bredon homology with constant Z coefficients
bredonHomology = method()
bredonHomology(CpSimplicialComplex,ZZ) := CpMackeyFunctor => (X,i) -> (
	C := complex X.Underlying;
	aC := complex X.Action;
	d := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(i-1),aC_i,C.dd_i);
	d' := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_i,aC_(i+1),C.dd_(i+1));
	computeHomology(d,d')
)

-- Bredon homology with user-inputted coefficients
bredonHomology(CpSimplicialComplex,ZZ,CpMackeyFunctor) := CpMackeyFunctor => (X,i,M) -> (
	if not isCohomological M then
		error "coefficients must be cohomological Mackey functor";
	C := complex X.Underlying;
	aC := complex X.Action;
	d := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(i-1),aC_i,C.dd_i);
	d' := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_i,aC_(i+1),C.dd_(i+1));
	computeHomology(d ** M, d' ** M)
)

bredonCohomology = method()
bredonCohomology(CpSimplicialComplex,ZZ) := CpMackeyFunctor => (X,i) -> (
	C := dual complex X.Underlying;
	aC := dual complex X.Action;
	d := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(-i-1),aC_(-i),C.dd_(-i));
	d' := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(-i),aC_(1-i),C.dd_(1-i));
	computeHomology(d,d')
)



