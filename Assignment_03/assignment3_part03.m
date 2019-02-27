1;
% Prevent Octave from thinking that this
% is a function file:
%Function declarations and definitions go here.

%Checkout Section 4.1
%Let's do the error. We will be using relative error:
%abs(p- p*)./abs(p)

function err = numericErr(n, x0, f, fpp, h, method)
	estimate= method(n, x0, f, h);
	err = abs(fpp(x0) - estimate);%Absolute Error
end
%Let's make life easier for ourselves and declare the three types of deriviative estimates as functions.
function yp1 = forwardpt(n, x0, f, h)
	yp1=(f(x0 + h(n)) - f(x0))./h(n); %Forward Difference Estimate with two points.
	%return yp1;
end

function yp3 = threeptCD(n, x0, f, h)
	yp3 =  (f(x0 + h(n)) - f(x0 - h(n)))./(2.*h(n)); %Midpoint Estimate with three points.
    %return yp3;
end

function yp5 = fiveptCD(n, x0, f, h)
	yp5 = ( -f( x0+2.*h(n) ) +8.*f( x0+h(n) ) -8.*f( x0-h(n) )  + f( x0 - 2.*h(n)))./(12.*h(n));
	%return yp5;
end


%Author: Edgar Tejada
%Contributors:
%		Jose Zarate
%		Vivian Yuan
%		Roberto Bernal
%		Tomny Hang
%Main Script goes here
n1=1;
n3=3;
n6=6;
x0 = 0;
f  = @(x) ((x.^2 -3.*x +2).*atan(x)); %Function of interest
fp = @(x) ((x.^2 - 3.*x + 2)./(x.^2 + 1) + (2.*x - 3).*atan(x)); %We will compare these estimates to the actual results from the known first derivative
h = @(n) (10.^(-n)); %We are given the h to n relationship.

FD1 = forwardpt(n1, x0, f, h);
FD3 = forwardpt(n3, x0, f, h);
FD6 = forwardpt(n6, x0, f, h);
FDERR = [abs(FD1 - fp(x0)), abs(FD3 - fp(x0)), abs(FD6 - fp(x0))];%Generate the error vector.
CD31 = threeptCD(n1, x0, f, h);
CD33 = threeptCD(n3, x0, f, h);
CD36 = threeptCD(n6, x0, f, h);
CD3ERR = [abs(CD31 - fp(x0)), abs(CD33 - fp(x0)), abs(CD36 - fp(x0))]; %Generate the error vector.
CD51 = fiveptCD(n1, x0, f, h);
CD53 = fiveptCD(n3, x0, f, h);
CD56 = fiveptCD(n6, x0, f, h);
CD5ERR = [abs(CD51 - fp(x0)), abs(CD53 - fp(x0)), abs(CD56 - fp(x0))]; %Generate the error vector.

ninterval = [n1,n3,n6];
hinterval = h(ninterval);
err1 = numericErr(ninterval, x0, f, fp, h, @forwardpt)
err3 = numericErr(ninterval, x0, f, fp, h, @threeptCD)
err6 = numericErr(ninterval, x0, f, fp, h, @fiveptCD)
loglog(hinterval,err1,'--b', 'Linewidth', 5);
grid on;
hold on;
loglog(hinterval,err3,'--r', 'Linewidth', 5);
loglog(hinterval,err6,'--g', 'Linewidth', 5);
xlabel('log(10^-6) < log(h) < log(10^-1)');
ylabel('AbsError between method and fp(x0)');
legend('Forward Difference Error','Three Point Centered Difference Error', 'Five Point Centered Error');
fprintf('\nThe error decreases as h decreases (but as n increases).\nThis makes sense, as the error and h are directly proportional, but n and\nthe error are inversely proportional.\n')

%Generally, the forward difference method has the largest error, as graphically its absolute error is always higher.
%Generally, the five point centered method had the lowest error. Its error converged to zero the fastest, as its O(h^3) means it gets smaller faster. Graphically, we can see that for any value of n or h, five point centered method produced a lower error than its competition.

%In general, error and n are inversely proportional.
