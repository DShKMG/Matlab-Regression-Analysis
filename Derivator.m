function Result = Derivator(x,y)
%Derivator Derivates Y and X
%   Derivates the given two array numerically, T values are x and H values
%   are y
sizeH = size(y);
if(sizeH(1) > sizeH(2))
    sizeH = sizeH(1);
else
    sizeH = sizeH(2);
end
for i=1:sizeH
    if(i==1)
        D(i) = y(i)/x(i);
    else
        D(i)=(y(i)-y(i-1))/(x(i)-x(i-1));
    end
Result = D;
end

