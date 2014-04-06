my_wavfile = 'singing.wav';
my_window_sizes = [256 512 1024 2048 4096 8192 16384 32768];
my_hop_ratio = [0.9]; % hop_size / window_size
my_fn = 'fourpeaks';  % fourpeaks or random_angle


[x, fs] = wavread(my_wavfile);
base = basename(my_wavfile, 'wav');

for j = 1:size(my_hop_ratio, 2)
    h = my_hop_ratio(j);
    for i = 1:size(my_window_sizes, 2)
        l = my_window_sizes(i);
        filename = [base '_' my_fn '_window' num2str(l) '_hop' num2str(h)  '.wav'];
        ['Generating ' filename '...']
        y = audio_process(my_fn, x, hamming(l), floor(l*h));
        wavwrite(y, fs, filename);
    end
end
'Done'
