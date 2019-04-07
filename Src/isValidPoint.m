function isValid = isValidPoint(x, y, row, column)
if (x >= 1 && x <= column && y >= 1 && y <= row)
    isValid = 1;
else 
    isValid = 0;
end
end

