% Author: Edgar Tejada
% Date : 2018-01-23

% Notice, all function definitions must come well after calls.
% This is very stange, as defining functions and then calling them
% later in a script simply fails, IMPLYING THEY MUST BE DEFINED AT
% THE END OF A SCRIPT.
x1 = mysum(20)
x2 = mysum(100)

function output = mysum(n)
% This generic function adds up the integers between 0 and n.
    k = 0; % Initialize a holder k to zero to avoid garbage data.
    for i = 0:n 
        k = k + i;
    end
output = k;
end
