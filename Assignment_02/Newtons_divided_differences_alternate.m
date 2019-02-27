%Author:
%		Edgar Tejada
%Contributors: 
%		Tomny Hang
%		Judith Mendoza
%		Fabian Santiago %<3%
%		Luke Kostrikin
%		Vivian Yuan
%		Jarett Indalecio
function y = Newtons_divided_differences_alternate(x,datx,daty)
	n = length(datx);
	F = zeros(n,n); % Make an n by matrix of zeroes;
	p = @(x) (1.*x);
	%y = 1:1:length(x); %Is this needed?
	for (a=1:1:n)
		F(a,1) = daty(a); % Copy the daty into the first row column
		%F(1,a) = daty(a); % Copy the daty into the first row column
	end
	%Notice, we have n-1 degrees  because we have n data points to build the polynomial.
	%Build a square matrix but only built the lower left triangle
	
	%We will build the F matrix with two for loops.
	%Generally, to build an iXj matrix:
	%	F(i, j) = [F(i, j-1 ) - F(i-1, j-1)]./ [Dx(I) - Dx(I-J+1)]; %Thank you Fabian!
	
	%for (j = 2:1:n)
	%	for(i = j:1:n) %Thank you Fabian!
	for ( i = 1:1:n)
		for (j = 2:1:i)
			F(i,j) = (F(i, j-1) - F(i-1, j-1))./(datx(i) - datx( i - j +1)); %%Fill the damn matrix
		end
	end
	
	%NOW GENERATE THE POLYNOMIAL
	%p = @(x) (p(x).*0 + F(1,1) );
	%for (k = (n-1):-1:1)
	%	p = @(x) (F(k,k) + (x - datx(k)).*p(x));
	%	%p = @(x) (p(x) + 5.*x.^(n-k));
	%end
	%y = p(x);
	y = F(n,n);
	
	%weird manipulation happens now
	for (k=n-1:-1:1)
		y=y.*(x - datx(k)) + F(k,k);
	end
end
