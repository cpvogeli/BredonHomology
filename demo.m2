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
for i to 3 do print prune bredonHomology(i,sigmaSphereComplex(R))

-- representation sphere S^rho
for i to 3 do print prune bredonHomology(i,rhoSphereComplex(R))

-- representation sphere S^(2*sigma)
for i to 3 do print prune bredonHomology(i,sigma2SphereComplex(R))

-- 2-sphere with antipodal action
for i to 3 do print prune bredonHomology(i,antipodalSphereComplex(2,R))

-- 4-sphere with antipodal action - slow!
for i to 4 do print prune bredonHomology(i,antipodalSphereComplex(4,ZZ[x_1..x_10]))

-------------------------
-- examples at odd primes
-------------------------

p = 7;
S = ZZ[x_0..x_(p+1)];

-- representation sphere S^(lambda_2)
for i to 3 do print prune bredonHomology(i,lambdaSphereComplex(p,2,S))

-- egg-beater 
for i to 3 do print prune bredonHomology(i,eggBeaterComplex(p,S))