function [symbol, new_value] = decode_symbol(value, ll, ul, verbose)
symbol = -1;
for i=1:length(ul)
    if value < ul(i)
        symbol = i; % find the right interval of symbol
        break;
    end
end
low = ll(symbol); % find the lower bound of that interval
high = ul(symbol); % find the upper bound of that interval
new_value = (value - low)/(high-low);
symbol = mod(symbol, 10);
if verbose == 1
    fprintf('Symbol is %d. New value is %f. \n', symbol, new_value);
end
end