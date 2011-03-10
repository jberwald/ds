function [ a_new, done_new ] = comb_next ( n, k, a, done )

%% COMB_NEXT computes combinations of K things out of N.
%
%  Discussion:
%
%    The combinations are computed one at a time, in lexicographical order.
%
%  Modified:
%
%    19 July 2004
%
%  Reference:
%
%    Charles Mifsud,
%    Combination in Lexicographic Order,
%    ACM algorithm 154,
%    Communications of the ACM, 
%    March 1963.
%
%  Parameters:
%
%    Input, integer N, the total number of things.
%
%    Input, integer K, the number of things in each combination.
%
%    Input, integer A(K), the output value of A_NEW on the previous call.
%    This value is not needed on a startup call.
%
%    Input, logical DONE, should be set to FALSE on the first call,
%    and thereafter set to the output value of DONE_NEW on the previous call.
%
%    Output, integer A_NEW(K), the next combination.
%
%    Output, logical DONE_NEW, is TRUE if the routine can be called
%    again for more combinations, and FALSE if there are no more.
%
  done_new = done;

  if ( done_new )

    a_new(1:k) = i4vec_indicator ( k );

    if ( 1 < k )
      done_new = 0;
    else
      done_new = 1;
    end

  else

    a_new(1:k) = a(1:k);

    if ( a_new(k) < n )
      a_new(k) = a_new(k) + 1;
      return
    end

    for i = k : -1 : 2

      if ( a_new(i-1) < n-k+i-1 )

        a_new(i-1) = a_new(i-1) + 1;

        for j = i : k
          a_new(j) = a_new(i-1) + j - ( i-1 );
        end

        return

      end

    end

    done_new = 1;

  end
