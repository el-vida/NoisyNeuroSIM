# NoisyNeuroSIM

This repository was created to depict the establishment of the NeuroSIM benchmarking tool at the HPC cluster of RWTH Aachen University which was part of my work as student assistant at the Institute for Communication Technologies and Embedded Systems.

------------------------------------------------------------------------------------------------------------------------------------------------

## Table of Content

1. How to get a HPC Account
2. How to set up NeuroSIM on HPC cluster
3. How to run NeuroSIM on HPC cluster
4. Useful command
5. NeuroSIM - How it works

------------------------------------------------------------------------------------------------------------------------------------------------

## 1. How to get an HPC account


## 2. How to set up NeuroSIM on HPC cluster


## 3. How to run NeuroSIM on HPC cluster


## 4. Useful commands

### 4.1  - LOGGING IN, SYNCHRONIZING

a) ssh -l ev483159 login18-g-2.hpc.itc.rwth-aachen.de --> log in to GPU node of RWTH Cluster! <br />
b) rsync -avzh -e ssh /net/home/vida/vida/neurosim-test/DNN_NeuroSim_V2.1/ ev483159@login18-g-2.hpc.itc.rwth-aachen.de:/home/ev483159/neurosim-test --> synchronize code on both platform <br />
c) scp ev483159@login18-g-2.hpc.itc.rwth-aachen.de:~/neurosim-test-v14/NeuroSimV14/Inference_pytorch/output_38905658.txt /Users/eu_el/Desktop --> secure copy certain files from one to another location <br />

### 4.2 - RWTH CLUSTER, JOB SUBMISSION, JOB ENQUIRY

a) squeue -j 37714821 --> ask for status on job ID 37714821 (R:running, P:pending) <br />
b) sacct --> summary of all submitted jobs <br />
c) sbatch --gpus=volta:1 --gpus-per-node=volta:1 --partition=c18g jobscript.sh --> submit job to 1 certain NVIDIA Volta-GPU <br />

### 4.3 - MODIFY DOCUMENTS, 

a) vim jobscript.sh --> read and modify document called "jobscript.sh" 
b) --> a) "i" insert mode: modifying document becomes now possible + ESC to terminate insert mode
c) --> b) ":wq!" : exit file

### 4.4 - HPC Cluster Core Hours

a) r_wlm_usage -q --> checking monthly or yearly core hour usage of RWTH cluster!

## 5. NeuroSIM - How it works

------------------------------------------------------------------------------------------------------------------------------------------------

## References


[1] Shimeng Yu et. all, Compute-in-Memory Chips for Deep Learning: Recent Trends and Prospects. IEEE MCAS. August 2021. https://doi.org/10.1109/MCAS.2021.3092533   <br />
[2] X. Peng,et. all. DNN+NeuroSim V2.0: An End-to-End Benchmarking Framework for Compute-in-Memory Accelerators for Training, § IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems, doi: 10.1109/TCAD.2020.3043731, 2020.  <br />
[3] S. K. Gonugondla, Fundamental Limits on Energy-Delay-Accuracy of In-Memory Architectures in Inference Applications, in IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems, vol. 41, no. 10, pp. 3188-3201, Oct. 2022, doi: 10.1109/TCAD.2021.3124757.  <br />
[4] Nathan Laubeuf et all. Dynamic Quantization Range Control for Analog-in-Memory Neural Networks Acceleration. ACM Trans. Des. Autom. Electron. Syst. 27, 5, Article 46 (September 2022), 21 pages. https://doi.org/10.1145/3498328  <br />
[5] Fundamental Limits on the Precision of In-memory Architectures https://ieeexplore.ieee.org/document/9256802  <br />
[6] Joshi, V., Le Gallo, M., Haefeli, S. et al. Accurate deep neural network inference using computational phase-change memory. Nat Commun 11, 2473 (2020). https://doi.org/10.1038/s41467-020-16108-9  <br />
[7] Mackin, C., Rasch, M.J., Chen, A. et al. Optimised weight programming for analogue memory-based deep neural networks. Nat Commun 13, 3765 (2022). https://doi.org/10.1038/s41467-022-31405-1   <br />
[8] C. -Y. Chang, K. -C. Chou, Y. -C. Chuang and A. -Y. Wu, "E-UPQ: Energy-Aware Unified Pruning-Quantization Framework for CIM Architecture," in IEEE Journal on Emerging and Selected Topics in Circuits and Systems, vol. 13, no. 1, pp. 21-32, March 2023, doi: 10.1109/JETCAS.2023.3242761. <br /> 

------------------------------------------------------------------------------------------------------------------------------------------------

## Background

Analog In-Memory-Computing (AIMC) has emerged as an attractive alternative to conventional von Neumann (digital) architectures for addressing the energy and latency cost of memory accesses in data-centric machine learning workloads. Analog IMCs embed low-energy analogue computations in the memory array to execute machine learning computations such as matrix-vector multiply (MVM) and dot products (DPs). However, converting data between digital and analogue domains has a cost that must be carefully studied.



