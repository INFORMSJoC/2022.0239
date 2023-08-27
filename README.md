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

## Results

Figure 1 in the paper shows the results of the multiplication test with different
values of K using `gcc` 7.5 on an Ubuntu Linux box.

![Figure 1](results/mult-test.png)

Figure 2 in the paper shows the results of the sum test with different
values of K using `gcc` 7.5 on an Ubuntu Linux box.

![Figure 1](results/sum-test.png)

## Replicating

To replicate the results in [Figure 1](results/mult-test), do either

```
make mult-test
```
or
```
python test.py mult
```
To replicate the results in [Figure 2](results/sum-test), do either

```
make sum-test
```
or
```
python test.py sum
```

## Ongoing Development

This code is being developed on an on-going basis at the author's
[Github site](https://github.com/tkralphs/JoCTemplate).

## Contacnt & Support

For support in using this software or questions about the paper, submit an
[issue](https://github.com/tkralphs/JoCTemplate/issues/new) or contact Mehdi Behroozi at [email](m.behroozi.neu.edu).
