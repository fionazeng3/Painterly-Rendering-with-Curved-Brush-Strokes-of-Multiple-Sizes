%search each grid point’s
%neighborhood to find the nearby point with the greatest error
%and paint at this location.
function layer = paintLayer(canvas, referenceImage, R)
    layer = zeros(size(canvas));
    referenceImage = double(referenceImage);
    L = 0.3 * referenceImage(:,:,1) + 0.59 *referenceImage(:,:,2) + 0.11 * referenceImage(:,:,3);
    [gradientX, gradientY] = gradient(L);
    G = sqrt(gradientX .^2 + gradientY .^2);
    diff = referenceImage - canvas;
    D = sqrt(double(diff(:,:,1)).^2 + double(diff(:,:,2)).^2 + double(diff(:,:,3)).^2);
    grid = R;
    T = 50;
     ygrid = grid:grid:size(referenceImage,1)-grid;
     xgrid = grid:grid:size(referenceImage,2)-grid;
     yorder = ygrid(randperm(length(ygrid)));
     xorder = xgrid(randperm(length(xgrid)));
    for x0 = 1:length(xorder)
        j = xorder(x0)-(grid/2)+1:xorder(x0)+(grid/2);
        for y0 = 1:length(yorder)
             i = yorder(y0)-(grid/2)+1:yorder(y0)+(grid/2);
           % sum the error near (x,y)
            M = D(i,j);
            areaError = sum(sum(M))/(grid*grid);
            if(areaError > T)
                %find the largest error point
                [~, id] = max(M(:));
                [yi, xi] = ind2sub(size(M), id);
                 y1 = yorder(y0) + yi;
                 x1 = xorder(x0) + xi;
                [S, strokeRGB] = makeStroke(R,x1,y1,referenceImage,canvas, gradientX, gradientY, G);
                strokeRGB = double(strokeRGB);
                if ~isempty(S)
                    tip = circle(R); 
                    tipX = floor(size(tip,2)/2);
                    tipY = floor(size(tip,1)/2);
                    tipR = tip*strokeRGB(1,1,1);
                    tipG = tip*strokeRGB(1,1,2);
                    tipB = tip*strokeRGB(1,1,3);
                    brush = cat(3,tipR,tipG,tipB);
                    [py,px] = size(S);
                    for p = 1: py
                        point = S(p,:);
                        x = point(1,1);
                        y = point(1,2);
                        xMax = size(referenceImage,2) - tipX;
                        xMin = 1 + tipX;
                        yMax = size(referenceImage,1) - tipY;
                        yMin = 1 + tipY;
                        % paints stroke on layer
                        if x >= xMin && x <= xMax && y >= yMin && y <= yMax
                            area = layer(y-tipY:y+tipY,x-tipX:x+tipX,1:3);
                            painted = (brush.*area ~= 0);
                            clean = (painted == 0);
                            layer(y-tipY:y+tipY,x-tipX:x+tipX,1:3) = area + brush.*clean;
                        end
                    end
                end
            end
        end
    end

end

