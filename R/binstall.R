extract_packages <- function(lines) {
  # Split lines into individual calls using semicolon as a delimiter
  lines_split <- unlist(strsplit(lines, "\n"))
  
  # Trim whitespace around each line
  lines_trimmed <- trimws(lines_split)
  
  # Extract package names using regex
  package_names <- gsub("^library\\((.*?)\\)$", "\\1", lines_trimmed)
  
  # Remove invalid entries (non-library calls)
  package_names <- package_names[grepl("^library\\(", lines_trimmed)]
  
  return(package_names)
}

# Function to load packages
bload <- function(package_list) {
  # Load all packages
  invisible(sapply(package_list, function(pkg) {
    if (!require(pkg, character.only = TRUE)) {
      stop(paste("Package", pkg, "could not be loaded."))
    }
  }))
  message("All packages are loaded.")
}

# Function to install packages
#' @export
binstall <- function(librarylines) {
  # Extract package names
  package_list <- extract_packages(librarylines)
  # Identify missing packages
  missing_packages <- package_list[!(package_list %in% installed.packages()[, "Package"])]
  installed_packages <- package_list[(package_list %in% installed.packages()[, "Package"])]
  
  if (length(missing_packages) > 0) {
    # Ask the user to install the missing packages
    message("The following packages are installed: \n   - ", paste(installed_packages, collapse = "\n   - "))
    message("The following packages are missing: \n   - ", paste(missing_packages, collapse = "\n   - "))
    install_response <- readline(prompt = "Do you want to install the missing packages? (y/n): ")
    
    if (tolower(install_response) %in% c("yes", "y")) {
      message("Installing missing packages...")
      install.packages(missing_packages)
      message("Installation complete.")
    } else {
      message("Skipping installation.")
    }
  } else {
    message("All packages are already installed.")
  }
  
  # Ask the user to load the packages
  load_response <- readline(prompt = "Do you want to load the packages now? (y/n): ")
  
  if (tolower(load_response) %in% c("yes", "y")) {
    bload(package_list)
  } else {
    message("Skipping package loading.")
  }
}

#' @export
buninstall <- function(librarylines) {
    # Extract package names
    package_list <- extract_packages(librarylines)
  
    # Identify installed packages from the list
    installed_packages <- package_list[package_list %in% installed.packages()[, "Package"]]
    
    if (length(installed_packages) > 0) {
      # Display the installed packages that can be uninstalled
      message("The following packages are installed and can be uninstalled: \n   - ", 
              paste(installed_packages, collapse = "\n   - "))
      
      # Ask the user to uninstall these packages
      uninstall_response <- readline(prompt = "Do you want to uninstall these packages? (y/n): ")
      
      if (tolower(uninstall_response) %in% c("yes", "y")) {
        # Uninstall every package
        sapply(installed_packages, function(pkg) {
          message("Uninstalling package: ", pkg)
          remove.packages(pkg)
        })
        message("Uninstallation complete.")
      } else {
        message("Uninstallation cancelled.")
      }
    } else {
      message("None of the specified packages are installed.")
    }
  }
