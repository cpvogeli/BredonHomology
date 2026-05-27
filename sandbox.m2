loadPackage "BredonHomology"

R = ZZ[a..f] -- allows for six vertices in what follows

-- examples for p-2

-- circle
X = simplicialComplex({a*b,b*c,c*d,d*a})
-- 2-sphere
Y = simplicialComplex({a*b*e, b*c*e, c*d*e, a*d*e, a*b*f, b*c*f, c*d*f, a*d*f})

-- representation sphere S^sigma
Ssigma = makeCpSimplicialComplex(2,map(X,X,{a,d,c,b,e,f}))
for i to 3 do print prune bredonHomology(Ssigma,i)

-- representation sphere S^rho
Srho = makeCpSimplicialComplex(2,map(Y,Y,{a,d,c,b,e,f}))
for i to 3 do print prune bredonHomology(Srho,i)

-- representation sphere S^2*sigma
S2sigma = makeCpSimplicialComplex(2,map(Y,Y,{c,d,a,b,e,f}))
-- example with constant Z/2 coefficients
Z2 = makeFixedPointMackeyFunctor(2,id_(coker matrix{{2}}))
for i to 3 do print prune bredonHomology(S2sigma,i,Z2)

-- sphere in 3*sigma
SS3sigma = makeCpSimplicialComplex(2,map(Y,Y,{c,d,a,b,f,e}))
-- reduced cohomology of RP^2 at C_2-level
for i to 3 do print prune bredonCohomology(SS3sigma,i)

-- examples for odd primes

p = 7;
S = ZZ[x_0..x_(p+1)]

-- 2-sphere with p many vertices on the equator
Z = simplicialComplex((for i to p-1 list x_i*x_((i+1)%p)*x_p) |
    (for i to p-1 list x_i*x_((i+1)%p)*x_(p+1)))

-- representation sphere S^lambda_a
a = 2; -- rotate a notches
Slambda = makeCpSimplicialComplex(p,map(Z,Z, 
    (for i to p-1 list x_((i+a)%p)) | {x_p, x_(p+1)}))
for i to 3 do print prune bredonHomology(Slambda,i)
