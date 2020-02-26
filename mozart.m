clc;

filename = 'Mozart-symphony-40.wav';

[y,Fs] = audioread(filename);

samples = [1,25*Fs];

[z,Fs] = audioread(filename,samples);

%play 25s
%sound(z,Fs);

start = 60000;
length = 100000;

%original sample
f = z(start:start+length,1);

corr = corr_fft(f,f);
%display(sum(corr));

%plot(corr, '.');
max_corr = 0;
pos = 0;

for i=200000:1000:1000000
    g = z(i:i+length,1);
    corr = corr_fft(f,g);
    if sum(corr) > max_corr
        max_corr = sum(corr);
        pos = i;
        %break;
    end
end

%discovered sample
g = z(pos:pos+length,1);

plot(corr, '.')
hold on;
plot(xcorr(f,g));

%play the orignal and discovered samples 
%sound(f,Fs);
%sound(g,Fs);

display(sum(corr)); 

function corr = corr_fft(f,g)
    F = fft(f);
    G = fft(g);
    corr = fft(conj(F).*G);
end
