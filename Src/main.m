close all; clear all; clc;
sourceImage = imread('scene.bmp');
R = [8,6,4 2];
oilPaint = paint(sourceImage, R);
imshow(oilPaint);