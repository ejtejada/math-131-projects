% Author: Edgar Tejada
% Date : 2018-01-23

% Notice, all function definitions must come well after calls.
% This is very stange, as defining functions and then calling them
% later in a script simply fails, IMPLYING THEY MUST BE DEFINED AT
% THE END OF A SCRIPT.
x1 = myabsolutevalue(-2.3343224);
x2 = myabsolutevalue(9242.23);

screendescription= 'x1 is %4.7f in magnitude and x2 is %4.2f in magnitude\n';
fprintf(screendescription, x1, x2)


function output = myabsolutevalue(a)
% This generic checks if input a is a positive or negative real.
% and will return the magnitude of either.
    postivecheck = true; % This tell us if the input was positive or not;
    if (a < 0 && isreal(a))
        a = -1.0*a;
        poitivecheck = false; % Since it failed this check, set to false.
    end
output = a;
end
