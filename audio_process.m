% ======================================================================
%> @brief transform audio signal based on STFT (Short Time Fourier Transform)
%>
%> @param fn: frequency transform function, with prototype `function [ Y ] = fn( X )`
%> @param x: time-domain audio signal (dimension Length X Observations)
%> @param window: window sequence (dimension WindowLength X 1)
%> @param hop_size: hop size within consecutive windows (integer, smaller than WindowLength)
%>
%> @retval y: processed audio signal (dimension Length X Observation)
% ======================================================================
function [ y ] = audio_process( fn, x, window, hop_size )
    len = size(x, 1);
    observations = size(x, 2);
    window_multi = window * ones(1, observations); % apply window to all observations
    window_size = size(window, 1);
    func = str2func(fn);

    % link_window: the window added after iFFT to ensure temporal continuity
    % its shape:   ______
    %             /      \
    overlap_size = window_size - hop_size;
    if hop_size > window_size / 2
        link_window = [linspace(0, 1, overlap_size)';ones(hop_size-overlap_size, 1);linspace(1, 0, overlap_size)'];
    else
        mag = (hop_size / overlap_size);
        link_window = [linspace(0, mag, hop_size)'; ones(overlap_size-hop_size, 1) .* mag; linspace(mag, 0, hop_size)'];
    end
    %plot(link_window)
    link_window_multi = link_window * ones(1, observations);


    % append zeros
    N = ceil((len - overlap_size) / hop_size);
    extend_length = N * hop_size + overlap_size - len;
    y = zeros(len + extend_length, observations); % allocate memory
    if extend_length > 0
        x = [x;zeros(extend_length, observations)];
    end

    for i = 0:(N-1)
        % add window before FFT to reduce spectral leakage
        x_piece = x((hop_size*i+1):(hop_size*i+window_size), :) .* window_multi;

        X = fft(x_piece);
        Y = func(X);
        y_piece = ifft(Y);

        % add link_window after iFFT
        y((hop_size*i+1):(hop_size*i+window_size), :) = ...
          y((hop_size*i+1):(hop_size*i+window_size), :) + real(y_piece) .* link_window_multi;
    end
end
