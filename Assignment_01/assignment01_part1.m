% Prevent Octave from thinking that this
% is a function file:

1;
%Author:		Edgar Tejada
%Contributors:  Roberto Bernal
%				Tommy Hang
%				Judith Mendoza
%				Ramiro Gonzalez
%Date : 2018-02-06

f = @(x) (cos(x).*(2.*x.^3 + 3.*x -1) - x);
a = -1.0;
b = 1.0;
%f = @(x) (tan(x).*tan(x));
%f = @(x) ((x-2)./cos(x-2));
[c, iterations, errorFound] = bisection_method(f,a, b, 10.^-8, 100);
screendescription= 'The root found is %4.7f, we went through %d iterations, and the error is %4.15f.\n';
fprintf(screendescription, c, iterations, errorFound);
hold on;
grid on;
box on;
xinterval = -1 : 0.2 : 1;
plot(xinterval, f(xinterval), '-b', 'Linewidth', 10);
screendescription2= 'The error bound for the function is:\n [ %4.7f , %4.7f ].\n';

%%How to plot y-axis taken from SA user Austin A:
%% https://stackoverflow.com/a/25706706 
%% Set x value where verticle line should intersect the x-axis.
x = 0;

plot([x,x],[-4,4],'-r', 'Linewidth', 10);

errorBound = [(c - errorFound), (c+errorFound)];
fprintf(screendescription2, errorBound(1), errorBound(2));

fprintf('The expected rate of convergence for this and all bisection methods should approach 1/2.\n')
screendescription3= 'The exact root in the interval for the function is:\n [ %4.7f ].\n';

%x_exact = solve (f==0,x);
%fprintf('\nIn comparison, using the exact solution via the builtin solve function:\n');
%fprintf(screendescription3, x_exact);
%g = @(x) (exp(-x));
%h = @(x) (x);
%fprintf('We are selecting the x0 of 0.5 because x=e^-x will never be satified for 0 or any negative value of x. Logically,\n0 ~=1, and as x--> -Inf, x --> -Inf \nbut e^-x -> +Inf, so they never converge there. So, we really limit the range of interest to (0,1], and from there\nwe can randomly select the midpoint, x0 = 0.5;\n')

%[rootFound2, iterations2, errorFound2] = fixed_point_iteration(g, 0.5 , 10.^-10, 100);
%screendescription4= 'The root found is %4.7f, we went through %d iterations, and the error is %4.15f.\n';
%fprintf(screendescription, rootFound2, iterations2, errorFound2);
%fprintf('\n');
%hold off;
%xinterval2 = -1 : 0.2 : 1;
%plot(xinterval2, g(xinterval2));
%hold on;
%plot(xinterval2, h(xinterval2));
%hold off; 
%i = @(x) (atanm(x) - 1 );
%j = @(x) 1./(1+x.^2);

%[rootFound3, iterations3, errorFound3] = newtons_method(i, j, 2.0 , 5.*10.^-8, 50);
%fprintf(screendescription, rootFound3, iterations3, errorFound3);
