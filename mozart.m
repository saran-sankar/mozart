clc;

filename = 'Mozart-symphony-40.wav';

[y,Fs] = audioread(filename);
duration = audioinfo(filename).Duration;
total_length = Fs*duration;
samples = [1,total_length];

[z,Fs] = audioread(filename,samples);

%play
%sound(z,Fs);

%initialize
start = 1;
length = total_length/2;

while 1
    
    %original sample
    f = z(start:start+length-1,1);

    %corr = corr_fft(f,f);
    %display(sum(corr));

    %plot(corr, '.');
    max_corr = 0;
    pos = 1;

    for i=start+length:220500:total_length-length-1
        g = z(i:i+length-1,1);
        corr = corr_fft(f,g);
        if sum(corr) > max_corr
            max_corr = sum(corr);
            pos = i; 
        end
    end

    %discovered sample
    g = z(pos:pos+length-1,1);
    
    if max_corr>1e+10
        break;
    end
    
    length=length-220500;
    
end

%plot(0)
%plot(corr, '.')
%hold on;
%plot(xcorr(f,g));

%play the orignal and discovered samples 
%sound(f,Fs);
%sound(g,Fs);

%display(sum(corr));

function corr = corr_fft(f,g)
    F = fft(f);
    G = fft(g);
    corr = fft(conj(F).*G);
end
