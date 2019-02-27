1;1; %Make sure octave knows this is a script, not a function file.
%Author:		Edgar Tejada
%Co-Authors:	Alfredo Vasquez Gomez
%				Roberto Bernal
%Main Script goes here:
A = [-2, 1, 0, 0, 0; 2, 10, -2, 0, 0; 0, 2, -4, 0, 0; 0, 0, 0, 2, 1; 0, 0, 0, -3, -7];
b = [-5; 3; 3; -7; -8];
x1 = ones(length(A),1); %Initialize the x-solution vector. to a silly guess of all 1's
Nmax = 100;
%n= size(x1,1);
%n = size(x1); %Should be equivalent to the above.

normVal = Inf; %This feels wrong, but we want to intialiaze with an illegal value that is too large. 
tol = 1.*10.^-5;  %The desired accuracy.
[x,err,N] = gauss_seidel(A,b,x1,tol,Nmax) %x1 is initial guess.


%Function definitions go here:

%The below function will return an estimate solution to the system Ax=b using gauss-seidel iteration and will stop once we are either within an acceptable error, or have hit our Nmax # of cycles.
%#Inputs:	Vectors A, b, and an initial guess to the system x0 for Ax=b.
%			%An desired accuracy 'tol', and a user defined max number of cycles called 'Nmax'
%#Outputs: The possible solution vector x, the maximum error value, and the N number of cycles we went through.

function [x, err, N] = gauss_seidel(A,b,x,tol,Nmax)
normVal = 2.*tol; %Assume twice the tolerance, get into the loop at least once!
exactX = A\b; %Store the exact solution in 'exactX'
n = length(A);
N = 0; %Start cycle count at zero.

while (normVal>tol && N<Nmax)
    y = x; %Save a copy of the previous x vector solution
    
    for( i = 1:1:n ) %Loop through rows
        
        summy = 0; %Initialize the sum to the kernel of addition.
        
        for(j = 1:1:i-1) %Below current row
                summy = summy + A(i,j).*x(j);
        end
        
        for(j = i+1:1:n) %Above current row
                summy = summy + A(i,j).*y(j);
        end
        
        x(i)= (1./A(i,i)).*(b(i) - summy); 
    end
    errset = abs(exactX - x);
    err= max(errset); %Return just the biggest error.
    N = N+1; %Increment N. 
    
    normVal= norm(y-x); %Is using the norm built in function valid? Shouldn't we test err instead? 
    %No, I see we are just comparing our norm between the current guess and the previous, NOT the true solution.
end

end 
%Hey, this works pretty well. Even with a dumb guess of all 1's, we got to
%Within the desired tolerance in just N = 10 cycles. Color me impressed.
 
