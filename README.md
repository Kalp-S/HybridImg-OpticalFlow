# Hybrid Image + Visualizing Optical Flow

## Background
  This project was an assignment for a 4rth year Computer Vision course. The objective of the assignment is creating hybrid images of two separate images, and generating optical flow fields given images.

 ## How does the project work?
  The hybrid image portion of this assignment works by using low pass filters and high pass filters to generate an image with only high frequency components and another image with only low frequency components. Te two images are then overlayed to create the hybrid image effect.
  
  The optical flow fields portion of this assignment works by computing temporal derivatives of portions on the image using a Guassian convolution filter. These regions are then mapped and assigned colors for a visual effect. 
  
## Screenshots:
  ![alt text](https://raw.githubusercontent.com/Kalp-S/HybridImg-OpticalFlow/master/image1.jpg "Image 1")
  ![alt text](https://raw.githubusercontent.com/Kalp-S/HybridImg-OpticalFlow/master/image2.jpg "Image 2")
  ![alt text](https://raw.githubusercontent.com/Kalp-S/HybridImg-OpticalFlow/master/result.png "Hybrid Image")

  ![alt text](https://raw.githubusercontent.com/Kalp-S/HybridImg-OpticalFlow/master/image.png "Original image")
  ![alt text](https://raw.githubusercontent.com/Kalp-S/HybridImg-OpticalFlow/master/image2.png "Original image displaced")
  ![alt text](https://raw.githubusercontent.com/Kalp-S/HybridImg-OpticalFlow/master/flow_field.png "Flow Field")
  
  
## Required Dependencies
- MATLAB 2020b
- Computer Vision Toolbox

Note: -To view hybrid image, run "Part2.m"
      -To view flow field, run "Part3.m"
