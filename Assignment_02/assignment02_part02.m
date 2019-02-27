% Prevent Octave from thinking that this
% is a function file:
1;
%Author:
%		Edgar Tejada
%Contributors: 
%		Tomny Hang
%		Judith Mendoza
%		Fabian Santiago
%		Luke Kostrikin
%		Vivian Yuan
%		Jarett Indalecio
%Lets finish this fast
Fun = @(x) (exp(-(x.^2)));
datx = -3:1:3;
daty = Fun(datx);
x = -3:0.01:3; %I really hope this name shared with a symbol doesn't break anything
P5 = Newtons_divided_differences(x,datx,daty);
plot(x, Fun(x), 'b', 'Linewidth', 5); 
hold on;
grid on;
scatter(x, P5, 'r'); 
P6 = Lagrange_poly(x,datx,daty);
scatter(x, P6, 'm');
xlabel('-3 < x < 3');
legend('y = e^(-x^2)','y = P5(x)', 'y=P6(x)');
hold off;
P5 = transpose(P5);
p5=P5; %Seriously, did you want it lowercase when the instructions SAID CAPITALIZED?
p6=transpose(P6); %%Just for clean comparison
fprintf('\nOkay, so P5, the Newtons divded differences looks good between -2 and 2, BUT BREAKS outside of that by oders of magnitude. I do not belives this is expect behavior, SO ONE OF MY IMPLEMENTATIONS MUST BE WRONG.\n');
