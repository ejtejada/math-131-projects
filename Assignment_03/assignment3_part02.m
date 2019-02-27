1;
% Prevent Octave from thinking that this
%Author: Edgar Tejada
%Contributors:
%		Tomny Hang
%		SE User Merin:
%		See: https://math.stackexchange.com/q/1742223
u=1;
f = @(t) (cos(pi./2*(t.^2)));
a = 0;
b = pi;
n=[10.^3, 10.^5]; 
I3=composite_simpsons(f, a, b, n(1))
I4=composite_simpsons(f, a, b, n(2))
%truevalue = fresnelc(pi); %Not available on CCW.
truevalue =0.52369854372622864215767570284001287107838062748955819756217918222658869382913499319310543586568703117501193577112894607371114568510090882287944789640512241969071932606076310656789673119810509673361261406756541462538851066319036; %To 286 digits from Matlab
Err3 = abs(I3 - truevalue)
Err4 = abs(I4 - truevalue)
ErrVecSimp = [Err3, Err4];
loglog(n,ErrVecSimp,'--r', 'Linewidth', 10); %Plot the error for composite trapezoid method.
grid on;
hold on;
xlabel('10^3 < n < 10^5');
ylabel('AbsError between method and true Integral(f(x)dx) from 0 to Pi');
%hold off;
%Notice: The error seems to stay steadily decrease as n increases. The error is also seems much lower than the trapazoid method. I do not know if this trend will continue forever, as error might plateu as n --> Inf for
%trapazoid  or simpsons method. We suspect that simpson's rule become unstable closer as n --> Inf, but have no evidence yet.
