function [ll, ul] = get_ll_ul(prob, eof)
if (eof ~= 0)
    prob = prob.*(1-eof);
    prob = [prob, eof];
end

N = length(prob);

ll = zeros(1,N);
ul = ones(1,N);

for i=2:N
    ll(i) = ll(i-1) + prob(i-1);
    ul(i-1) = ll(i);
end

end