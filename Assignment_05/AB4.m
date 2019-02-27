%Author: Edgar Tejada
%Contributor: Jose Zarate
%			  Vivian Yuan


function y = AB4(f, a, b, alpha, N)
	%NOTICE: y is a vector of saved y(t) estimated
	%How about TELLING US IF 'y' STORED THE END POINT OR THE VECTOR OF GUESSES? PLEASE!?
	%Syms t %We will see if CCW actually plays nice here.
	%Syms x %x is a veriable
	%y[0]= alpha
	global gdb;
	h = (b-a)./N; %Step size
	t = a:h:b; %t is now a vector from a to b in steps of h.
	y = 1:1:N; %Generate the vector
	y(1) = alpha; %Initial value
	
	for (i = 2:1:4) %%Iterate, since y(1) is filled, only go to (4)
		K1 = h.*f(t(i-1),y(i-1));
		K2 = h.*f(t(i-1)+h./2, y(i-1) + K1./2);
		K3 = h.*f(t(i-1)+h./2, y(i-1) + K2./2);
		K4 = h.*f(t(i-1)+h, y(i-1) + K3);
		%y = y + (K1 + 2.*K2)./6; %%Modus operandi of RK4
        y(i) = y(i-1) + (K1+2*K2+2*K3+K4)./6;
		if(gdb|0)
			fprintf("\n%d\n", y)
        end
		%t = a + i.*h;
	end
%Now we HAVE 4 previous points, start from 5 onward.

	for (i = 5:1:(N+1)) %%Iterate, since y(1):y(4) are filled, only go to (4)


        y(i) = y(i-1) + h./24.*(55.*f(t(i-1),y(i-1)) - 59.*f(t(i-2),y(i-2)) + 37.*f(t(i-3), y(i-3))  - 9.*f(t(i-4),y(i-4)));%Modus operandi of AB4
					  %Spaghetti coefficient play,
					  %Maybe we can seperate this addition into multiple lines later for a cleaner look?
		if(gdb|0)
			fprintf("\n%d\n", y(i))
        end
		
	end


end
