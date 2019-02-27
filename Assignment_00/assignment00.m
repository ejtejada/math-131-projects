% Prevent Octave from thinking that this
% is a function file:

1;

% Author: Edgar Tejada
% Date : 2018-01-24

% Notice, all function definitions must come well after calls.
% This is very stange, as defining functions and then calling them
% later in a script simply fails, IMPLYING THEY MUST BE DEFINED AT
% THE END OF A SCRIPT.

%Exercise_One:
% Function definitions and declarations go here:
fprintf('Exercise One:\n')
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


%Functions calls and calculations go here: 
%Exercise Two
fprintf('Exercise Two:\n')
x1 = myabsolutevalue(-2.3343224);
x2 = myabsolutevalue(9242.23);
screendescription= 'x1 is %4.7f in magnitude and x2 is %4.2f in magnitude.\n';

% Function definitions and declarations go here:
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

%Exercise_Three:
% Function definitions and declarations go here:
atest = 0;
atest1 = myabsolutevalue(atest);

fprintf('Exercise Three:\n')
fprintf( 'The absolute value of ')
fprintf('a is:\n')
atest1

%Exercise Four
%Functions calls and calculations go here: 
fprintf('Exercise Four:\n')
v1 = [1,1,1]; % First vector;
x1 = vectornorm(v1)

v2 = [1/sqrt(2), 0, 1/sqrt(2)]; % Second vector;
x2 = vectornorm(v2)

v3 = 0:0.01:1; % Third vector;
x3 = vectornorm(v3)

% Function definitions and declarations go here:
function norm = vectornorm(x)
% This generic checks calculates the magnitude to a vector of any n+1 dimensional size and than outputs a normalized vector's (L^2-Norm). 
	
	rawmagnitude = 0; % This will hold the sum of the squares of the vector elements before we sqrt it.
	for (i = 1:length(x))
		rawmagnitude = rawmagnitude + x(i)*x(i);
	end
	
	rawmagnitude = sqrt(rawmagnitude); % Get the magnitude to normalize the original vector.
	
	norm = rawmagnitude;
	%return the L^2-Norm, 'norm'.
	%So, I guess we are not returning the normalized vector v./||V|| quite yet.
end

%Exercise Five
%Functions calls and calculations go here: 
%First, lets try and make some vectors for the two dimensions.
xinterval = -4 : 0.0001 : 4;
yinterval = -2 : 0.0001 : 2;
%Now lets put these parameters into the functions. Perhaps y was not needed to the same fine degree, but I am assuming a 2D 'meshwidth' of 0.0001 implies little grid blocks of 0.0001 by 0.0001.
fprintf('Exercise Five:\nSee graphs.\n')
plot(xinterval, sin(xinterval), 'color','-b', 'Linewidth', 2)
grid on;
hold on;
plot(xinterval, cos(xinterval), 'color','-r', 'Linewidth', 2)
xlabel('x');
ylabel('y');
set(gca,'ytick',yinterval);
set(gca,'ylim',[-2, 2])
legend(vsbl);
hold off;

% Prevent Octave from thinking that this
% is a function file: We need some random declaration to maximize octave-matlab compatibility.

1;


%Exercise Six
fprintf('Exercise Six:\nSee graphs.\n')
%Functions calls and calculations go here: 
%First, lets try and make some vectors for the two dimensions.
xinterval2 = -6 : 0.0001 : 6;

%Now lets put these parameters into the functions. Perhaps y was not needed to the same fine degree, but I am assuming a 2D 'meshwidth' of 0.0001 implies little grid blocks of 0.0001 by 0.0001.
fprintf('Exercise Five:\nSee graphs.\n')
plot(xinterval2, atan(xinterval2), 'color','-b', 'Linewidth', 2)
grid on;
hold on;
%I couldn not find consistent documentation on asymptote configuration, so it has been omitted.
xlabel('x');
ylabel('y=arctan(x)');
set(gca,'ytick',yinterval);
set(gca,'ylim',[-2, 2])
hold off;

%Exercise Seven
fprintf('Exercise Seven has been omitted.')
