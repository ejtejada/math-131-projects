%Author:
%		Edgar Tejada
%Contributors: 
%		Tomny Hang
%		Judith Mendoza
%		SE User 'N.C. Rolly'
%		See: https://stackoverflow.com/q/3400515
function y = Lagrange_poly(xinterval,datx,daty)
	n = length(datx);
	funcholder= cell(n);
	%The above creates an n by n cell to store anonymous functions. This is very memory wasteful, but I don't yet know a better way.
	%Note to future-self: Cell assignment looks like this: testcell{column,row} = @(x) x.^2
	%prod = 1; 
	%Initiate the dummy output function to 1;
	%prod = @(x) (1*x.^0);

	for (j=1:1:n) %Make the jth lagrange
		for (k = 1:1:n) %find the kth product of said lagrange
			if (j == k) %%Does the row equal the column #?
				funcholder{j,k} = @(x) (daty(j).*(x).^0);
				%%This adds the f(x_j) to the product.
			else
				funcholder{j,k}= @(x) ((x - datx(k))./(datx(j) - datx(k)));
				%The above hold the kth element of the jth legrange interpolant.
			end
		end
	end
	%I added this needless complexity just to have an actual symbolic representation of the L(x) without importing Octave's symbolic library. Unfortunately, now we need to make another messy for loop to generate the function, and hopefully seamlessly pass the xinteveral array to generate the y-output array.
	
	%Forgive the wastefulness, create an nXn cell to store the individual legrange interpolants only at h==i. Lets call the cell 'L.'
	L= cell(n);
	%# find empty cells, courtesy of 'N.C. Rolly.'
	emptyCells = cellfun(@isempty,L);
	%# remove empty cells, courtesy of 'N.C. Rolly.'
	L(emptyCells) = @(x) (x.^0); %%Dirty Initialize
	for (h = 1:1:n)
		for (i = 1:1:n)
				L{h,h} = @(x) (L{h,h}(x).*funcholder{h,i}(x));
				%Multiply all of the ith elemenths of the hth row, get the ith Legrange term as a function.
		end
	end
	
	%Flatten the damn cell!
	trueL = {};
	for (g = 1:1:n) 
		trueL{end + 1} = @(x) (L{g,g}(x));
	end
	%Now add the damn hth legranges into P(x), to get a true and proper polynomial.
	%FYI, I could pass P as the output and it would, IMO, have far more usefulness than passing a vector of outputs.
	P = @(x) (x.*0);
	for (a = 1:1:n)
		P = @(x) (P(x) + trueL{a}(x));
	end
	%Now lets fill y with the outputs of P(x) in our xinterval.
	len=length(xinterval);
	y=1:1:len;
	%The above generates a dummy y-vector.
	fprintf('\nThe size of output array is %d\n', len)
	%The above is just a quick sanity check.
	%Now, say a quick prayer so that ram to disk caching doesn't cause a house fire. Finally, pass the x-interval vector as input to the the polynomial stored at P.
	y=P(xinterval);
	
	%for (a=1:1:len)
		%y(a) = P(xinterval(a));
	%end

end
