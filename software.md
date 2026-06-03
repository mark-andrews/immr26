# Software installation

All software required for this workshop is free and open source, and runs identically on Windows, macOS, and Linux.

## Installing R

Download R from [https://www.r-project.org](https://www.r-project.org) and follow the links for your platform.

On Windows, the installer is at [https://cran.r-project.org/bin/windows/base/](https://cran.r-project.org/bin/windows/base/).

On macOS, the installer is at [https://cran.r-project.org/bin/macosx/](https://cran.r-project.org/bin/macosx/).

Run the downloaded installer and follow the standard process for your operating system.
R does not require any special configuration after installation.

## Installing an IDE

You will want an integrated development environment for working with R.
Two good options are available.

[RStudio](https://posit.co/download/rstudio-desktop/) is the most established IDE for R and the one most participants will be familiar with.
Download the free Desktop edition from [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/).

[Positron](https://positron.posit.co) is a newer IDE from the same team, built on VS Code, with strong support for both R and Python.
It is a good choice if you already use VS Code or want a more modern editor experience.
Either IDE is fine for this course.

## Installing R packages

Once R is installed, open R or your IDE and run the following to install all packages used in the course.

```r
install.packages(c(
  "tidyverse",   # data manipulation and visualisation
  "lme4",        # linear and generalised linear mixed effects models
  "lmerTest",    # p-values and F-tests for lme4 models
  "emmeans",     # estimated marginal means and contrasts
  "simr",        # power analysis for mixed effects models by simulation
  "performance", # model diagnostics and R-squared for mixed models
  "MuMIn"        # additional R-squared metrics (r.squaredGLMM)
))
```

Installation may take a few minutes the first time, as some packages have compiled components.
If you are prompted to install from source, accepting the pre-compiled binary is usually the simpler option.
