function  a = i4vec_indicator ( n )

%% I4VEC_INDICATOR sets a vector to the indicator vector.
%
%  Modified:
%
%    18 November 2003
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of entries in the vector.
%
%    Output, integer A(N), the vector with entries (1, 2, ..., N ).
%
  a = ( 1 : n );
