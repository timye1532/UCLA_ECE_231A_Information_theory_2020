fprintf('Decode process for question 3 short sequence\n\n');
decode_sequence = [];
value = binary2real(code_bits);
format long;
fprintf('The value is: \n');
disp(value);

[symbol, value] = decode_symbol(value, ll_start, ul_start, 0);
decode_sequence = [decode_sequence, symbol];
fprintf('Symbol is %d. New value is %f. \n', symbol, value);

while true
    symbol_prev = symbol;
    [symbol, value] = q3_decode_symbol(value, symbol_prev, next_step, ll_condition, ul_condition);
    if symbol == 0
        decode_sequence = [decode_sequence, 0];
        break;
    end
    decode_sequence = [decode_sequence, symbol];
end