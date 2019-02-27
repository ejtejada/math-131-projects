%Author: Edgar Tejada
%Contributors:
%				Tommy Hang
%				Judith Mendoza
%				Ramiro Gonzalez
%Date : 2018-02-06
%The below function will take a function 'g' and finds the closest root, or solution to f(x) = 0; The user must give a decent guess, 'xn0', as well as a tolerance and N max cycles.
function [c,n,err] = fixed_point_iteration(g, x0, tol, N)
    n = 0; %%Set the iterator to 0;
    p = g(x0);
    pzero=x0;
    stop = 0; %Stop boolean
    err = abs( p - pzero);
	while (n< N && ~stop)
		p = g(pzero);
		n = n + 1;
		err = abs( p - pzero);
		if (err < tol)
			c = p;
			stop = 1;
		elseif ( n == N)
			failprint='The method failed after %d iterations;\n (The procedure was unsuccessful.)\n';
			fprintf(failprint, n);
			c=p;
			stop = 1;
			
		else
			pzero = p;
			%fprintf('%d\n', pzero);
		end
    end
    
	
end
