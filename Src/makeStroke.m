function [k, strokeRGB] = makeStroke(R,x0,y0,refImage,canvas, gradientX, gradientY,G)
    k = [x0 y0];
    x = x0;
    y = y0;
    lastDx = 0;
    lastDy = 0;
    strokeRGB = refImage(y0, x0, :);
    maxStrokeLength = 16;
    minStrokeLength = 4;
    [row, column] = size(refImage(:,:,1));
    for i = 1: maxStrokeLength + 1
        %detect color difference
        isDiff = isColorDiff(refImage, canvas, x0, y0, x, y);
        if(i >  minStrokeLength && isDiff == 1)
            break;
        end
        %detect vanishing gradient
        Gx = gradientX(y,x);
        Gy = gradientY(y,x);
        if(G(y,x) == 0)
            break
        end
        %compute a normal direction
        dx = -Gy;
        dy = Gx;
        %if necessary, reverse direction
        if(lastDx * dx + lastDy*dy < 0)
            dx = -dx;
            dy = -dy;
        end
        %filter the stroke direction
        fc = 0.25;
        dx = fc .* dx + (1-fc) .* lastDx;
        dy = fc .* dy + (1-fc) .* lastDy;
        dx_norm = dx ./ sqrt(dx * dx + dy*dy);
        dy_norm = dy ./sqrt(dx * dx + dy*dy);
        x = x + R*dx_norm;
        y = y + R*dy_norm;
        x = floor(x + R*dx);
        y = floor(y + R*dy);
        xy = [x, y];
        isValid = isValidPoint(x, y, row, column);
        if(isValid == 0)
            break;
        end
        lastDx = dx_norm;
        lastDy = dy_norm;
        k = [k;xy];
    end
end

