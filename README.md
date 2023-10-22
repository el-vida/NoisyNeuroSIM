# NoisyNeuroSIM

This repository was created to explain the implementation of the NeuroSIM benchmarking tool at the HPC cluster of RWTH Aachen University which was part of my work as student assistant at the [Institute for Communication Technologies and Embedded Systems (ICE)](https://www.ice.rwth-aachen.de), for the use of simulating noise characteristics of crossbars.

------------------------------------------------------------------------------------------------------------------------------------------------

## Table of Content

1. How to get an HPC Account
2. How to set up NeuroSIM on HPC cluster
3. How to run NeuroSIM on HPC cluster
4. Useful commands
5. NeuroSIM - How it works

------------------------------------------------------------------------------------------------------------------------------------------------

## 1. How to get an HPC account

As a student of RWTH Aachen University, you can connect your student account with the HPC-Cluster. 
More information is provided at the [website the IT center of RWTH](https://help.itc.rwth-aachen.de/service/rhr4fjjutttf/article/14573fc745ee478ba855539c240108b6/).

Alternatively, for more sophisticated usage, it is possible to [access more computing resources on the HPC cluster in form of a registered project](https://help.itc.rwth-aachen.de/service/rhr4fjjutttf/article/45825b06afb647e194be4a5b9f5b8768/ ), which can be accessed by students and researchers of RWTH.

In this project, we decided to use the GPU-node of the cluster ("login18-g-2"), as NeuroSIM needs nvidia drivers to run properly on the cluster. For more information on the cluster nodes available to students, please consider the following [website](https://help.itc.rwth-aachen.de/service/rhr4fjjutttf/article/3fb4cb953142422dbbb656c1c3253cff/).


## 2. How to set up NeuroSIM on HPC cluster

Once the account is created, the following steps have to be done in order to run NeuroSIM v1.4 on the HPC clusters:

### 2.1 - Get NeuroSIM V1.4

First, clone the repository for [NeuroSIM V1.4](https://github.com/neurosim/DNN_NeuroSim_V1.4) to a location of your preference.

### 2.2 - Modify NeuroSIM accordingly

Now, we substitute the files "Param.cpp", "train.py" and "inference.py" with the ones that can be found in this repository, in the folder "Code". Be aware that "Param.cpp" is in "Pytorch_inference/NeuroSIM/", and "inference.py" as well as "train.py" are located in "Pytorch_inference".

These have been modified according to the instructions in the manual and according to parameters which we fixed after discussion during my time as a student assistant at ICE. More details about these parameters can be found in the excel-file "NeuroSIM presentation - tables.xlsx" in this repository, in the folder "Documents".

### 2.3 - Modify and Import the shell-script 

In the folder "inference_pytorch", copy the file "jobscript-inference.sh" from this repository. This is a shell-script that uses all necessary commands to be used on RTWTH's HPC cluster. It defines the job-name, the memory size and the maximum duration of each job. Furthermore, all necessary modules on the cluster will be loaded such that NeuroSIM can operate properly on the cluster.

In the shell-script, you can define the parsing arguments of NeuroSIM. For instance, if you like to call inference.py using DenseNet40 with the CIFAR10 data set in floating point (FP) mode, doing inference-only, then you might call  

python inference.py --dataset cifar10 --model DenseNet40 --mode FP --inference 1

in the "### run NeuroSIM" section of the shell-script.

### 2-4 - Transfer the folder to the HPC cluster

Using scp-command on a terminal, you can copy your folder (called FOLDER_NAME), which lies on LOCAL_PATH to your HPC cluster space, using our RWTH TIM_ID, as follows:

scp -r /LOCAL_PATH/FOLDER_NAME TIM_ID@login18-g-2.hpc.itc.rwth-aachen.de:~/ .

Now NeuroSIM v1.4 is fully set up on your personal HPC cluster space, and it is ready to run.

## 3. How to run NeuroSIM on HPC cluster

First, you log into your HPC account on the GPU cluster.
Change directory to "Inference_pytorch".
You can now create a job using the following command:

sbatch --gpus=volta:1 --gpus-per-node=volta:1 --partition=c18g jobscript.sh .

This command will use one volta-gpu on one node on the c18g-compute node, and run the shell-script jobscript.sh .

## 4. Useful commands

This is a collection of useful terminal commands that were crucial for my work on this project, which I would like to share with anyone working on similar benchmarking projects.

## "Global" Variables

Here is a brief explanation of variable names, which are used later in the commands as substitutions for your individual case, like path names or ids.

TIM_ID                     is cour RWTH ID. <br />
PATH_TO_NEUROSIM           is your local path to the NeuroSIM folder. <br />
HPC_PATH_TO_NEUROSIM       is the path to the NeuroSIM folder on the HPC cluster. <br />
JOB-ID                     is the specific ID of your job submitted to the HPC cluster by calling the jobscript using sbatch. <br />

### 4.1  - LOGGING IN, SYNCHRONIZING

a) ssh -l TIM_ID login18-g-2.hpc.itc.rwth-aachen.de --> log in to GPU node of RWTH Cluster! <br />
b) rsync -avzh -e ssh /PATH_TO_NEUROSIM TIM_ID@login18-g-2.hpc.itc.rwth-aachen.de:/HPC_PATH_TO_NEUROSIM --> synchronize code on both platform <br />
c) scp TIM_ID@login18-g-2.hpc.itc.rwth-aachen.de:~/HPC_PATH_TO_NEUROSIM/Inference_pytorch/output_JOB-ID.txt DESIRED_COPY_DESTINATION_PATH --> secure copy certain files from one to another location <br />

### 4.2 - RWTH CLUSTER, JOB SUBMISSION, JOB ENQUIRY

a) squeue -j 12345678 --> ask for status on job ID 12345678 (R:running, P:pending) <br />
b) sacct --> summary of all submitted jobs <br />
c) sbatch --gpus=volta:1 --gpus-per-node=volta:1 --partition=c18g jobscript.sh --> submit job to 1 certain NVIDIA Volta-GPU <br />


### 4.3 - MODIFY DOCUMENTS

a) vim jobscript.sh --> read and modify document called "jobscript.sh" <br />
b) --> a) "i" insert mode: modifying document becomes now possible + ESC to terminate insert mode <br />
c) --> b) ":wq!" : exit file <br />

### 4.4 - HPC Cluster Core Hours

a) r_wlm_usage -q --> checking monthly or yearly core hour usage of RWTH cluster!

## 5. NeuroSIM - How it works

For this, please refer to the NeuroSIM manual.

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



