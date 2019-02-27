1;
%Dumb test script. This is just meant to test the differences in variable scope between Octave and MATLAB, since thye are NOT 100% compliant with each other.
dumoutput = 0;
for (i = 0; i < 20; i++)
	dumoutput=dumoutput + i;
end
dumoutput
