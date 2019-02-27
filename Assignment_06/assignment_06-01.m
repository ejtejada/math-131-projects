1;
%Author: Edgar Tejada
%Contributor:	Vivian Yuan
%				Tomny Hang
%Main Script goes here:
A = [6, 1, 7, 7, 6, 1, 8; 7, 5, 5, 2, 7, 8, 7; 9, 5, 3, 4, 4, 4, 3; 9, 8, 1, 6, -1, 8, 2; 1, 4, 5, 3, 3, 3, 7; 1, 3, 2, 7, 4, 7, 9; 6, 6, -2, 3, 2, 3, 3];
b= [6, 4, 8, 7, 1, 8, 9];
b=transpose(b); %Make the b vector a column vector
[U,f] = gaussian_elimination(A,b); %Generate U and f, the upper triangular forms of A and b.
x = backward_substitution(U,f); %Find the solution for Ax=b using U*x=f
x0 = A\b; %Stores the actual solution
Err = abs(x0 - x);
MaxErr= max(Err);
fprintf('The max error between our method and the builtin matrix solver is %e', MaxErr)
%The error between our method and the builtin is in the order of 10^-15. This means we are super close the 'true'
%Result, so much so this error might be just from float point arithmetic or cosmic background radiation.
%Function definitions go here;
function [U, f] = gaussian_elimination(A,b)

	n = length(A(:,1)); %nxn
	%eliminator = 1:1:n; %Allocate memory
	%Verify the first row is a valid eliminator vector
	U=A; %Make copy
	f=b; %Make copy
	if (U(1,1)~=0)
		eliminator = U(1,:);
	else	%Find a valid eliminator vector and swap!
		for (i = 2:1:n)
			if (U(i,1)~=0)
				swapRow(U,1,i); %Verify this is CCW
				eliminator = U(1,:);
				break
			end
		end
	end
	%Now we have a valid eliminator vector, do gaussian elimination
	for (j = 1:1:n)%Column count
         %Now replace the eliminator
		eliminator = U(j,:); %Fix this, make this checked in the above for loop to prevent zero nullspace shenanigans.
	for (i = (j+1):1:n)
		c = -U(i, j)./eliminator(j); %Eliminating coeff.
		%e(i) = c*e(j)+e(i)
		U(i,:) = c.*eliminator+U(i,:);
		%Do the same operation on f.
		f(i) = c.*f(j)+f(i);
		
	end	
	
		
	end %End for loop that does principal Gaussain-Elimination
	
	%Verify uniqueness of solution
	if (abs(U(n,n)) == 0)
		printf('\nWARNING, NO UNIQUE SOLUTION EXISTS. PLEASE SEEK FURTHER ASSISTANCE.\nThis incident has been reported.\n')
		return; %Will this end the above calling function?
	end
end	%End the function

%The below function implements backwards substitution for valid U, F systems. 
function x = backward_substitution(U,f)
	n = length(U(1,:)); %Assume square matrix!
	x = zeros(size(f)); %Allocate memory
	sumy = zeros(size(f)); %Store sums  
	%Use books algo.
         %x(i) = [f(i) - sum(U(i,j)*x(j), for j from i+1 to n)]./U(i,i)
	x(n) = f(n)./U(n,n); %Initial solution for bottom
	for (i = (n-1):-1:1) %Row count
		for (j = (i+1):1:n)
			sumy(i) = U(i,j).*x(j) + sumy(i); %Do the sum
		end
		x(i) = (f(i) - sumy(i))./U(i,i);
	end
end
