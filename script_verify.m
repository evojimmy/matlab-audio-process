my_wavfile = 'yesterday.wav';
my_window_sizes = [256 512 1024];% 2048 4096 8192 16384 32768];
my_hop_ratio = 0.3; % hop_size / window_size
my_fn = 'no_change';


[x, fs] = wavread(my_wavfile);
base = basename(my_wavfile, 'wav');

for i = 1:size(my_window_sizes, 2)
    l = my_window_sizes(i);
    filename = [base '_' my_fn '_' num2str(l) '.wav'];
    ['Generating ' filename '...']
    y = audio_process(my_fn, x, hamming(l), floor(l*my_hop_ratio));
    wavwrite(y, fs, filename);
end
'Done'
