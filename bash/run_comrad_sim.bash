#!/bin/bash
#SBATCH --partition=gelifes
#SBATCH --output=/data/%u/fabrika/comrad_data/logs/comrad_sim_%j.log

module load R

## Script description ##

## Parameters ##
NB_GENS=$2
SIG_A=$3
SIG_K=$4
K_OPT=$5
Z_OPT=$6
GROWTH=$7
PROB_MUT=$8
SIG_MU=$9
Z_DIST_SP=${10}
SWITCH_SIGK_AFTER=${11}
SWITCH_SIGK_TO=${12}
SAMPL_ON_EVENT=${13}
SAMPL_FREQ=${14}
SAMPL_FRAC=${15}
BRUTE_FORCE_OPT=${16}
SEED=${17}

## Write logbook entry ##
BATCH_ID=$1
TIME_SUBM=$(date "+%Y-%m-%d %H:%M:%S")
PKG_V=$( Rscript -e "packageVersion(\"comrad\")" ) # version on the HPC

echo "${BATCH_ID},${SLURM_JOB_ID},${TIME_SUBM},pending_check,NA,${NB_GENS},${SIG_A},${SIG_K},${K_OPT},${Z_OPT},${GROWTH},${PROB_MUT},${SIG_MU},${Z_DIST_SP},${SWITCH_SIGK_AFTER},${SWITCH_SIGK_TO},${SEED},${PKG_V},${SAMPL_ON_EVENT},${SAMPL_FREQ},${SAMPL_FRAC},${BRUTE_FORCE_OPT},NA,NA,NA,NA" >> /data/${USER}/fabrika/comrad_data/logs/logbook.csv

## Some job info ##
echo "job ID ${SLURM_JOB_ID}\n"

OUTPUT=/data/${USER}/fabrika/comrad_data/sims/comrad_sim_${SLURM_JOB_ID}.csv
echo "Output saved at ${OUTPUT}\n\n"

##  Run simulation ##

Rscript -e "comrad::run_simulation(path_to_output = \"${OUTPUT}\", nb_gens = ${NB_GENS}, competition_sd = ${SIG_A}, carrying_cap_sd = ${SIG_K}, carrying_cap_opt = ${K_OPT}, trait_opt = ${Z_OPT}, growth_rate = ${GROWTH}, prob_mutation = ${PROB_MUT}, mutation_sd = ${SIG_MU}, trait_dist_sp = ${Z_DIST_SP}, switch_carr_cap_sd_after = ${SWITCH_SIGK_AFTER}, switch_carr_cap_sd_to = ${SWITCH_SIGK_TO}, hpc_job_id = ${SLURM_JOB_ID}, seed = ${SEED}, sampling_on_event = ${SAMPL_ON_EVENT}, sampling_freq = ${SAMPL_FREQ}, sampling_frac = ${SAMPL_FRAC}, brute_force_opt = \"${BRUTE_FORCE_OPT}\")"
