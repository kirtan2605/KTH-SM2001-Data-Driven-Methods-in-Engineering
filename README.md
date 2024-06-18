# Data-Driven Compression of Multi-Channel Images
This project’s primary objective is to systematically assess the efficacy and performance of some of these methods which enable building of low-order representations of image data.

## Image Dataset
The dataset under assessment for performance evaluation is a multi-channel (color) image with dimensions of 1704 × 2272 pixels.
<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/Project/images/KTH_photo.jpg" style="width:750px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

## Singular Vector Decomposition
Low-order representations of the image data can be obtained by storing data upto different value of rank r (All the three channels have the same value of r). The effect of this compression can be seen in the reconstructed images.
<p align="center">
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-EF2264-Operations-of-Space-Systems/blob/master/src/datafiles/results/minimum_distance.png" style="width:100%; height:250px;">
    <figcaption style="text-align:center;">Caption for the first image</figcaption>
  </figure>
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-EF2264-Operations-of-Space-Systems/blob/master/src/datafiles/results/minimum_distance_zoom.png" style="width:100%; height:250px;">
    <figcaption style="text-align:center;">Caption for the second image</figcaption>
  </figure>
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

<p align="center">
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-EF2264-Operations-of-Space-Systems/blob/master/src/datafiles/results/minimum_distance.png" style="width:100%; height:250px;">
    <figcaption style="text-align:center;">Caption for the first image</figcaption>
  </figure>
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-EF2264-Operations-of-Space-Systems/blob/master/src/datafiles/results/minimum_distance_zoom.png" style="width:100%; height:250px;">
    <figcaption style="text-align:center;">Caption for the second image</figcaption>
  </figure>
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

<p align="center">
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-EF2264-Operations-of-Space-Systems/blob/master/src/datafiles/results/minimum_distance.png" style="width:100%; height:250px;">
    <figcaption style="text-align:center;">Caption for the first image</figcaption>
  </figure>
  <figure style="display:inline-block; width:45%; float:left;">
    <img src="https://github.com/kirtan2605/KTH-EF2264-Operations-of-Space-Systems/blob/master/src/datafiles/results/minimum_distance_zoom.png" style="width:100%; height:250px;">
    <figcaption style="text-align:center;">Caption for the second image</figcaption>
  </figure>
  <div style="clear:both; margin-bottom:200px;"></div>
</p>


For a more precise reconstruction with lower storage, different value of r can be set for each of the three channels based on the amount of cumulative energy that is captured.
<p align="center">
  <img src="https://github.com/kirtan2605/KTH-SM2001-Data-Driven-Methods-in-Engineering/blob/master/Project/images/SVD/CummulativeEnergyVsR.pdf" style="width:750px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

