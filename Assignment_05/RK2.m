%Author: Edgar Tejada
%Contributor: Jose Zarate

function y = RK2(f, a, b, alpha, N)
	%NOTICE: y is a vector of saved y(t) estimated
	%How about TELLING US IF 'y' STORED THE END POINT OR THE VECTOR OF GUESSES? PLEASE!?
	%Syms t %We will see if CCW actually plays nice here.
	%Syms x %x is a veriable
	%y[0]= alpha
	global gdb;
	h = (b-a)./N; %Step size
	t = a; %Initialize t[0]
	y = 1:1:N; %Generate the vector
	y(1) = alpha; %Initial value
	for (i = 2:1:(N+1)) %%Iterate, since y(1) is filled, only go to (N-1)
		K1 = h.*f(t,y(i-1));
		K2 = h.*f(t+h./2, y(i-1) + K1./2);
		%y = y + (K1 + 2.*K2)./6; %%Modus operandi of RK2
        y(i) = y(i-1) + K2;
        if(gdb|0)
			fprintf("\n%d\n", y)
		end
		t = a + i.*h;
	end

end

