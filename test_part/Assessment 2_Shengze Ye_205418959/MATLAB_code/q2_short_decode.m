decode_bits = [];
value = binary2real(code_bits);
disp("The value is: ")
disp(value)
while true
      [symbol, value] = decode_symbol(value, ll, ul, 1);
      %disp(symbol)
      if symbol == 0
          decode_bits = [decode_bits, 0];
          break
      end
      decode_bits = [decode_bits, symbol];
end