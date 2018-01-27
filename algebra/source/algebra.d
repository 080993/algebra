module algebra;

import std.stdio;

import mir.ndslice.slice;
import mir.ndslice.topology;
import mir.ndslice.allocation;
import std.traits;

import mir.blas;
import mir.lapack;

private template IterationType(Iterator)
{
    alias T = Unqual!(typeof(Iterator.init[0]));
    static if (isIntegral!T || is(T == real))
        alias IterationType = double;
    else
    static if (is(T == creal))
        alias IterationType = cdouble;
    else
    {
        static assert(
            is(T == double) ||
            is(T == float) ||
            is(T == cdouble) ||
            is(T == cfloat));
        alias IterationType = T;
    }
}

private alias BlasType(Iterators...) =
    CommonType!(staticMap!(IterationType, Iterators));

auto LU_decomposition(SliceKind kind, Iterator)(Slice!(kind, [2], Iterator) a)
in
{
    assert (a.length!0 == a.length!1, "matrix must be square");
}
body
{
	alias T = BlasType!Iterator;
	auto m = a.as!T.slice.canonical;
	auto ipiv = m.length.uninitSlice!lapackint;
	getrf!T(m, ipiv);
	return m;
}

unittest
{
	auto A =
        [ 3, -7, -2,  2,
         -3,  5,  1,  0,
          6, -4,  0, -5,
	    -9,  5, -5, 12]
            .sliced(4, 4)
            .canonical;
	A.LU_decomposition;
}

auto LDL_decomposition(SliceKind kind, Iterator)(Slice!(kind, [2], Iterator) a)
in
{
    assert (a.length!0 == a.length!1, "matrix must be square");
}
body
{
	alias T = BlasType!Iterator;
	auto m = a.as!T.slice.canonical;
	auto ipiv = m.length.uninitSlice!lapackint;
	sytrf!T("L", m, ipiv, asd);
	return m;
}