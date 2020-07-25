clear;
clc;
% Sequence_Generator(205418959);

% stationary probability for digit 1--9
prob = [3/40, 5/40, 3/40, 5/40, 8/40, 5/40, 3/40, 5/40, 3/40];
[ll,ul] = get_ll_ul(prob,1/15); % get corresponding ll and ul

% open the file
index = 595;
file_name = ['king_movements_short_sequence_',num2str(index),'.txt'];
fileID = fopen(file_name, 'r');
king_movements_short = fscanf(fileID, '%c');
king_movements_short = str2num(king_movements_short);
fclose(fileID);

N = length(king_movements_short);
king_movements_short(N) = 10;
source = king_movements_short;


low = 0.0;
high = 1.0;
idx = 1;
code_bits = [];

% start encoding
while idx <= length(source)
    [low,high] = encode_symbol(source(idx), low, high, ll, ul, 1);
    idx = idx + 1;
    if ~(low > 0.5 || high < 0.5)
        continue
    end
    while true
        [low, high, bit] = send_bit(low, high);
        if bit == -1
            break
        end
        code_bits = [code_bits, bit];
    end
end

code_bits = [code_bits, 1]; % send 1 at last to guarantee that <eot> is received
fprintf('Send 1 at last to guarantee that <eot> is received\n\n');
value = binary2real(code_bits);
format long;
fprintf('The value is %f\n\n', value);
fprintf('The code is: \n');
disp(code_bits);


