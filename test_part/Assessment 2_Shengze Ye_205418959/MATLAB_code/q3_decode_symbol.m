function [symbol, new_value] = q3_decode_symbol(value, symbol_prev, next_step, ll_condition, ul_condition)
    ll = ll_condition{symbol_prev};
    ul = ul_condition{symbol_prev};
    [symbol_position, new_value] = decode_symbol(value, ll, ul, 0);
    symbol_real = next_step{symbol_prev}(symbol_position);
    symbol = symbol_real;
    symbol = mod(symbol, 10);
    fprintf('Symbol is %d. New value is %f. \n', symbol, new_value);

end