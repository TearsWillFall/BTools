# BTools
BTools is a convienent way to install commonly used Bioinformatic tools from the publicly available source files at Github using R.
## 1. Description
BTools simplifies the installation process of some commonly Bioinformatics tools making them inmmediatly available to use.

**Tools:**
* [FastQC](https://github.com/s-andrews/FastQC):  A quality control analysis tool for high throughput sequencing data
* [skewer](https://github.com/relipmoc/skewer): Tool for processing next-generation sequencing (NGS) paired-end sequences
* [bedtools](https://github.com/arq5x/bedtools2): Bedtools utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks
* [libgtextutils](https://github.com/agordon/libgtextutils): The FASTX-Toolkit text manipulation library
* [fastx_toolkit](https://github.com/agordon/fastx_toolkit): The FASTX-Toolkit is a collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing
* [bwa](https://github.com/lh3/bwa): Burrow-Wheeler Aligner for short-read alignment
* [htslib](https://github.com/samtools/htslib): C library for high-throughput sequencing data formats
* [samtools](https://github.com/samtools/samtools/):Tools (written in C using htslib) for manipulating next-generation sequencing data
* [picard](https://github.com/broadinstitute/picard): A set of command line tools (in Java) for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF
* [hmmcopy_utils](https://github.com/shahcompbio/hmmcopy_utils): Tools for extracting read counts and gc and mappability statistics in preparation for running HMMCopy
* [ichorCNA](https://github.com/broadinstitute/ichorCNA): Estimating tumor fraction in cell-free DNA from Ultra-Low-Pass Whole Genome Sequencing
* [sambamba](https://github.com/biod/sambamba): Tools for working with SAM/BAM/CRAM data
* [gatk](https://github.com/biod/gatk): GATK tools

## 2. System Requirements


Tested on fresh Ubuntu and Arch Linux installations. Should be working on other Linux distros too as long as equivalent packages are provided.

In order to be able to download and compile the source files of all the required tools the following programs are required:
* git
* make
* gcc
* ant **Only required if installing FastQC**
* cmake
* autoconf
* libtool **Only required if installing fastx_toolkit/libgtextutils**
* ldc  **Only required if installing sambamba**
* lz4  **Only required if installing sambamba**
* go   **Only required when installing gatk**
* git lfs **Only required if installing gatk. When installed git lfs install needs to be run**

These tools can and should be installed using the terminal with the following commands:

* **For Ubuntu:**

  ```
  sudo apt install git make gcc ant cmake autoconf libtool ldc liblz4 libz git-lfs
  ```

* **For Arch Linux:**

  ```
  sudo pacman -S git ant make cmake gcc autoconf libtool ldc lz4 git-lfs
  ```

Additional dependencies may be needed to succesfully install `devtools` package in R:

* **For Ubuntu:**

  ```
  sudo apt install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev
  ```

* **For Arch Linux:**

  ```
  sudo pacman -S build-essential libcurl-gnutls libxml2-dev openssl



## 3. Installation Instructions

In order to install `BTools` package we will be using R `devtools`:

```
install.packages("devtools")
devtools::install_github("TearsWillFall/BTools")
```
If `devtools` package installation fails check System Requirements section, as you may be missing a dependency.


## 4. Usage

Using BTools is as easy as loading the `Btools` library and calling the `install_tools` function like this:

```
library("BTools")
install_tools()
```
Or alternatively,

```
BTools::install_tools()
```
If no arguments are provided this function will install all the tools available. To install only specific tools use the argument `whitelist=...` to pass a vector with the names of the desired tools to install. Use the argument `blacklist=...` to install all the tools except the ones specified here.

**Example**

In this example only the tools `FastQC` and `fastx_toolkit` will be installed.
```
BTools::install_tools(whitelist=c("FastQC","fastx_toolkit"))
```

In this example all the tools found in the Description section will be installed except `bedtools`,`bwa` and `ichorCNA`.
```
BTools::install_tools(blacklist=c("bedtools","bwa","ichorCNA"))
```
