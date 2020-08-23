#' Download simulation files from Peregrine
#'
#' Given a vector of job IDs, will download the corresponding `.csv` or `.log`
#' files from Peregrine to the local instance of `comrad_fabrika`.
#'
#' @param job_ids 8-digit numeric or character vector. Peregrine job IDs
#' identifying the files to download.
#'
#' @author Théo Pannetier
#' @name download_sim_hpc
NULL

#' @export
#' @rdname download_sim_hpc
download_sim_csv_hpc <- function(job_ids) {

  if (!all(stringr::str_length(job_ids) == 8)) {
    stop("Invalid input: job_ids must have 8 digits.")
  }

  # Connect to hpc
  session <- ssh::ssh_connect(
    "p282688@peregrine.hpc.rug.nl"
  )
  # Files to download
  files <- glue::glue(
    "/data/$USER/comrad_fabrika/data/sims/comrad_sim_{job_ids}.csv"
  )
  # Get ssh to download files
  purrr::walk(
    files,
    function(file) {
      ssh::scp_download(
        session = session,
        files = file,
        to = "~/Github/comrad_fabrika/data/sims/"
      )
    }
  )
  ssh::ssh_disconnect(
    session = session
  )
}

#' @export
#' @rdname download_sim_hpc
download_sim_log_hpc <- function(job_ids) {

  if (!all(stringr::str_length(job_ids) == 8)) {
    stop("Invalid input: job_ids must have 8 digits.")
  }

  # Connect to hpc
  session <- ssh::ssh_connect(
    "p282688@peregrine.hpc.rug.nl"
  )
  # Files to download
  files <- glue::glue(
    "/data/$USER/comrad_fabrika/data/logs/comrad_sim_{job_ids}.log"
  )
  # Get ssh to download files
  purrr::walk(
    files,
    function(file) {
      ssh::scp_download(
        session = session,
        files = file,
        to = "~/Github/comrad_fabrika/data/logs/"
      )
    }
  )
  ssh::ssh_disconnect(
    session = session
  )
}
