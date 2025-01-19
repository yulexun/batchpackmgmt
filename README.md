# Batch Package Install

This R package simplifies the process of managing multiple R packages with functions to extract, install, load, and uninstall packages in bulk based on library() calls. 

## Features

- **Batch Installation**: Install multiple missing packages and provide user prompts for confirmation.
- **Batch Loading**: Load all specified packages with error handling.
- **Batch Uninstallation**: Uninstall multiple packages with user confirmation.

## Installation

```
library(devtools)
install_github("yulexun/bulkpkginstall")
```

## Functions

### `binstall(librarylines)`

Installs and loads R packages from a string containing library() calls.

#### Arguments

- `librarylines`: A string of R code with `library()` calls.

#### Functionality

1. Checks for missing packages.
2. Prompts the user to install missing packages.
3. Optionally loads all packages.

### `buninstall(librarylines)`

Uninstalls packages based on a string of library() calls.

#### Arguments

- `librarylines`: A string of R code with `library()` calls.

#### Functionality

1. Identifies installed packages.
2. Prompts the user to confirm uninstallation.
3. Uninstalls specified packages.

## Usage Example

```
# Example library() calls as a string
library_lines <- "
library(ggplot2)
library(dplyr)
library(tidyverse)
"

# Install and load packages
binstall(library_lines)

# Uninstall packages
buninstall(library_lines)
```

## License

This project is licensed under the MIT License. See the [`LICENSE.txt`](https://github.com/yulexun/batchpkginstall/blob/main/LICENSE.txt) file for details.

