# Painterly Rendering with Curved Brush Strokes of Multiple Sizes
In this project, I choose to achieve the oil painting artistic effect. The approach is stroke based so that the processed image has a hand-painted appearance. The reference paper I used is ​Painterly Rendering with Curved Brush Strokes of Multiple Sizes. The general approach I used is to blur the image using different low pass filters and use different sizes of brush to paint the contents observed on the blurred image.
Details of Algorithm and Implementation
The image processing algorithm can be divided into three layers: blurring the original image and masking the strokes of all brush sizes, computing layer of each brush size, and making each stroke. The detail implementation of each part is described below.  
● Paint  
At the highest level of this painting algorithm, I first created an empty canvas. Using a for loop, I blurred the image with Gaussian low-pass filter and obtain the stroke layer of each brush size from the paintLayer function. In each iteration, I masked the stroke layer onto the canvas and cumulatively made a complete painting.  
● paintLayer  
The paintLayer function paints the stroke of each brush size. The approach I used is to compute the difference between the current canvas and the reference image. Then, in a for loop, I look into the image block by block and calculate the sum of error in that block. If the sum is bigger than a certain threshold, it means that the canvas is different enough from the reference image to produce a stroke somewhere inside the area of interest. I found the pixel point where maximum difference occurs and passed the location to makeStrok method to create a stroke. After the stroke is made, I used a circle to follow though the stroke control points and painted on the canvas. When all the strokes are painted, I return the mask of the current brush size.  
● makeStroke  
The makeStroke function creates an 2D matrix containing control points that the paintLayer function should follow. Taking the location of the stroke’s starting location and the gradient, the function finds the direction normal to the current gradient and calculates the next control point. The direction is also filtered to create a curved stroke appearance. When the max control point number is reached, vanishing gradient is detected, or the color of the stroke differs from the color under the last control pointis more than it differs from the current painting at that point, the function stops adding more control points on the stroke.  

The effects of this algorithm is shown below:
![demo1](https://user-images.githubusercontent.com/46212953/55679340-b0844600-58be-11e9-9372-193b91078b41.png)

![demo2](https://user-images.githubusercontent.com/46212953/55679348-f7723b80-58be-11e9-8fc3-790e8962bf5b.png)

![demo3](https://user-images.githubusercontent.com/46212953/55679351-00630d00-58bf-11e9-9463-6343d4b6d5fb.png)
