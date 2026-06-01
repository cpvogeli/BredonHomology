loadPackage "BredonHomology"

------------------
-- examples at p=2
------------------

R = ZZ[a..f]; -- allows for six vertices in what follows

-- constant Z coefficients
Z = makeFixedPointMackeyFunctor(2,id_(ZZ^1))
-- constant Z/2 coefficients
Z2 = makeFixedPointMackeyFunctor(2,id_(coker matrix{{2}}))
-- inflated Z coefficients
IZ = makeZeroOnUnderlyingMackeyFunctor(2,ZZ^1)
-- orbit Z coefficients
OZ = makeOrbitMackeyFunctor(2,id_(ZZ^1))

-- representation sphere S^sigma
Ssigma = makeCpSimplicialComplex(2,
	{a*b,b*c,c*d,d*a},
	{a,d,c,b,e,f})
for i to 3 do print prune bredonHomology(i,Ssigma)

-- representation sphere S^rho
Srho = makeCpSimplicialComplex(2,
	{a*b*e, b*c*e, c*d*e, a*d*e, a*b*f, b*c*f, c*d*f, a*d*f},
	{a,d,c,b,e,f})
for i to 3 do print prune bredonHomology(i,Srho)

-- representation sphere S^(2*sigma)
S2sigma = makeCpSimplicialComplex(2,
	{a*b*e, b*c*e, c*d*e, a*d*e, a*b*f, b*c*f, c*d*f, a*d*f},
	{c,d,a,b,e,f})
for i to 3 do print prune bredonHomology(i,S2sigma)

-- sphere in 3*sigma
SS3sigma = makeCpSimplicialComplex(2,
	{a*b*e, b*c*e, c*d*e, a*d*e, a*b*f, b*c*f, c*d*f, a*d*f},
	{c,d,a,b,f,e})
for i to 3 do print prune bredonHomology(i,SS3sigma)

-------------------------
-- examples at odd primes
-------------------------

p = 7;
S = ZZ[x_0..x_(p+1)];

-- representation sphere S^(lambda_a)
a = 3; -- rotate a notches
Slambda = makeCpSimplicialComplex(p,
	(for i to p-1 list x_i*x_((i+1)%p)*x_p) |
	(for i to p-1 list x_i*x_((i+1)%p)*x_(p+1)),
	(for i to p-1 list x_((i+a)%p)) | {x_p, x_(p+1)})
for i to 3 do print prune bredonHomology(i,Slambda)

-- egg-beater 
EB = makeCpSimplicialComplex(p,
	(for i to p-1 list x_i*x_p) | 
	(for i to p-1 list x_i*x_(p+1)),
	(for i to p-1 list x_((i+a)%p)) | {x_p, x_(p+1)})
for i to 3 do print prune bredonHomology(i,EB)