function [new_low,new_high] = q3_encode_symbol(symbol_prev, symbol_cur, low, high, next_step, ll_condition, ul_condition)
    
    symbol_position = find(next_step{symbol_prev} == symbol_cur);
    ll = ll_condition{symbol_prev};
    ul = ul_condition{symbol_prev};
    [new_low, new_high] = encode_symbol(symbol_position, low, high, ll, ul, 0);
    fprintf(1, 'Encode symbol %d\n', mod(symbol_cur, 10));
    fprintf(1, 'New interval is [%f, %f) \n',new_low, new_high);
end