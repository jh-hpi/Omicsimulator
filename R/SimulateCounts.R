#' Simulate Counts
#'
#' @param count_matrix
#' @param genes_dictionary
#'
#' @return
#' @export
#'
#' @examples
SimulateCounts <- function(count_matrix, genes_dictionary){

  # Create progress bar
  progress_bar <- txtProgressBar(min = 0, max = nrow(count_matrix), style = 3)

  # Increase or decrease expression values, if necessary
  if(!is.null(genes_dictionary)){

    for (row in 1:nrow(count_matrix)){

      setTxtProgressBar(progress_bar, row)

      # Manipulate expression values
      if(rownames(count_matrix)[row] %in% ls(genes_dictionary)){

        # Calculate Standard Derivation for gene
        sd <- sd(count_matrix[row, 1:ncol(count_matrix)])

        # Increasing or decreasing Influence
        influence <- get(toString(rownames(count_matrix)[row]), genes_dictionary)

        # Increase or decrease expression value
        count_matrix[row, ] <- count_matrix[row, ] + sd * influence * 20

      }
    }
  }

  close(progress_bar)

  cat("DONE.\n")

  return(count_matrix)
}
