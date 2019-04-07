%paint each layer in every brush size
function canvas = paint(sourceImage, R)
[row, column] = size(sourceImage(:,:,1));
canvas = zeros(row, column, 3);
canvas = double(canvas);
for k = 1:length(R)
    referenceImage = imgaussfilt(sourceImage, R(k) * 0.5);
    layer = paintLayer(canvas,referenceImage, R(k));
    blank = (layer == 0);
    notLayer = canvas.*blank;
    canvas = (canvas).*(canvas ~= 0).*(blank) +(canvas ~=0).*(layer ~= 0).*(layer) +(notLayer + layer).*(canvas == 0);
end
canvas = uint8(canvas);
end

