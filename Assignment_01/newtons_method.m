%Author: Edgar Tejada
%Contributors:
%				Roberto Bernal
%				Weitong Yuan
%				Fabian Santiago
%				Tommy Hang
%Date : 2018-02-06
%The below function will take a function 'f', its first derivative 'fp', and finds the closest root, or solution to f(x) = 0; The user must give a decent guess, 'xnot', as well as a tolerance and N max cycles.
function [c,n,err] = newtons_method(f,fp,xnot,tol,N)
	array = 1:1:N; 
	%x=1:length(array); %Make an iterative array NOT EMPTY!
	n=2;
	
	array(1) = xnot;
	%err=Inf;
	array(2) = xnot - f(xnot)./fp(xnot);
	c = array(2);
	err = abs(array(2) - array(1));
	%for (nn=1:1:N)
	while (n<N)
		if (f(array(n)) == 0)
		%Check the trivial case.
			c = array(n);
			n = n + 1;

			%err = 0; %% We will keep the previous error
			%even if float inaccuracy brings us to the solution.
			break;
		elseif (err < tol)
			
			c = array(n);
			%err = abs(array(n) - array(n-1));
			n = n + 1;
			err = abs(array(n) - array(n-1));
			fprintf('\nA root was found without running out of cycles! YES!\n')
		else
			
			c = array(n);
			n = n + 1;
			array(n) = array(n-1) - f(array(n-1))./fp(array(n-1));
			err = abs(array(n) - array(n-1));
		end
		
	end
	n = n -1; %%See n ; our OG n starts at 2; 
end
