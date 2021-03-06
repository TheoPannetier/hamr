run_dd_ml_hpc_with_fossil2 <- function(siga, sigk, dd_model, i, job_id) {
  if (!is_on_peregrine()) {
    stop("This function is only intended to be run on the Peregrine HPC.")
  }
  cat(
    glue::glue("siga = {siga} sigk = {sigk}\nFitting DD model {dd_model$name}  on tree {i}\n\n")
  )
  # Load data
  phylos <- readRDS(
    glue::glue("/data/p282688/fabrika/comrad_data/phylos/comrad_phylos_sigk_{sigk}_siga_{siga}_full.rds")
  )
  phylo <- phylos[[i]]
  waiting_times_tbl <- comrad::waiting_times(phylo)

  # Draw initial parameter values
  init_params_ls <- comrad::draw_init_params_dd_ml(
    phylos = phylos,
    nb_sets = 100,
    dd_model = dd_model
  )
  # Run ml for each initial parameter set
  ml <- purrr::imap_dfr(
    init_params_ls,
    function(init_params, i) {
      cat("init params:", i , "/", length(init_params_ls), "\n")
      print(init_params)
      comrad::fit_dd_model_with_fossil(
        waiting_times_tbl = waiting_times_tbl,
        dd_model = dd_model,
        init_params = init_params,
        num_cycles = Inf
      )
    })
  ml <- dplyr::mutate(
    ml,
    "tree" = i,
    "job_id" = job_id,
    "with_fossil" = TRUE,
    "carrying_cap_sd" = sigk,
    "competition_sd" = siga,
    .before = "init_lambda_0"
  )
  # Save output
  saveRDS(
    ml,
    glue::glue(
      "/data/p282688/fabrika/comrad_data/ml_results/dd_ml_with_fossil_{job_id}.rds")
  )
}

