function Sequence_Generator(u)

% This function generates your personalized two sequences of king movements.
%
% Please do not tamper with the MATLAB code of this function. Otherwise, we
% may not be able to locate your personalized two sequences.
%

m = 1073;
k = 131;

a = de2bi(k);

index = 1;
for i = 1:size(a,2)
    if a(i) == 1
        index = mod(mod(index, m) * mod(u, m), m);
    end
    u = mod(mod(u, m) * mod(u, m), m);
end

file_name = ['./Long_movements/king_movements_long_sequence_',num2str(index),'.txt'];
fileID = fopen(file_name, 'r');
king_movements = fscanf(fileID, '%c');
king_movements = str2num(king_movements);
fclose(fileID);

file_name = ['king_movements_long_sequence_',num2str(index),'.txt'];
fileID = fopen(file_name, 'w');
fprintf(fileID,"%d\n", king_movements);
fclose(fileID);

file_name = ['./Short_movements/king_movements_short_sequence_',num2str(index),'.txt'];
fileID = fopen(file_name, 'r');
king_movements = fscanf(fileID, '%c');
king_movements = str2num(king_movements);
fclose(fileID);

file_name = ['king_movements_short_sequence_',num2str(index),'.txt'];
fileID = fopen(file_name, 'w');
fprintf(fileID,"%d\n", king_movements);
fclose(fileID);













