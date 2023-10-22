#!/usr/bin/zsh

### SBATCH Section
# directives need to be in the beginning of the jobscript

#SBATCH --job-name=NeuroSim_DryRun

### Time your job needs to execute, e. g. 30 min
#SBATCH --time=06:30:00

### Memory your job needs per node, e. g. 15 GB
#SBATCH --mem=15G

### Your Program Section
# goes here, the second part of the jobscript


### load all necessary modules
module purge # unload all modules

#module unload intel/2022a
#module unload GCCcore/.11.3.0
#module load intel-compilers/2022.1.0
module load nvidia-driver/default
module load CUDA/11.3.1
module load GCCcore/.10.3.0
#module load GCCcore/.11.3.0
#module load Python/3.9.6
module load GCC/10.3.0
module load OpenMPI/4.1.1
module load Python/3.9.5 # needs GCCcore/.10.3.0 or GCCcore/.11.2.0
module load PyTorch/1.10.0-CUDA-11.3.1 #needs OpenMPI/4.1.1 and GCC/10.3.0
module load torchvision/0.11.1-CUDA-11.3.1 #needs OpenMPI/4.1.1 and GCC/10.3.0
#module unload intel/2022a
#module load cppy

### Wait until load is finished
sleep 5s

### Compile HW simulator files
cd NeuroSIM 
make clean
make
sleep 15s
cd ../

### Run NeuroSIM

### EXAMPLE 1
#python ./inference.py --dataset cifar10 --model VGG8 --mode WAGE --inference 1 --cellBit 1 --subArray 128 --parallelRead 64

### EXAMPLE 2
# python ./inference.py --dataset cifar10 --model DenseNet40 --mode WAGE --inference 1 --cellBit 2 --ADCprecision 6

### EXAMPLE 3 -- does not work unfortunately
# python inference.py --dataset imagenet --model ResNet18 --mode FP --inference 1 --onoffratio 100

### OTHER EXAMPLES (not from manual)
python ./inference.py --dataset cifar10 --model DenseNet40 --mode WAGE --inference 1

# Comments:
# With Python 3.7.4, 3.8.2, 3.8.6 --> numpy version is not compatible
