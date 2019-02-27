%Author: Edgar Tejada
%Contributors:
%		Judith Mendoza
%		Tomny Hang
%		Dr. Douglas Wilhelm Harder
%		SEE: https://ece.uwaterloo.ca/~dwharder/NumericalAnalysis/13Integration/comptrap/matlab.html
function I = composite_trapezoid(f, a, b, n)
	h = (b - a)./n;
	I = f(a) + f(b); %Add the two end points
	%for (j = 1; j < (n-1); j++) %Loop through (n-1) times
	for (j=1:1:(n-1))
		xjay=(a + j.*h);
		I = I + 2.*f(xjay);
	end
	I = (h./2).*I; % Scale to the midpoints
end
%Is there a better way?
%function Ilittle = trapazoid_rule(f,a,b)
%	h= (b − a)./2; %Define the step size.
%	Ilittle = h./2 *(f(a) + f(b));
%end
