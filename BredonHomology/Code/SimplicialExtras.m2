needsPackage "SimplicialComplexes"

SimplicialComplex == SimplicialComplex := Boolean => (X,Y) -> (
	if not ring X === ring Y then return false;
	if dim X != dim Y then return false;
	for i to dim X do 
		if faces(i,X) != faces(i,Y) then return false;
	true
)

SimplicialMap * SimplicialMap := SimplicialMap => (f,g) -> (
    map(target f, source g, (map f)*(map g))
)

SimplicialMap ^ ZZ := SimplicialMap => (f,n) -> (
    if n == 1 then return f;
    if n == 0 then return id_(source f);
    if n < 0 then error("-- inverses not implemented");
    if not source f === target f then error("-- can only iterate self-maps");
    g := f; for i to abs(n)-2 do g = f * g;
    g
)

SimplicialMap == SimplicialMap := Boolean => (f,g) -> (
    if source f != source g then return false;
    if target f != target g then return false;
    for x in faces(0,source f) do 
        if (map f)(x) != (map g)(x) then return false;
    true
)