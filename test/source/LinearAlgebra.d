/++
linear algebra: matrices.
$(BOOKTABLE $(H2 Kind Selectors),
$(TR $(TH Function Name) $(TH Description))

$(T2 LU_decomposition, decompos matrix A, into two factors, a unit lower triangular matrix L and an upper triangular matrix U.)

Authors:   Sergey Batratskiy
+/

module LinearAlgebra;
import std.stdio;

/++
LU_decomposition, decompos matrix A, into two factors, a unit lower triangular matrix L and an upper triangular matrix U.

Params:
    Matrix A
    Matrix L
    Matrix U
Returns:
    execution code
+/

int LU_decomposition(alias L, alias U, T)(T arr) {
	
	if((L.length != arr.length) || (U.length != arr.length))
		return -1;
	
	L[] = 0;
	double tmp;
	for(int i = 0; i < arr.length; ++i)
		L[i][i] = 1;
	U[] = arr[];

	for(int col = 0; col < arr.length - 1; ++col) {
	
		for(int row = col + 1; row < arr.length; ++row) {
		
			tmp = -U[row][col] / U[col][col];
			L[row][col] = -tmp;
			U[row][col] = 0;
			for(int i = col + 1; i < arr.length; ++i)
				U[row][i] += U[col][i] * tmp;
		
		}
	
	}

	return 1;
	
}
