% Author: Edgar Tejada
% Date : 2018-01-23

%Functions calls and calculations go here: 
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
