# NAPSaC_MILS
Fixed-point Arithmetics Primer is a MATLAB simulator that utilizes Fixed-point Designer to perform elementary arithmetics (+, -, *, /) of fixed-point numbers in the following models.
1. n-bit fixed-point
   1. without noise
   2. with noise
2. bit-slicing (using n-bit fixed-point to perform 2n-bit fixed-point arithmetics)
   1. without or with noise
   2. different truncation modes
3. n-bit fixed-point with modulator non-linearity 

## Directory hierarchy and function/script descriptions

    ├── src                       # Source code
    │   ├── util                  # Utility functions
    │       ├── trun.m            # Afi = trun(A,T) converts a floating point scalar/vector/matrix to a fixed-point scalar/vector/matrix of fixed-point type T.
    │       ├── split.m           # [Afi1, Afi2] = split(A,T1,T2) splits a floating point scalar/vector/matrix from fixed-point type T1 to high and low fixed-point scalar/vector/matrix of type T2.
    │       ├── bin2decT.m        # helper function for split, converts binary string to decimal numbers
    │       ├── noise.m           # n = noise(sigma) generates a random number noise from the normal distribution with 0 mean and standard deviation parameter sigma.
    │       ├── transfer.m        # y = transfer(phi,r) is the transfer function that takes phi as input floating-point scalar/vector/matrix and parameter r, and outputs y as floating-point scalar/vector/matrix.  
    │       └── recover.m         # phi = recover(y,r) is the recover function (exact inverse of the transfer function) that takes y as input floating-point scalar/vector/matrix and parameter r, and outputs phi as floating-point scalar/vector/matrix.
    │   ├── fi_add.m              # cfi = fi_add(a,b,T) performs a+b operation. Inputs a, b, and the output cfi are scalars of the same fixed-point type T.
    │   ├── fi_sub.m              # cfi = fi_sub(a,b,T) performs a-b operation. Inputs a, b, and the output cfi are scalars of the same fixed-point type T.
    │   ├── fi_mul.m              # cfi = fi_mul(a,b,T) performs a*b operation. Inputs a, b, and the output cfi are scalars of the same fixed-point type T.
    │   ├── fi_div.m              # cfi = fi_div(a,b,T) performs a/b operation. Inputs a, b, and the output cfi are scalars of the same fixed-point type T.
    │   ├── noisy_mul.m           # c = noisy_mul(a,b,nDAC,nbit,nflag) performs a*b for model 1. Inputs a, b are floating-point numbers and output c is fixed-point number. nflag is the flag whether to include noise, nDAC and nbit are parameters for noise level.
    │   ├── bs_mul.m              # c = bs_mul(a,b,nDAC,nbit,nflag) performs a*b for model 2. Inputs a, b are floating-point numbers and output c is fixed-point number. nflag is the flag whether to include noise, nDAC and nbit are parameters for noise level.
    │   ├── transfer_mul.m        # c = transfer_mul(a,b,nDAC,nbit,nflag,r) performs a*b for model 3. Inputs a, b are floating-point numbers and output c is fixed-point number. nflag is the flag whether to include noise, nDAC and nbit are parameters for noise level, r is the transfer function parameter.
    ├── test                      # Test scripts
    │   ├── test_trun.m           # Interactive script to demonstrate truncating a floating point number to an arbitrary bit of fixed point number 
    │   ├── test_split.m          # Interactive script to demonstrate splitting a 2*n bit fixed point number to high and low n bit fixed point number
    │   ├── test_transfer.m       # Plot of transfer function given an input array
    │   ├── test_recover.m        # Plot of recover function given an input array
    │   ├── test_fi_arith.m       # Interactive script to demonstrate elementary arithmetics (+, -, *, /) of fixed-point numbers
    │   ├── test_noisy_mul.m      # General testing for n-bit fixed-point scalar multiplication with and without noise. Plot the distribution of with and without noise error. 
    │   ├── test_bs_mul.m         # General testing for bit-slicing fixed-point scalar multiplication. Plot the distribution of error w.s.t. noise and truncations. 
    │   └── test_transfer_mul.m   # General testing for n-bit fixed-point scalar multiplication with modulator non-linearity. Plot the distribution of with and without transfer function error. 
  
  
  
  
  
  
