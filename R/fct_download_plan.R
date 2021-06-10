# Function to handle download of the plan, in several file formats.
# This function also removes the modal dialog window.
download_plan <- function(rv, extension) {
  shiny::downloadHandler(
    # Use function to ensure call to Sys.time()
    filename = function() {
      paste0(
        format(Sys.time(), '%Y.%m.%d_%Hh%Mm%Ss'),
        '-plano',
        extension
      )
    },
    content = function(file) {
      gt::gtsave(rv$gt_table, file)
      shiny::removeModal()
    }
  )
}

