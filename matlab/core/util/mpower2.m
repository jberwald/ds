% mpower2 - Evaluate matrix to a power for integer power
%*************************************************************************************
% 
%  MATLAB (R) is a trademark of The Mathworks (R) Corporation
% 
%  Function:    mpower2
%  Filename:    mpower2.m
%  Programmer:  James Tursa
%  Version:     1.1
%  Date:        November 11, 2009
%  Copyright:   (c) 2009 by James Tursa, All Rights Reserved
%
%  This code uses the BSD License:
%
%  Redistribution and use in source and binary forms, with or without 
%  modification, are permitted provided that the following conditions are 
%  met:
%
%     * Redistributions of source code must retain the above copyright 
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright 
%       notice, this list of conditions and the following disclaimer in 
%       the documentation and/or other materials provided with the distribution
%      
%  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
%  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
%  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
%  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
%  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
%  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
%  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
%  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
%  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
%  POSSIBILITY OF SUCH DAMAGE.
% 
%  mpower2 evaluates matrix to a power for an integer power faster
%  than the MATLAB built-in function mpower. The speed improvement
%  apparently comes from the fact that mpower does an unnecessary
%  matrix multiply as part of the algorithm startup, whereas mpower2
%  only does necessary matrix multiplies. e.g.,
%
%  >> A = rand(2000);
%  >> tic;A^1;toc
%     Elapsed time is 6.047194 seconds.
%  >> tic;mpower2(A,1);toc
%     Elapsed time is 0.001882 seconds.
%
%  For sparse matrices, mpower does not do the unnecessary matrix
%  multiply. However, in this case mpower2 is apparently more
%  memory efficient. e.g.,
%
%  >> A = sprand(5000,5000,.01);
%  >> tic;A^1;toc
%     Elapsed time is 0.038530 seconds.
%  >> tic;mpower2(A,1);toc
%     Elapsed time is 0.036335 seconds.
%  >> tic;A^2;toc
%     Elapsed time is 3.248792 seconds.
%  >> tic;mpower2(A,2);toc
%     Elapsed time is 2.160705 seconds.
%  >> tic;A^3;toc
%     Elapsed time is 10.005085 seconds.
%  >> tic;mpower2(A,3);toc
%     Elapsed time is 10.020719 seconds.
%  >> tic;A^4;toc
%     ??? Error using ==> mpower
%     Out of memory. Type HELP MEMORY for your options.
%  >> tic;mpower2(A,4);toc
%     Elapsed time is 133.682037 seconds.
%
%   Y = mpower2(X,P), is X to the power P for integer P. The power
%   is computed by repeated squaring. If the integer is negative,
%   X is inverted first.  X must be a square matrix. 
%
%   Class support for inputs X, P:
%      float: double, single
%
%  Caution: Since mpower2 does not do the unnecessary startup matrix
%  multiply that mpower does, the end result may not match mpower exactly.
%  But the answer will be just as accurate.
% 
%  Change Log:
%  Nov 11, 2009: Updated for sparse matrix input --> sparse result
%
%**************************************************************************

function Y = mpower2(X,p)
%\
% Check the arguments
%/
if( nargin ~= 2 )
    error('MATLAB:mpower2:InvalidNumberOfArgs','Need two input arguments.');
end
if( nargout > 1 )
    error('MATLAB:mpower2:TooManyOutputArgs','Too many output arguments.');
end
classname = superiorfloat(p,X);
if( numel(p) ~= 1 )
    error('MATLAB:mpower2:InvalidP','P must be a scalar.');
end
if( ~isreal(p) )
    error('MATLAB:mpower2:InvalidP','P must be real.');
end
if( floor(p) ~= p )
    error('MATLAB:mpower2:InvalidP','P must be an integer.');
end
z = size(X);
if( length(z) > 2 || z(1) ~= z(2) )
    error('MATLAB:mpower2:NonSquareMatrix','Matrix must be square.');
end
if( isempty(X) )
    if( issparse(X) )
        Y = sparse(z(1),z(2));
    else
        Y = zeros(z,classname);
    end
    return
end
%\
% Special cases use custom code that is faster than binary decomposition
%/
if( p == 0 )
    if( issparse(X) )
        Y = diag(sparse(ones(z(1),1)));
    else
        Y = eye(z,classname);
    end
    return
end
if( p < 0 )
    X = inv(X);
    p = abs(p);
end
if( p == 1 )
    Y = X;
    return
elseif( p == 2 )
    Y = X * X;
    return
elseif( p == 3 )
    Y = X * X * X;
    return
elseif( p == 15 )
    X2 = X * X;
    Y = X * X2;
    Y = Y * X2;
    Y = Y * Y * Y;
    return
elseif( p == 31 )
    X2 = X * X;
    Y = X * X2;
    Y = Y * X2;
    Y = Y * Y;
    Y = Y * Y * Y * X;
    return
elseif( p == 63 )
    Y = X * X;
    X3 = X * Y;
    Y = X3 * Y;
    Y = Y * Y;
    Y = Y * Y;
    Y = Y * Y * Y * X3;
    return
end
%\
% Get the binary decomposition of the power as a row of binary characters.
%/
bp = dec2bin(p);
%\
% Loop through the bit positions from least significant to most significant
%/
Y = [];
P = X;
zz = size(bp,2);
for n=zz:-1:1
%\
% If the bit position is 1, then we need to apply the current power of X
% to the result. P is the current power of X, i.e. P = X^(2^(zz-n))
%/
    if( bp(n) == '1' )
        if( isempty(Y) )
            Y = P;
        else
            Y = Y * P;
        end
    end
%\
% Square the current power of X, but not if it is the last index in the
% loop because in that case it won't be used or needed. For some reason,
% P * P is a lot faster than P^2.
%/
    if( n ~= 1 )
        P = P * P;
    end
end
if( isa(Y,'double') && isequal(classname,'single') )
    Y = single(Y);
end
return
end
