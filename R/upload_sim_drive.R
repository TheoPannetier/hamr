#' Upload simulation files to Google Drive
#'
#' Given a vector of job IDs, will upload the corresponding `.csv` or `.log`
#' files from the local computer to my Google Drive account.
#'
#' @param job_ids 8-digit numeric or character vector. Peregrine job IDs
#' identifying the files to download.
#'
#' @author Théo Pannetier
#' @name upload_sim_drive
NULL

#' @export
#' @rdname upload_sim_drive
upload_sim_csv_drive <- function(job_ids) {

  files <- glue::glue(
    "~/Github/comrad_fabrika/data/sims/comrad_sim_{job_ids}.csv"
  )
  purrr::walk(
    files,
    function(file) {
      googledrive::drive_upload(
        media = file,
        path = "comrad_data/sims/"
      )
    }
  )

}

#' @export
#' @rdname upload_sim_drive
upload_sim_log_drive <- function() {
  files <- glue::glue(
    "~/Github/comrad_fabrika/data/logs/comrad_sim_{job_ids}.log"
  )
  purrr::walk(
    files,
    function(file) {
      googledrive::drive_upload(
        media = file,
        path = "comrad_data/logs/"
      )
    }
  )
}