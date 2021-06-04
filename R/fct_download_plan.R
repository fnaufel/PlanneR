# Function to handle download of the plan, in several file formats.
# This function also removes the modal dialog window.
download_plan <- function(table, extension) {
  shiny::downloadHandler(
    # Use function to ensure call to Sys.time()
    filename = function() {
      paste0(
        format(Sys.time(), '%y-%m-%d'),
        '-plano',
        extension
      )
    },
    content = function(file) {
      temp <- tempfile(fileext = extension)
      gt::gtsave(table, temp)
      file.copy(temp, file)
      shiny::removeModal()
    }
  )
}

