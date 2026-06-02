-- constructs the hyperoctahedron as a simplicial complex
-- n is the topological dimension (i.e. the maximal faces are n-dimensional,
-- and the resulting complex models the n-sphere)
hyperoctahedralComplex = method()
hyperoctahedralComplex(ZZ,PolynomialRing) := SimplicialComplex => (n,R) -> (
    if numgens R < 2*(n+1) then (
        error("expected polynomial ring with >= 2*(n+1) variables")
    );
    simplicialComplex(
        for f in toList((set{0,n+1})^**(n+1)/deepSplice) list 
            product(for i to n list R_(i+f_i))
    )
)

-- circle S^1 with C2-action by reflection
sigmaSphereComplex = method()
sigmaSphereComplex(PolynomialRing) := CpSimplicialComplex => (R) -> (
    if numgens R < 4 then (
        error("expected polynomial ring with >= 4 variables")
    );
    makeCpSimplicialComplex(2,
        {R_0*R_2, R_0*R_3, R_1*R_2, R_1*R_3},
        {R_0 => R_1, R_1 => R_0}
    )
)

-- 2-sphere with C2-action by reflection across a plane
rhoSphereComplex = method()
rhoSphereComplex(PolynomialRing) := CpSimplicialComplex => (R) -> (
    if numgens R < 6 then (
        error("expected polynomial ring with >= 6 variables")
    );
    makeCpSimplicialComplex(2,
        {R_0*R_2*R_4, R_0*R_2*R_5, R_0*R_3*R_4, R_0*R_3*R_5,
            R_1*R_2*R_4, R_1*R_2*R_5, R_1*R_3*R_4, R_1*R_3*R_5},
        {R_0 => R_1, R_1 => R_0}
    )
)

-- 2-sphere with C-2 action by half-turn rotation
sigma2SphereComplex = method()
sigma2SphereComplex(PolynomialRing) := CpSimplicialComplex => (R) -> (
    if numgens R < 6 then (
        error("expected polynomial ring with >= 6 variables")
    );
    makeCpSimplicialComplex(2,
        {R_0*R_2*R_4, R_0*R_2*R_5, R_0*R_3*R_4, R_0*R_3*R_5,
            R_1*R_2*R_4, R_1*R_2*R_5, R_1*R_3*R_4, R_1*R_3*R_5},
        {R_0 => R_1, R_1 => R_0, R_2 => R_3, R_3 => R_2}
    )
)

-- 2-sphere with antipodal C2-action
antipodalSphereComplex = method()
antipodalSphereComplex(ZZ,PolynomialRing) := CpSimplicialComplex => (n,R) -> (
    X := hyperoctahedralComplex(n,R);
    makeCpSimplicialComplex(2,
        map(X,X, map(R,R,
            flatten for i to n list {R_i => R_(i+n+1), R_(i+n+1) => R_i}
        ))
    )
)

-- 2-sphere with Cp-action by rotation
lambdaSphereComplex = method()
lambdaSphereComplex(ZZ,ZZ,PolynomialRing) := CpSimplicialComplex => (p,a,R) -> (
    if not(isPrime(p) and p%2 != 0) then (
        error("expected p to be an odd prime")
    );
    if numgens R < p+2 then (
        error("expected polynomial ring with >= p+2 variables")
    );
    makeCpSimplicialComplex(p,
	(for i to p-1 list R_i*R_((i+1)%p)*R_p) | 
        (for i to p-1 list R_i*R_((i+1)%p)*R_(p+1)),
	(for i to p-1 list R_i => R_((i+a)%p))
    )
)

eggBeaterComplex = method()
eggBeaterComplex(ZZ,PolynomialRing) := CpSimplicialComplex => (p,R) -> (
    if not(isPrime(p) and p%2 != 0) then (
        error("expected p to be an odd prime")
    );
    if numgens R < p+2 then (
        error("expected polynomial ring with >= p+2 variables")
    );
    makeCpSimplicialComplex(p,
	(for i to p-1 list R_i*R_p) | (for i to p-1 list R_i*R_(p+1)),
	(for i to p-1 list R_i => R_((i+1)%p))
    )
)

