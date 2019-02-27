z = @(x, const) (x - const)
%c = @(x) (1);
%Okay, lets play with cells for a moment.
datax=-3:1:3;
n=length(datax);
funcholder= cell(n);
%The above creates an n by n cell to store anonymous funcitons. This is memory wasteful, but I don't yet know a better way.
 %Note to self: Cell assignment looks like this testcell{column,row} = @(x) x.^2
for ( i = 1:1:n)
		funcholder{i,i} = @(x) ((x).^i);
end


%%Trust but verify:
%	Expected: (x-1)*(x-2)*(x-3)*(x-4)*(x-5)*(x-6)*(x-7)
%https://www.wolframalpha.com/input/?i=(x-1)*(x-2)*(x-3)*(x-4)*(x-5)*(x-6)*(x-7)+for+x+%3D0.5
