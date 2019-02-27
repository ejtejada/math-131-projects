1;
% Prevent Octave from thinking that this
% is a function file:
%Author: Edgar Tejada
%Contributors: Jose Zarate
%	           Vivian Yuan
%			   Roberto Bernal
%Write a Matlab function called AB4 that solve (1) using Order 4 Runge-Kutta method.

%Write a Matlab function called AB4 that solve (1) using (partially) Order 4 Runge-Kutta method. It will use part of RK4 to generate it's 3 'missing' initial values.

%Consider the IVP:
	% dy/dt = -12y, 0 <= t <= 1, with IV: y(0) = 1;
syms t y
global gdb;
gdb = 0; %Debug flag
a = 0;
b = 1;
N6 = 20;
N7 = 50;
N8 = 100;
alpha = 1;

f = @(t,y) -12.*y + 0.*t; %Function must be a function of two variables, even if the t just goes to zero.
Nvec= [N6, N7, N8];
hvec= (b-a)./Nvec;
y6 = AB4(f, a, b, alpha, N6);
y7 = AB4(f, a, b, alpha, N7);
y8 = AB4(f, a, b, alpha, N8);
%yvec= [y0,y1, y2];
tvec6= a:hvec(1):b; %For ploting y3
tvec7= a:hvec(2):b; %For plotting y4
tvec8= a:hvec(3):b; %For plotting y5
%Notice, our solutions are all around pretty smooth at a cursory glance.
if(gdb|0) %Test if the lengths match.
   length(y6) 
   length(tvec6)

end
if(gdb|0) %Test if the lengths match.
	tvec6
	tvec7
	tvec8
end

figure(1);
hold on
grid on
plot(tvec6, y6,'r','Linewidth',2)
plot(tvec7, y7,'g','Linewidth',2)
plot(tvec8, y8,'b','Linewidth',2)
xlabel('t');
ylabel('AB4 estimate for y(t) with y(0) = 1');
legend('N = 20','N = 50','N = 100');
%Huh, so let's see what they look like?
%The solution does seem to be converging as N--> Inf
%DOES NOT to converge faster than RK2 and RK4 for N = 20. In fact, for N =20, THE ERROR IS IN ORDER 10^1, which is huuughhh.
% It does behave better if N is sufficiently large. 
%Seems to go crazy as N shrinks,  suggestions the scheme/method is not  truly well posed.
%Now lets find the true solution for t = 1;
%Find the actual function solution
% dy/dt = -12y
%Solve via seperable
% y(t) = c1*e^(-12t) + d
%Use IVP conditions
%y(t) = e^(-12t)
ysol1= @(t) exp(-12.*t); %%Actual solution
%Plot the three solutions against their N's



exactSolution = ysol1(b);
%The exact solution is e^(-12), which is around 10^-6.
Err6 = abs(exactSolution - y6(end));
Err7 = abs(exactSolution - y7(end));
Err8 = abs(exactSolution - y8(end));
Err2 = [Err6,Err7,Err8];
if(gdb|0)
    Err2
end
figure(2)
grid on
hold on
loglog(Nvec,Err2,'c','Linewidth',5)
xlabel('Number of Subintervals N');
ylabel('Absolute Error @ f(1,y)');

y6=transpose(y6);
y7=transpose(y7);
y8=transpose(y8);
%Holy Converging Solutions batman, although as N ->Inf, the absolute error 
%Does seem to converge, but with  mild diminishing returns. 
%Our error for N=100 is now smaller than the magnitude as the actual solution
%So relative error would still be attrocious.
%AB4 DOES NOT seems to converge even faster than RK4!

%Postulate: AB4 is not a stable scheme to solve these problems if N is too small.
%Function definitions go here:
%Author: Edgar Tejada
%Contributor: Jose Zarate
%			  Vivian Yuan
%			  Roberto Bernal

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

