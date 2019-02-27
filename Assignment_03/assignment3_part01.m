1;
% Prevent Octave from thinking that this
%Author: Edgar Tejada
%Contributors:
%		Judith Mendoza
%		Tomny Hang
u=1;
f = @(t) (cos(pi./2*(t.^2)));
a = 0;
b = pi;
n=[10.^3, 10.^5]; 
I1=composite_trapezoid(f, a, b, n(1))
I2=composite_trapezoid(f, a, b, n(2))
%truevalue = fresnelc(pi); %Not available on CCW.
truevalue =0.52369854372622864215767570284001287107838062748955819756217918222658869382913499319310543586568703117501193577112894607371114568510090882287944789640512241969071932606076310656789673119810509673361261406756541462538851066319036; %To 286 digits from Matlab
Err1 = abs(I1 - truevalue)
Err2 = abs(I2 - truevalue)
ErrVecTrap = [Err1, Err2];
loglog(n,ErrVecTrap,'--b', 'Linewidth', 10); %Plot the error for composite trapezoid method.
grid on;
hold on;
xlabel('10^3 < n < 10^5');
ylabel('AbsError between method and true Integral(f(x)dx) from 0 to Pi');
%Notice: The error seems to go down exponentially as n increases. The error is much lower when n = 10^5 than
%when n = 10^3. I do not know if this trend will continue forever, as error might plateu as n --> Inf or
%might become unstable closer to Inf.
