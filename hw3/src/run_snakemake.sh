#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --partition=main
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --output=logs/snakemake_%j.log

#Paleidžia visą snakemake darbo eigą kapi SLURM darbą
#Paleidimas iš ~/BST/hw3: sbatch src/run_snakemake.sh

source ~/miniforge3/etc/profile.d/conda.sh
export PATH="$HOME/miniforge3/condabin:$PATH"
conda activate snakemake

snakemake --use-conda --executor slurm --jobs 10 --latency-wait 60 \
    --default-resources slurm_partition=main --rerun-triggers mtime --rerun-incomplete