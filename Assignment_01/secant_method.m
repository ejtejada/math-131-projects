%Author: Edgar Tejada
%Contributors:
%				Malachi Landavazo
%Date : 2018-02-06
%The below function will take a function 'f' and finds the closest root, or solution to f(x) = 0; The user must give two decent guess, 'x0' and 'x1', as well as a tolerance and N max cycles.
function [c,n,err] = secant_method(f,x0,x1, tol,N)
	n = 2; %Adding one to the increment to avoid accessing illegal x{0};
	x{N}=1:N %Make an iterative array NOT EMPTY!
	x{1} = x0;
	x{2} = x1; %%The user gives us the first two inputs
	err = abs(x{2} -x{1});
	c = (x0+x1)./2;%%Spit out something if this fails;
	while ( err > tol && n < N)
	n = n + 1;
	x{n}=x{n-1} - ((x{n-2}- x{n-1})*f(x{n-1}))./(f(x{n-2})-f(x{n-1})); 
	%%The above grossness is an exercise in getting used to matrix notation. WE ARE SAVING ALL PREVIOUS GUESSES.
		if (f(x{n}) == 0)
			err = 0;
			break
		end
	err = abs(x{n} - x{n-1});
	c= x{n};
	c
	n
	end
	
	n = n-1; %%We have to decrement to get the correct number of cycles. SEE LINE 6;
	
end
