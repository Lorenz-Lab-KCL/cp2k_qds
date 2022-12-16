Magic Cluster InP_QDs
=========================

In this repository a set of new folders have been created with the aim of
computing ground state and excited state properties. A small benchmark with
4 different exchange-correlations (XC) will be performed using ARCHER2.

The list of folders is the following:

1. **ir:** Infrared calculation for 4 different XC (B3LYP, PBE0, HSE0 and PBE).
2. **uv-vis:** Absorption spectra for 4 different XC (B3LYP, PBE0, HSE0 and PBE).

All inputs are working, it is only needed to add the corresponding **job.sh** for ARCHER2
using large memory nodes (I reckon we need the 4 nodes here).

TO DO:
=======

Inputs for Raman-spectroscopy.
