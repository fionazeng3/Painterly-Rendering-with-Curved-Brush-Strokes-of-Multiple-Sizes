function isDiff = isColorDiff(referenceImage, canvas, x0, y0, x, y)
    %|refImage.color(x,y)-canvas.color(x,y)|<|refImage.color(x,y)-strokeColor|)
    left = norm(double(referenceImage(y,x) - canvas(y,x)));
    right = norm(double(referenceImage(y,x) -referenceImage(y0,x0)));
    if(left < right)
        isDiff = 1;
    else 
        isDiff = 0;
    end
end