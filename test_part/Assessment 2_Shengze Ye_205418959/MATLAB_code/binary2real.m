function [r] = binary2real(bits)
r = 0.0;
for k=1:length(bits)
    r = r + bits(k) * 2^(-k);
end