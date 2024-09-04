<!-- badges: start -->
![GitHub](https://img.shields.io/github/license/AstefanidisUOI/Pparnassica-Oparnassica-SDM-GLM)
![GitHub repo size](https://img.shields.io/github/repo-size/AstefanidisUOI/Pparnassica-Oparnassica-SDM-GLM)
[![DOI](https://zenodo.org/badge/852216417.svg)](https://zenodo.org/doi/10.5281/zenodo.13684517)
<!-- badges: end -->


# Pparnassica-Oparnassica-SDM-GLM

*Parnassiana parnassica* and *Oropodisma parnassica*: SDM and GLM R codes 

[Stefanidis, Apostolis ![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/0009-0000-7481-6449)[^aut][^BAT]  
[Kougioumoutzis, Konstantinos ![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/0000-0002-6938-3025)[^aut][^PAT]  
[Zografou, Konstantina ![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/0000-0003-4305-0238)[^aut][^BAT]  
[Kati, Vassiliki ![ORCID logo](https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png)](https://orcid.org/0000-0003-3357-4556)[^aut][^BAT]

[^aut]: Author  
[^BAT]: Department of Biological Applications and Technology, University of Ioannina  
[^PAT]: Department of Biology, University of Patras  

**keywords**: connectivity, habitat suitability, threats, insects, grasshoppers, bush crickets, endemism, mountain ecosystems, IUCN


### Description
<!-- description: start -->
This study focuses on two target species, *Parnassiana parnassica* and *Oropodisma parnassica*, with the aim of achieving several key objectives: (1) delineating their current distribution patterns, (2) modeling their potential global distribution through habitat suitability mapping, (3) quantifying habitat connectivity to assess fragmentation, (4) investigating the environmental factors influencing habitat suitability and species abundance, (5) updating the IUCN Red List status based on new findings, and (6) proposing concrete conservation measures.
<!-- description: end -->

### Details about the codes

Welcome to the repository for our study on the globally threatened and endemic mountainous Orthoptera species, *Parnassiana parnassica* and *Oropodisma parnassica*. This repository contains the R scripts used for the analyses. They are organized and documented to facilitate reproducibility and understanding of the analyses conducted in this study. Please follow the order of execution provided to replicate the results. Each code proceeds step by step and includes all the necessary packages to run the code.

- The codes for Species Distribution Modelling are provided by Konstantinos Kougioumoutzis
- The codes for Generalized Linear Models are provided by Apostolis Stefanidis and Konstantina Zografou

#### Species Distribution Models

##### 1) Distribution Range and Thinning

This script processes occurrence data for species by first preparing the data, including cleaning and arranging coordinates. It estimates the species' distribution range using the alpha-hull method, visualizes the distribution range on a map, and then performs thinning of occurrence points to reduce spatial autocorrelation. Finally, the script checks for spatial clustering using the Nearest Neighbor Index (NNI) and saves the cleaned and processed data for further analysis.

##### 2) Create and Download NDVI Data with `rgee`

This script utilizes Google Earth Engine (GEE) to create and download Normalized Difference Vegetation Index (NDVI) data for a specified region of interest. It begins by setting up the GEE environment, filtering Sentinel-2 satellite imagery for the desired date range, and applying a cloud masking function. The script then calculates NDVI values, exports the data to Google Drive, and finally loads and visualizes the NDVI data for the specified study area.

##### 3) EuClim IVs Based on the Official IUCN Distributional Range

This script generates environmental variables (IVs) based on the official IUCN distributional range for species. It starts by loading the species' distribution range and high-resolution Digital Elevation Model (DEM) data, converting the DEM to a data frame for use with the Climate-EU model, and joining it with the Climate-EU output. The script then creates WorldClim variables, calculates solar radiation rasters, and generates envirem variables. It also includes topographical variables and NDVI data, resamples them to a common resolution, and checks for multicollinearity among the variables. Finally, the script subsets the uncorrelated variables and saves them for subsequent species distribution modeling.

##### 4) Suitable habitat fragmentation

This script calculates landscape metrics for a species' habitat using binary habitat maps. The process includes loading and projecting spatial data to an equal-area projection, calculating key landscape metrics (such as patch number, mesh size, and cohesion), and then combining these metrics into a single data frame. The script also summarizes area-related statistics across all habitat patches. Finally, the calculated metrics are saved in both RDS and Excel formats for further analysis.

#### Generalized Linear Models (GLM) for Species Abundance Analysis

This script analyzes species abundance using Generalized Linear Models (GLMs) by following a structured workflow. It begins with data preparation, checking for multi-collinearity among explanatory variables using Spearman correlation and Variance Inflation Factors (VIF), and removing highly correlated variables. Outliers are detected and, where necessary, removed. Continuous variables are standardized for comparability. The script then applies LASSO regression to select the most influential variables, using Elastic Net for one species to address potential over-regularization. GLMs are fitted to model species abundance, and Generalized Linear Mixed-Effects Models (GLMMs) are also tested, with Likelihood Ratio Tests (LRT) comparing the fit of GLMs and GLMMs. A multimodel inference approach is used to identify the best models based on Akaike Information Criterion (AICc) and to average models for reduced selection uncertainty. Finally, the script evaluates model fit using pseudo-R² and summarizes the results, highlighting the relative importance of each variable.
