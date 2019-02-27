1;
%Author: Edgar Tejada
%Contributor:	Vivian Yuan
%				Tomny Hang
%Main Script goes here:
A = [6, 1, 7, 7, 6, 1, 8; 7, 5, 5, 2, 7, 8, 7; 9, 5, 3, 4, 4, 4, 3; 9, 8, 1, 6, -1, 8, 2; 1, 4, 5, 3, 3, 3, 7; 1, 3, 2, 7, 4, 7, 9; 6, 6, -2, 3, 2, 3, 3];
b= [6, 4, 8, 7, 1, 8, 9];
b=transpose(b); %Make the b vector a column vector
[L,U] = LU_factorization(A);
y = forward_substitution(L,b);
x = backward_substitution(U,y);
x0 = A\b; %Stores the actual solution
Err = abs(x0 - x);
MaxErr= max(Err);
fprintf('The max error between our method and the builtin matrix solver is %e', MaxErr)
%Again, the error seems to be that same as guassian elimination as per part 1.
%Out biggest max error is of order magnitude 10^-15, which for a matrix of integers
%is so small it might be attributed to floating point arithmetic error.

%Function definitions go here;
%The below function will do LU facotorization of A.
%Supposedly, this is more efficient than Gaussian Elimination as done in part 1.
%I can and should run a clock count to see if this is true.
%L is the matrix that stores the operation coefficients of gaussian elimination.
%U is the result of gaussian elimination.
function [L,U] = LU_factorization(A)
	
	%Intialize L with Identity Matrix
	n = length(A(:,1)); %nxn
	L = eye(n); %Initialize L with the identity matrix.
	ACopy=A; %Make copy
	U = zeros(size(A)); %Initialize U with zeroes.
	%Verify first element IS NOT zero.
	if (ACopy(1,1)==0)	%Find a valid eliminator vector and swap!
		for (i = 2:1:n)
			if (ACopy(i,1)~=0)
				swapRow(ACopy,1,i); %Verify this is CCW
				
				break
			end
		end
	end
	
	if (ACopy(1,1)==0) %Still?
		
		printf('\nWARNING, NO UNIQUE SOLUTION EXISTS. PLEASE SEEK FURTHER ASSISTANCE.\nThis incident has been reported.\n');
		return; %Will this end the function here and now?
	else
		eliminator = ACopy(1,:);
	end
	
	%Now we have a valid eliminator vector, fill L with the coefficients of '-c,' for c*e1+ei
	for (j = 1:1:n) %Column count
         %Now replace the eliminator
		eliminator = ACopy(j,:); %Fix this, make this checked in the above for loop to prevent zero nullspace shenanigans.
		for (i = (j+1):1:n)
		c = ACopy(i, j)./eliminator(j); %Eliminating coeff.
		%e(i) = c*e(j)+e(i)
		ACopy(i,:) = -c.*eliminator+ACopy(i,:);
		%Do the same operation on f.
		%f(i) = c.*f(j)+f(i);
		L(i,j) = c;
		end
	end
    U = ACopy; %So, in the end, this was gaussian elimination, but with no 'b' manip
end

function y = forward_substitution(L,b)
	y = zeros(size(b)); %Allocate memory
	n = length(L(1,:)); %Assume square matrix!

	sumy = zeros(size(b)); %Store sums  
	%Use books algo.
         %x(i) = [f(i) - sum(U(i,j)*x(j), for j from i-1 to n)]./U(i,i)
	y(1) = b(1)./L(1,1); %Initial solution for bottom
	for (i = 2:1:n) %Row count
		for (j = 1:1:i)
			sumy(i) = L(i,j).*y(j) + sumy(i); %Do the sum
		end
		y(i) = (b(i) - sumy(i))./L(i,i);
	end
end
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
