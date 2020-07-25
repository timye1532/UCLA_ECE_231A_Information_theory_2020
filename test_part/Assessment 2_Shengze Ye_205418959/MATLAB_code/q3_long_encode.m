clear;
clc;

next_step = cell(1, 9);
next_step{1} = [2,4,5,10];
next_step{2} = [1,3,4,5,6,10];
next_step{3} = [2,5,6,10];
next_step{4} = [1,2,5,7,8,10];
next_step{5} = [1,2,3,4,6,7,8,9,10];
next_step{6} = [2,3,5,8,9,10];
next_step{7} = [4,5,8,10];
next_step{8} = [4,5,6,7,9,10];
next_step{9} = [5,6,8,10];

start_prob = [3/40, 5/40, 3/40, 5/40, 8/40, 5/40, 3/40, 5/40, 3/40];
condition_prob_1379 = [1/3, 1/3, 1/3];
condition_prob_2468 = [1/5, 1/5, 1/5, 1/5, 1/5];
condition_prob_5 = [1/8, 1/8, 1/8, 1/8, 1/8, 1/8, 1/8, 1/8];

[ll_start,ul_start] = get_ll_ul(start_prob,1/100);
ll_condition = cell(1, 9);
ul_condition = cell(1, 9);
for i = 1:9
    if (i == 1 || i == 3 || i == 7 || i == 9)
        [ll_condition{i}, ul_condition{i}] = get_ll_ul(condition_prob_1379, 1/100);
    elseif (i == 2 || i == 4 || i == 6 || i == 8)
        [ll_condition{i}, ul_condition{i}] = get_ll_ul(condition_prob_2468,1/100);
    else
        [ll_condition{i}, ul_condition{i}] = get_ll_ul(condition_prob_5,1/100);
    end
end



index = 595;
file_name = ['king_movements_long_sequence_',num2str(index),'.txt'];
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
[low,high] = encode_symbol(source(idx), low, high, ll_start, ul_start, 0);
fprintf(1, 'Encode symbol %d\n', source(idx));
fprintf(1, 'New interval is [%f, %f) \n',low, high);
idx = idx + 1;
while true
    [low, high, bit] = send_bit(low, high);
    if bit == -1
        break
    end
    code_bits = [code_bits, bit];
end

while idx <= length(source)
    prev_symbol = source(idx - 1);
    cur_symbol = source(idx);
    [low,high] = q3_encode_symbol(prev_symbol, cur_symbol, low, high, next_step, ll_condition, ul_condition);
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
fprintf('Send 1 at last to guarantee that <eot> is received\n');
value = binary2real(code_bits);
format long;
fprintf('The value is %f\n', value);

%entropy rate
H = 2.24;
R = length(code_bits)/10000;
excess_redundancy = 100 * (R-H)/H;
fprintf("Excess redundancy is: %f percent", excess_redundancy);
