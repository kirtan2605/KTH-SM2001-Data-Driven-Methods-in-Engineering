# Data-Driven Compression of Multi-Channel Images
The primary objective of the project is to systematically assess the efficacy and performance of some of these methods which enable building of low-order representations of image data.

## Image Dataset
The dataset under assessment for performance evaluation is a multi-channel (color) image.
<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/KTH_photo.jpg" style="width:500px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

## Singular Vector Decomposition
Low-order representations of the image data can be obtained by storing data upto different value of rank r (All the three channels have the same value of r). The effect of this compression can be seen in the reconstructed images.

<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r001.png" style="width: 45%; height: 250px; margin-right: 20px;">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r002.png" style="width: 45%; height: 250px;">
</p>

<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r005.png" style="width: 45%; height: 250px; margin-right: 20px;">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r010.png" style="width: 45%; height: 250px;">
</p>

<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r025.png" style="width: 45%; height: 250px; margin-right: 20px;">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r100.png" style="width: 45%; height: 250px;">
</p>


For a more accurate reconstruction with lower storage, different value of r can be set for each of the three channels based on the amount of cumulative energy that is captured.
<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/CummulativeEnergy_vs_r.png" style="width:500px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

## Discrete Fourier Transform
This transformation shifts an image from its spatial domain into the frequency domain, allowing for the segregation of high-frequency and low-frequency coefficients. It also permits the attenuation or modification of specific frequencies, resulting in an image with reduced data but retaining a satisfactory level of quality.

<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/DFT/Storage_0.1.png" style="width: 45%; height: 250px; margin-right: 20px;">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/DFT/Storage_0.21.png" style="width: 45%; height: 250px;">
</p>

<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/DFT/Storage_0.51.png" style="width: 45%; height: 250px; margin-right: 20px;">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/DFT/Storage_1.03.png" style="width: 45%; height: 250px;">
</p>

<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/DFT/Storage_2.57.png" style="width: 45%; height: 250px; margin-right: 20px;">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/DFT/Storage_10.27.png" style="width: 45%; height: 250px;">
</p>



