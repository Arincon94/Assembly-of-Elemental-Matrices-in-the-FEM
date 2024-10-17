# Finite Element Analysis Project

## Description
This repository contains the implementation of a finite element method for analyzing solid structures, focusing on 8-node and 20-node hexahedral elements.

### 8-Node Hexahedral Element

The 8-node hexahedral element is defined by nodes positioned at each corner of the cubic element. This element is essential for modeling solid mechanics problems.

#### Shape Functions

The shape functions for the 8-node element are defined as:

$$
N_i(\xi, \eta, \zeta) = \frac{1}{8} (1 + \xi)(1 + \eta)(1 + \zeta)
$$

where \(i = 1, \ldots, 8\) are the node indices.

#### Element Configuration

Below is a diagram illustrating the configuration of the 8-node hexahedral element:

<img src="Figures/8nodes.svg" alt="8-Node Hexahedral Element" width="300"/>
