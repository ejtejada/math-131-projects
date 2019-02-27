% Prevent Octave from thinking that this
% is a function file:
1;
%Author:
%		Edgar Tejada
%Contributors: 
%		Tomny Hang
%		Judith Mendoza

%Okay, lets break some eggs! Define the two true functions of interest. We want to compare the accuracy of our methods to these functions, but do calculations AS IF we only had a select few data points and DID NOT know these tasty functions.

Fun = @(x) (exp(-(x.^2)));
Fdeux = @(x) (1./(1 + x.^2));

%Define the the first set's input data;
datx = -3:1:3;
datx1 = -3:0.5:3;
daty = Fun(datx);
daty2 = Fdeux(datx);
x = -3:0.01:3; %I really hope this name shared with a symbol doesn't break anything

P1 = Lagrange_poly(x,datx,daty); %Make LP1 of f1
P2 = Lagrange_poly(x,datx,daty2);%Make LP2 of f2
P3 = Lagrange_poly(x,datx1,Fun(datx1)); %Make LP3 of f1
P4 = Lagrange_poly(x,datx1,Fdeux(datx1));%Make LP4 of f2
%Beware of memory running out with the above calls!

%Now, lets plot some stuff for fun!
%Are you sure you don't want the prettier line graphs?
%plot(x, Fun(x), '-b', 'Linewidth', 10); 
scatter(x, Fun(x), 'b'); % Plot f1
hold on;
grid on;
%plot(x, P1(x), '-r', 'Linewidth', 10);
scatter(x, P1, 'r'); 
scatter(x, Fdeux(x), 'c'); %Plot f2
scatter(x, P2, 'm');
scatter(x, P3, 'g');
scatter(x, P4, 'y');
xlabel('-3 < x < 3')
ylabel('-1 < y < 1')
%ylabel('f1 vs P1 vs f2 vs P2 vs P3 vs P4')
legend('y = e^(-x^2)','y = P1(x)', 'y=(1./(1 + x.^2))', 'y = P2(x)', 'y = P3(x)', 'y = P4(x)' )
