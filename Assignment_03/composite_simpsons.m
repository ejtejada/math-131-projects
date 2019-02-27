%Author: Edgar Tejada
%Contributors:
%		Tomny Hang
%		Luis Mejia
%		SE User Merin:
%		See: https://math.stackexchange.com/q/1742223

function I = composite_simpsons(f, a, b, n)
	h = (b - a)./n;
	I = f(a) + f(b); %Add the two end points
	for (j=1:2:(n-1)) %Add the odd values of n.
		xjay=(a + j.*h);
		I = I + 4.*f(xjay);
	end
	for (k=2:2:(n-2)) %Add the even values of n.
		xjay = (a + k.*h);
		I = I + 2.*f(xjay);
	end
	I = (h./3).*I; % Scale to the midpoints
end

