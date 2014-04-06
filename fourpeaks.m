% ======================================================================
%> @brief extract four peaks on magnitude spectrum while ensure imaginary parts of iFFT results are zero
%>
%> @param X: frequency-domain audio signal (dimension FFTLength X Observations)
%>
%> @retval Y: processed frequency-domain audio signal (dimension FFTLength X Observations)
% ======================================================================
function [ Y ] = fourpeaks( X )
    n = 4;  % TODO: does MATLAB has closure?

    magX = abs(X);
    len = size(X, 1);
    channel = size(X, 2);
    if mod(len, 2) == 0
        center = len/2+1;
    else
        center = (len+1)/2;
    end

    Y = zeros(len, channel);  % allocate memory

    for col = 1:channel
        magX(1:center, col);
        pos = maxnpos(magX(1:center, col), n);
        for i = 1:n
            j = pos(i);
            Y(j, col) = X(j, col);
            if j ~= 1
                symmetry = len - (j - 1) + 1;
                Y(symmetry, col) = X(symmetry, col);
            end
        end
    end
end
