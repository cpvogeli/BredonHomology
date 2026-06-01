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

-- given a free cohomological Mackey functor, lift to a free Mackey functor
burnsideLift = method()
burnsideLift(CpMackeyFunctor) := CpMackeyFunctor => (M) -> (
    fix := select(0 .. numRows(M.Conj)-1, i -> M.Conj_(i,i) == 1);
    if #fix == 0 then return M;

    comp := matrix{for i in fix list matrix M.Conj_i};
    makeCpMackeyFunctor(M.PrimeOrder,
        M.Res | M.PrimeOrder * comp,
        matrix{for i to numRows(M.Conj)-1 list (1-M.Conj_(i,i))*(matrix M.Trans_i)} || transpose comp,
        M.Conj)
)

-- functoriality of burnsideLift
burnsideLift(MackeyFunctorHomomorphism) := MackeyFunctorHomomorphism => (f) -> (
    T := burnsideLift(target f);
    S := burnsideLift(source f);

    Tfix := select(0 .. numRows(T.Conj)-1, i -> T.Conj_(i,i) == 1);
    Sfix := select(0 .. numRows(S.Conj)-1, i -> S.Conj_(i,i) == 1);

    if #Tfix == 0 and #Sfix == 0 then return f;

    Tfree := select(0 .. numRows((target f).Trans)-1, i -> isSubset(
        image matrix id_((target f).Fixed)_i,
        image (target f).Trans
    ));
    Sfree := select(0 .. numRows((source f).Trans)-1, i -> isSubset(
        image matrix id_((source f).Fixed)_i,
        image (source f).Trans
    ));

    map(T, S, f.UnderlyingMap, 
        matrix{
            {matrix( 
                for i to numRows(f.FixedMap)-1 list 
                    for j to numColumns(f.FixedMap)-1 list 
                        if member(i,Tfree) == member(j,Sfree) then 
                            f.FixedMap_(i,j) 
                        else 
                            0
            ), 

            map(target f.FixedMap,ZZ^(#Sfix),0)}, 

            {matrix( 
                for i to numRows(f.FixedMap)-1 list (
                    if member(i,Tfree) then continue;
                    for j to numColumns(f.FixedMap)-1 list 
                        if not member(i,Tfree) and member(j,Sfree) then 
                            f.FixedMap_(i,j) 
                        else 
                            0
                )
            ) // (source f).PrimeOrder, 

            f.UnderlyingMap_(Tfix,Sfix)}
        }
    )
)

-- Bredon homology with Burnside coefficients
bredonHomology = method()
bredonHomology(ZZ,CpSimplicialComplex) := CpMackeyFunctor => (i,X) -> (
    C := complex X.Underlying;
    aC := complex X.Action;
    d := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(i-1),aC_i,C.dd_i);
    d' := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_i,aC_(i+1),C.dd_(i+1));
    computeHomology(burnsideLift(d),burnsideLift(d'))
)

-- Bredon homology with user-inputted coefficients
bredonHomology(ZZ,CpSimplicialComplex,CpMackeyFunctor) := CpMackeyFunctor => (i,X,M) -> (
    C := complex X.Underlying;
    aC := complex X.Action;
    d := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(i-1),aC_i,C.dd_i);
    d' := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_i,aC_(i+1),C.dd_(i+1));
    if isCohomological M then (
        computeHomology(d ** M, d' ** M)
    ) else (
        computeHomology(burnsideLift(d) ** M, burnsideLift(d') ** M)
    )
)

-- Bredon cohomology with constant Z coefficients
bredonCohomology = method()
bredonCohomology(CpSimplicialComplex,ZZ) := CpMackeyFunctor => (X,i) -> (
	C := dual complex X.Underlying;
	aC := dual complex X.Action;
	d := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(-i-1),aC_(-i),C.dd_(-i));
	d' := makeFixedPointMackeyFunctor(X.PrimeOrder,aC_(-i),aC_(1-i),C.dd_(1-i));
	computeHomology(d,d')
)



