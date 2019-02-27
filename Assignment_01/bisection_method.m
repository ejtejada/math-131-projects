%Author: Edgar Tejada
%Contributors:  Roberto Bernal
%				Tommy Hang
%				Judith Mendoza
%Date : 2018-02-06
%The below function will take a function 'f' and two points that define a range of interest, as well as a tolerance and N max cycles. This function will find the root, or solution to f(x) = 0, via divide and conquer.
function [c,n,err] = bisection_method(f,a,b,tol,N)
    n = 0; %%Set the iterator to 0;
    err = abs(a-b); %%Set the error to the range of
					%% interest, because we know nothing.
    leftEndpoint  = a;
    rightEndpoint = b;
    midPoint = (a+b)./2;
    %previousMidPoint = midPoint;
    stop = 0;
    while(err > tol && n < N && ~stop )
        previousMidPoint = midPoint;
        if (f(leftEndpoint).*f(rightEndpoint) > 0) %% Check if the range even has roots! 
			n = n + 1;
			err = NaN;
			c = NaN;
			stop = 1
			fprintf('Warning: No root seems to exist in the given interval. Perhaps you mistyped the interval of interst?');
		elseif (f(leftEndpoint).*f(rightEndpoint) == 0)
			fprintf('Warning: One of or both) of the given end points was the root.');
			if (f(leftEndpoint) == 0)
				c = leftEndpoint;
			elseif (f(rightEndpoint) == 0)
				c = rightEndpoint;
			end
			err = tol;
			n=n+1;
			stop = 1;
        elseif ( f(midPoint) == 0 )
            n=n+1;
            err = tol;
            c = midPoint;
            stop = 1;
        elseif ( f(leftEndpoint).*f(midPoint) < 0)
            %leftEndpoint = leftEndpoint;
            rightEndpoint =  midPoint;
            midPoint = (rightEndpoint + leftEndpoint)./2;
            err = abs(previousMidPoint - midPoint)./abs(midPoint);
            n=n+1;
            c = midPoint;
          elseif ( f(rightEndpoint).*f(midPoint)<0)
            leftEndpoint = midPoint;
            %rightEndpoint =  rightEndpoint;
            midPoint = (rightEndpoint +leftEndpoint)./2;
            err = abs(previousMidPoint - midPoint)./abs(midPoint);
            n = n + 1;
            c = midPoint;
        end
    end
end
% This function checks calculates the roots
%to a given function between points a and b with
%a given acceptable tolerance tol and a maximum
%of cycles N.
