1;
% Prevent Octave from thinking that this
% is a function file:
%Author: Edgar Tejada
%Contributors:             Jose Zarate
%	                   Vivian Yuan
%			   Roberto Bernal
%                          Luke Kostrikin
%                          Wikiversity: https://en.wikiversity.org/wiki/Adams-Bashforth_and_Adams-Moulton_methods
%Write a Matlab function called AM4 that solve (1) using Order 4 Runge-Kutta method.

%Write a Matlab function called AM4 that solve (1) using (partially) Order 4 Runge-Kutta method. It will use part of RK4 to generate it's 3 'missing' initial values.

%Consider the IVP:
	% dy/dt = -12y, 0 <= t <= 1, with IV: y(0) = 1;
syms t y
global gdb;
gdb = 0; %Debug flag
a = 0;
b = 1;
N9 = 10;
N10 = 20;
N11 = 50;
alpha = 1;

f = @(t,y) -12.*y + 0.*t; %Function must be a function of two variables, even if the t just goes to zero.
Nvec= [N9, N10, N11];
hvec= (b-a)./Nvec;
y9 = AM4(f, a, b, alpha, N9);
y10 = AM4(f, a, b, alpha, N10);
y11= AM4(f, a, b, alpha, N11);
%yvec= [y0,y1, y2];
tvec9= a:hvec(1):b; %For ploting y3
tvec10= a:hvec(2):b; %For plotting y4
tvec11= a:hvec(3):b; %For plotting y5
%Notice, our solutions are all around pretty smooth at a cursory glance.
if(gdb|0) %Test if the lengths match.
   length(y9) 
   length(tvec9)
   y9

end
if(gdb|0) %Test if the lengths match.
	tvec9
	tvec10
	tvec11
end

figure(1);
hold on
grid on
plot(tvec9, y9,'r','Linewidth',2)
plot(tvec10, y10,'g','Linewidth',2)
plot(tvec11, y11,'b','Linewidth',2)
xlabel('t');
ylabel('AM4 estimate for y(t) with y(0) = 1');
legend('N = 10','N = 20','N = 50');
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

%Plot the three solutions against their N's
%FIND Exact Solution
syms y(t)
Eqn = (diff(y,t) == -12.*y);
%cond = y(0)==1;
ysol(t) = dsolve(Eqn);
coeff=solve(ysol(0)==1);
%Solve for coefficient
ysol1= @(t) coeff*exp(-12.*t); %%Actual solution
exactSolution = double(ysol1(b));
%The exact solution is e^(-12), which is around 10^-6.
Err9 = abs(exactSolution - y9(end));
Err10 = abs(exactSolution - y10(end));
Err11= abs(exactSolution - y11(end));
Err3 = [Err9,Err10,Err11];
if(gdb|0)
    Err3
end
figure(2)
grid on
hold on
loglog(Nvec,Err3,'c','Linewidth',5)
xlabel('Number of Subintervals N');
ylabel('Absolute Error @ f(1,y)');

y9=transpose(y9);
y10=transpose(y10);
y11=transpose(y11);
%Holy Converging Solutions batman, although as N ->Inf, the absolute error 
%Does seem to converge, but with  mild diminishing returns. 
%Our error for N=100 is now smaller than the magnitude as the actual solution
%So relative error would still be attrocious.
%AB4 DOES NOT seems to converge even faster than RK4!

%Postulate: AM4 is not a stable scheme to solve these problems if N is too small.
%Function definitions go here:
%Author: Edgar Tejada
%Contributor:             Jose Zarate
%			  Vivian Yuan
%			  Roberto Bernal

function w = AM4(f, a, b, alpha, N)
	%NOTICE: y is a vector of saved y(t) estimated
	%How about TELLING US IF 'y' STORED THE END POINT OR THE VECTOR OF GUESSES? PLEASE!?
	%Syms t %We will see if CCW actually plays nice here.
	%Syms x %x is a veriable
	%y[0]= alpha
	global gdb;
	h = (b-a)./N; %Step size
	t = a:h:b; %t is now a vector from a to b in steps of h.
	y = 1:1:N; %Generate the vector for AB4
	w = 1:1:N; %Generate the vector for AM4
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
%Now we HAVE 4 previous points, start from 4 onward.

	for (i = 5:1:(N+1)) %%Iterate, since y(1):y(4) are filled, only start at 5


        y(i) = y(i-1) + h./24.*(55.*f(t(i-1),y(i-1)) - 59.*f(t(i-2),y(i-2)) + 37.*f(t(i-3), y(i-3))  - 9.*f(t(i-4),y(i-4)));%Modus operandi of AB4
					  %Spaghetti coefficient play,
					  %Maybe we can seperate this addition into multiple lines later for a cleaner look?
		if(gdb|0)
			fprintf("\n%d\n", y(i))
        end
		
	end


%NOW GENERATE THE AM4 vector, w.
%Now we HAVE 4 previous points, start from 5 onward.
w(1) = y(1);
w(2) = y(2);
w(3) = y(3);
w(4) = y(4);
%Was it needed to do the first four points from AB4, weren't they the same as RK4's first 4 points?
%Same OG points from RK4? So why did I do AB4?
	for (i = 5:1:(N+1)) %%Iterate, since w(1):w(4) are filled, start at 5
         % used the Adames-Moulton method to change the w
         %Thank you Vivian for shwing how to solve for this,
        ode =(w(i-1)+h.*(251.*f(t(i),k) + 646.*f(t(i-1), w(i-1))-264.*f(t(i-2),w(i-2))+106.*f(t(i-3),w(i-3))-19.*f(t(i-4),w(i-4)))/720 == k);
       
        w(i)=solve(ode,k);
        if(gdb|1)
			fprintf("\n%d\n", w(i))
        end
		
	end

end
