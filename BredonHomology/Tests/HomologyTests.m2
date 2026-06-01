TEST ///

debug(BredonHomology)

p = 5;
A = makeBurnsideMackeyFunctor p;
B = makeUnderlyingFreeMackeyFunctor p;
Z = makeFixedPointMackeyFunctor(p, id_(ZZ^1));

assert(burnsideLift B == B);
assert(burnsideLift Z == A);

-- homology of RP^3 with trivial action and Burnside coefficients
R = ZZ[x_1 .. x_11];
RP3 = realProjectiveSpaceComplex(3,R);
X = makeCpSimplicialComplex(p,id_RP3);

assert(prune bredonHomology(0,X) == makeZeroMackeyFunctor(p));
assert(prune bredonHomology(1,X) == coker(2*(id_A)));
assert(prune bredonHomology(2,X) == makeZeroMackeyFunctor(p));
assert(prune bredonHomology(3,X) == A);

///