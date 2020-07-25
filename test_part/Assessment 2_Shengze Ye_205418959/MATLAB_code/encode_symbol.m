function [new_low,new_high] = encode_symbol(symbol, low, high, ll, ul, verbose)

range = high - low;
%format long;
new_low = low + ll(symbol) * range;
new_high = low + ul(symbol) * range;
if verbose == 1
    fprintf(1, 'Encode symbol %d\n', symbol);
    fprintf(1, 'New interval is [%f, %f) \n',new_low, new_high);
end
end