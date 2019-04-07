function c = circle(R)
% creates circular brush element for a given radius
if R < 3 % keeps non-zero brush element circular and not square
    R = R + 1;
end
c = zeros(R);
for x = R:-1:1 % for one quadrant of circle
    y = (R^2 - (x-1)^2)^(1/2);
    y = floor(y);
    c(y:-1:1,x) = ones(y,1);
end
% forms circle out of quadrant
c = [c(end:-1:2,end:-1:2), c(end:-1:2,:); c(:,end:-1:2), c];
end

