% Prevent Octave from thinking that this
% is a function file:
1;
%Author:		Edgar Tejada
%Contributors:  Roberto Bernal
%				Tommy Hang
%				Judith Mendoza
%				Ramiro Gonzalez
%Date : 2018-02-06
%The below string defines some of our outprinting format.
screendescription4= 'The root found is %4.7f, we went through %d iterations, and the error is %e.\n';

%hold off;

f = @(x) (atan(x) - 1);
fp = @(x) (1./(1 + x.^2));

[c, n, err] = newtons_method(f, fp, 2.0 , 5.*10.^(-8), 1000)

fprintf(screendescription4, c, n, err);
fprintf('\n');
%hold off;
%[c, n, err] = newtons_method(f, fp, -2.0 , 5*10.^(-9), 1000)

%fprintf(screendescription4, c, n, err);
%fprintf('\n Ok, so if our xnot is set to -2, we never converge. Octaves warninings tell me that around where x_(n+1) is defined, division by zero happens. It seems that the first dirivative goes to zero, vision by zero happens.\n');
