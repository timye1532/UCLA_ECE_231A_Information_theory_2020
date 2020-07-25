function [new_low, new_high, bit] = send_bit(low, high)

bit = -1;
new_low = low;
new_high = high;

if (high < 0.5)
    bit = 0;
elseif (low > 0.5)
    bit = 1;
    new_low = new_low - 0.5;
    new_high = new_high - 0.5;
end

if (bit > -1)
    new_low = new_low * 2;
    new_high = new_high * 2;
    fprintf('Send bit %d \n', bit);
    fprintf('New interval is [%f, %f).\n', new_low, new_high);
end


end