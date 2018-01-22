import std.stdio;
import mir.ndslice.slice;
import mir.ndslice.topology;
import mir.ndslice.allocation;
import LinearAlgebra;

void main()
{
	
	int var = 0;
	/++
	auto A =
        [ 1,  4, -3,
         -2,  8,  5,
          3,  4,  7]
           .sliced(3, 3)
           .universal;
	auto L = slice!double(A.length, A.length).universal;
	auto U = slice!double(A.length, A.length).universal;
	+/

	/++
	auto A =
        [ 1,  3,  6,
          2,  8, 16,
	     5, 21, 45]
            .sliced(3, 3)
            .assumeContiguous;
	auto L = slice!double(A.length, A.length).assumeContiguous;
	auto U = slice!double(A.length, A.length).assumeContiguous;
	+/

	auto A =
        [ 3, -7, -2,  2,
         -3,  5,  1,  0,
          6, -4,  0, -5,
	    -9,  5, -5, 12]
            .sliced(4, 4)
            .canonical;
	auto L = slice!double(A.length, A.length).canonical;
	auto U = slice!double(A.length, A.length).canonical;

	writeln(A.LU_decomposition!(L, U));
	writeln(L[]);
	writeln(U[]);
	
}
