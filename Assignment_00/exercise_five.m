%Exercise Five
%Functions calls and calculations go here: 
%First, lets try and make some vectors for the two dimensions.
xinterval = -4 : 0.0001 : 4;
yinterval = -2 : 0.0001 : 2;
%Now lets put these parameters into the functions. Perhaps y was not needed to the same fine degree, but I am assuming a 2D 'meshwidth' of 0.0001 implies little grid blocks of 0.0001 by 0.0001.
fprintf('Exercise Five:\nSee graphs.\n')
plot(xinterval, sin(xinterval), 'color','-b', 'Linewidth', 2)
grid on;
hold on;
plot(xinterval, cos(xinterval), 'color','-r', 'Linewidth', 2)
xlabel('x');
ylabel('y');
set(gca,'ytick',yinterval);
set(gca,'ylim',[-2, 2])
hold off;
