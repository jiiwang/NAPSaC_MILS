# NAPSaC_MILS
Fixed-point Arithmetics Primer is a MATLAB simulator for electrical-optical computing devices that utilizes Fixed-point Designer to perform elementary arithmetics (+, -, *, /) of fixed-point numbers in the following models.
The goal is to achieve n-bit precision with limited m bits (m < n).
1. n-bit fixed-point
   1. without noise
   2. with noise
2. bit-slicing (partition n-bit fixed-point into m-bit slices, and perform m-bit fixed-point arithmetics)
   1. without or with noise
   2. different truncation modes
   3. equal length or variable length bit-slicing
3. n-bit fixed-point with modulator non-linearity 
