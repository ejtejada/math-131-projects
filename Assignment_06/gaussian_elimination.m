function [U, f ] = gaussian_elimination(A,b)

	n = length(A(:,1)); %nxn
	eliminator = 1:1:n; %Allocate memory
	%Verify the first row is a valid eliminator vector
	U=A; %Make copy
	f=b; %Make copy
	if (U(1,1)~=0)
		eliminator = U(1,:);
	else	%Find a valid eliminator vector and swap!
		for (i = 2:1:n)
			if (U(i,1)~=0)
				linalg::swapRow(U,1,i); %Verify this is CCW
				eliminator = U(1,:);
				break
			end
		end
	end
	%Now we have a valid eliminator vector, do gaussian elimination
	for	(j = 1:1:n)s
	for (i = (j+1):1:n)
		c = -U(i, j)./eliminator(i); %Eliminating coeff.
		%e(i) = c*e(i-1)+e(i)
		U(i,:) = c.*eliminator+U(i,:);
		%Do the same operation on f.
		f(i) = c.*f(i-1)+f(i);
		
	end	
	%Now replace the eliminator
		eliminator = U(i,:); %Fix this, make this checked in the above for loop to prevent zero nullspace shenanigans.
		
	end %End for loop that does principal Gaussain-Elimination
	
end	%End the function
