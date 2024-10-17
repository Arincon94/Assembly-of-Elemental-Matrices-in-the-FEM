# Assembly of Elemental Matrices in the Finite Element Method (FEM)

## Description

The assembly of elemental matrices is a critical step in FEM, allowing the construction of global system equations from the individual properties of each element. This project focuses on the indexing technique, which uses connectivity matrices to identify and place each element’s contributions in the correct locations within the global structure. This approach is more efficient compared to direct summation, particularly for large-scale systems.
### 8-Node Isoparametric hexahedral Element

The 8-node isoparametric hexahedral element is defined by nodes positioned at each corner of the cubic element, as follows 

<img src="Figures/8nodes.svg" alt="8-Node Hexahedral Element" width="300"/>

#### Node positions and shape functions

| Node | $\xi$ | $\eta$ | $\zeta$ |
|----------|----------|----------|----------|
| 1 | -1 | -1 | -1 |
| 2 | 1 | -1 | -1 |
| 3 | 1 | 1 | -1 |
| 4 | -1 | 1 | -1 |
| 5 | -1 | -1 | 1 |
| 6 | 1 | -1 | 1 |
| 7 | 1 | 1 | 1 |
| 8 | -1 | 1 | 1 |

The shape functions for the 8-node element are defined as:

$$
N_i(\xi, \eta, \zeta) = \frac{1}{8} (1 + \xi_i \xi)(1 + \eta_i \eta)(1 + \zeta_i \zeta)
$$

where $i$ is the node indice.

### 20-Node Isoparametric hexahedral Element

The 8-node isoparametric hexahedral element is defined by nodes positioned at each corner of the cubic element, as follows 

<img src="Figures/20nodes.svg" alt="8-Node Hexahedral Element" width="300"/>

#### Node positions and shape functions

| Node | $\xi$ | $\eta$ | $\zeta$ |
|----------|----------|----------|----------|
| 1 | -1 | -1 | -1 |
| 2 | 1 | -1 | -1 |
| 3 | 1 | 1 | -1 |
| 4 | -1 | 1 | -1 |
| 5 | -1 | -1 | 1 |
| 6 | 1 | -1 | 1 |
| 7 | 1 | 1 | 1 |
| 8 | -1 | 1 | 1 |
| 9 | 0 | -1 | -1 |
| 10 | 1 | 0 | -1 |
| 11 | 0 | 1 | -1 |
| 12 | -1 | 0 | -1 |
| 13 | 0 | -1 | 1 |
| 14 | 1 | 0 | 1 |
| 15 | 0 | 1 | 1 |
| 16 | -1 | 0 | 1 |
| 17 | -1 | -1 | 0 |
| 19 | 1 | -1 | 0 |
| 19 | 1 | 1 | 0 |
| 20 | -1 | 1 | 0 |

The shape functions for the 8-node element are defined as:

$$
N_i(\xi, \eta, \zeta) = \frac{1}{8} (1 + \xi_i \xi)(1 + \eta_i \eta)(1 + \zeta_i \zeta)
$$

where $i$ is the node indice.





