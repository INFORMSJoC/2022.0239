[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

# Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the [MIT License](LICENSE).

This repository is a snapshot of the data and codes that were used in the research 
reported on in the paper: Mehdi Behroozi, Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities, INFORMS Journal on Computing, 2023,
(https://doi.org/10.1287/ijoc.2022.0239). 


**Important: This code is being developed on an on-going basis at 
(https://github.com/behroozim/GeomShapeApprox_InscribedRect). Please go there if you would like to
get a more recent version of this and similar projects or would like support**

## Cite

To cite the contents of this repository, please cite both the paper and this repo, using their respective DOIs.

https://doi.org/10.1287/ijoc.2022.0239

https://doi.org/10.1287/ijoc.2022.0239.cd

Below is the BibTex for citing this snapshot of the respoitory.

```
@article{CacheTest,
  author =        {Behroozi, Mehdi},
  publisher =     {INFORMS Journal on Computing},
  title =         {{Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities}},
  year =          {2023},
  doi =           {10.1287/ijoc.2022.0239.cd},
  url =           {https://github.com/INFORMSJoC/2022.0239},
}  
```

## Description

The goal of this software is to fins largest inscribed rectangles inside convex bodies such as convex polygon, ellipse, etc. 
The only constraint is that the convex body must be defined in finite number of convex inequalities. 
For more information please see the paper cited above.

Each folder contains a README.md file for more specific information.

## Data
Two data sets are provided. One is an easy 10-gon (convex polygon with 10 vertices) and the other is a hard 500-gon instance.
The text files also contain instruction on genereating other random instances.

## Results

The [results](results/) for both instances are provided. This folder also includes other results from the paper. 

## Sources Codes

The codes are written in MATLAB. All codes can be found in [src](src/) folder. 
The cvx package is rquired in one the functions. The package is free to use and can be found at the [cvx](https://github.com/cvxr/cvx) GitHub repository.
Any other convex optimization package could be used.

## Replicating

To replicate the results run [sample_replicate](scripts/), to replicate the results of the 500-gon example presented in Figure 13 of the paper. Change the input data to replicate other results.


## Ongoing Development

This code is being developed on an on-going basis at the author's
[Github site](https://github.com/behroozim/GeomShapeApprox_InscribedRect).

## Contacnt & Support

For support in using this software or questions about the paper, submit an
[issue](https://github.com/tkralphs/JoCTemplate/issues/new) or contact Mehdi Behroozi at [email](mailto:m.behroozi@neu.edu?subject=[GitHub]%20Largest%20Inscribed%20Rectangle).
