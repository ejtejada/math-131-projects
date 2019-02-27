% Prevent Octave from thinking that this
% is a function file: We need some random declaration to maximize octave-matlab compatibility.

1;

% Author: Edgar Tejada
% Date : 2018-01-24
%Exercise Six
%Functions calls and calculations go here: 
%First, lets try and make some vectors for the two dimensions.
xinterval2 = -6 : 0.0001 : 6;

%Now lets put these parameters into the functions. Perhaps y was not needed to the same fine degree, but I am assuming a 2D 'meshwidth' of 0.0001 implies little grid blocks of 0.0001 by 0.0001.
fprintf('Exercise Five:\nSee graphs.\n')
plot(xinterval2, atan(xinterval2), 'color','-b', 'Linewidth', 2)
grid on;
hold on;
%I couldn not find consistent documentation on asymptote configuration, so it has been omitted.
xlabel('x');
ylabel('y=arctan(x)');
set(gca,'ytick',yinterval);
set(gca,'ylim',[-2, 2])
hold off;
