% ======================================================================
%> @brief randomize phases of FFT bins, while ensure imaginary parts of iFFT results are zero
%>
%> @param X: frequency-domain audio signal (dimension FFTLength X Observations)
%>
%> @retval Y: processed frequency-domain audio signal (dimension FFTLength X Observations)
% ======================================================================
function [ Y ] = random_angle( X )
        magX = abs(X);
        angX = angle(X);
        Xsize = size(X, 1);
        channel = size(X, 2);
        if mod(Xsize, 2) == 0
            before_center = Xsize/2;
            angX(2:before_center, :) = -pi + 2*pi*rand(before_center - 2 + 1, channel);
            angX(before_center+2:Xsize, :) = -angX(before_center:-1:2, :);
        else
            before_center = (Xsize+1)/2;
            angX(2:before_center, :) = -pi + 2*pi*rand(before_center - 2 + 1, channel);
            angX(before_center+1:Xsize, :) = -angX(before_center:-1:2, :);
        end
        Y = magX .* exp(1i * angX);
end
