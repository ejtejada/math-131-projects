%Author: Edgar Tejada
%Contributor: Jose Zarate
%			  Vivian Yuan


function y = RK4(f, a, b, alpha, N)
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
		K3 = h.*f(t+h./2, y(i-1) + K2./2);
		K4 = h.*f(t+h, y(i-1) + K3);
		%y = y + (K1 + 2.*K2)./6; %%Modus operandi of RK4
        y(i) = y(i-1) + (K1+2*K2+2*K3+K4)./6;
		if(gdb|0)
			fprintf("\n%d\n", y(i))
        end
		t = a + i.*h;
	end

end
