% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_comrad_sim_hpc.R
\name{run_comrad_sim_hpc}
\alias{run_comrad_sim_hpc}
\title{Run comrad simulations on the Peregrine HPC}
\usage{
run_comrad_sim_hpc(
  nb_gens,
  params_array = fabrika::create_comrad_params() \%>\% expand.grid(),
  nb_replicates = 1,
  sampling_on_event = FALSE,
  sampling_freq = ifelse(sampling_on_event, NA, 200),
  sampling_frac = comrad::default_sampling_frac(),
  seeds = sample(1:50000, nb_replicates * nrow(params_array)),
  walltime = "00:57:00",
  check_comrad_version = TRUE,
  brute_force_opt = "simd_omp"
)
}
\arguments{
\item{nb_gens}{integer, how many generations should the simulation be run
for? Length must be either 1 (all jobs are given the same number of
generations) or `nrow(params_array)` (custom value for each job).
walltime for each job).}

\item{params_array}{a data frame containing all combinations of `comrad`
parameters to submit. One column per parameter, one row for each unique
combination of values. Tip: use [create_comrad_params()] to provide the
parameter values, then combine the output with [base::expand.grid()] as in
the default.}

\item{nb_replicates}{numeric, number of replicate simulations to run.
Each unique combination of parameters in `params_array` will be submitted
`nb_replicates` times.}

\item{sampling_on_event}{logical. If `TRUE`, the community is sampled every
time a speciation or extinction happens, and `sampling_freq` is ignored and
must be set to `NA`.}

\item{sampling_freq}{numeric \code{> 0}, the frequency (in generations) at
which the community is written to output. See [comrad::set_sampling_freq()]
for the default option.}

\item{sampling_frac}{numeric (between 0 and 1), fraction of the community
(in terms of individuals) written to output at every sampled generation. A
truncation is operated.}

\item{seeds}{numeric vector of integers, to seed simulations with. Length
must be `nrow(params_array) * nb_replicates`, i.e each job receives a unique
seed. This is because each simulation job is run in an independent session,
so simulations run with the same seed will be identical. Use this to repeat
simulations, otherwise use the default.}

\item{walltime}{character, maximum time allocated by the HPC to a job.
Format must be either `HH:MM:SS` or `D-HH:MM:SS`. Length must be either 1
(all jobs are given the same walltime) or `nrow(params_array)` (custom
walltime for each job).}

\item{check_comrad_version}{logical. If `TRUE`, `fabrika` compares installed
versions of `comrad` on HPC vs local before running the simulations, and
return an error if they mismatch.}

\item{brute_force_opt}{a string specifying which brute force option to use
to speed up the calculation of competition coefficients. Defaults to
"simd_omp". Other options are "omp", for multithreading with OpenMP, "simd"
for single instruction, multiple data (SIMD) via the C++ library
[`xsimd`](https://github.com/xtensor-stack/xsimd); and "simd_omp" for both.}
}
\description{
Calls `run_comrad_sim.bash` and passes arguments to
[comrad::run_simulation()], submits the simulation jobs through [ssh] to
Peregrine.
}
\author{
Théo Pannetier
}
