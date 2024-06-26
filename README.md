# Data-Driven Compression of Multi-Channel Images
The primary objective of the project is to systematically assess the efficacy and performance of some of these methods which enable building of low-order representations of image data.

## Image Dataset
The dataset under assessment for performance evaluation is a multi-channel (color) image with dimensions of 1704 × 2272 pixels.
<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/KTH_photo.jpg" style="width:750px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

## Singular Vector Decomposition
Low-order representations of the image data can be obtained by storing data upto different value of rank r (All the three channels have the same value of r). The effect of this compression can be seen in the reconstructed images.
<p align="center">
  <figure style="display:inline-block; width:45%; margin:0 2.5%; vertical-align: top;">
    <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r001.png" style="width:45%; height:250px;">
    <figcaption style="text-align:center;"> r = 001 </figcaption>
  </figure>
  <figure style="display:inline-block; width:45%; margin:0 2.5%; vertical-align: top;">
    <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r002.png" style="width:45%; height:250px;">
    <figcaption style="text-align:center;"> r = 002 </figcaption>
  </figure>
  <div style="clear:both; margin-bottom:200px;"></div>
</p>



<p align="center">
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r005.png" style="width:45%; height:250px;">
    <figcaption style="text-align:center;"> r = 005 </figcaption>
  </figure>
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r010.png" style="width:45%; height:250px;">
    <figcaption style="text-align:center;"> r = 010 </figcaption>
  </figure>
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

<p align="center">
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r025.png" style="width:45%; height:250px;">
    <figcaption style="text-align:center;"> r = 025 </figcaption>
  </figure>
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/Compressed_Image_r100.png" style="width:45%; height:250px;">
    <figcaption style="text-align:center;"> r = 100 </figcaption>
  </figure>
  <div style="clear:both; margin-bottom:200px;"></div>
</p>


For a more precise reconstruction with lower storage, different value of r can be set for each of the three channels based on the amount of cumulative energy that is captured.
<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/readme_images/SVD/CummulativeEnergy_vs_r.png" style="width:750px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

