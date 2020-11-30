#' Installs bioinformatics tools.
#'
#' This function downloads and compiles the source files of all the
#' requested tools. However, it may not provide
#' all the libraries and dependencies necessary for their succesful installation,
#' therefore, they have to be installed beforehand as described in the README.md
#' or at https://github.com/TearsWillFall/BTools

#' @param whitelist Installs only whitelisted tools
#' @param blacklist Installs all tools available except blacklisted tools
#' @export


install_tools=function(whitelist=NA,blacklist=NA){

  dependencies=c()
  if (any(!is.na(whitelist)) & any(!is.na(blacklist))){
    print ("Whitelist and Blacklist arguments are self-excluding")
    stop()
  }

  urls=list(FastQC="https://github.com/s-andrews/FastQC.git",
  skewer="https://github.com/relipmoc/skewer.git",samtools="https://github.com/samtools/samtools.git",
  bwa="https://github.com/lh3/bwa.git",htslib="https://github.com/samtools/htslib.git",
  picard="https://github.com/broadinstitute/picard.git",hmmcopy_utils="https://github.com/shahcompbio/hmmcopy_utils.git",
  ichorCNA="https://github.com/broadinstitute/ichorCNA.git",bedtools="https://github.com/arq5x/bedtools2.git",
  libgtextutils="https://github.com/agordon/libgtextutils.git",fastx_toolkit="https://github.com/agordon/fastx_toolkit.git",bamUtil="https://github.com/statgen/bamUtil.git",
  sambamba="https://github.com/biod/sambamba.git",gatk="https://github.com/broadinstitute/gatk.git",platypus="https://www.rdm.ox.ac.uk/resolveuid/599a7efc8ec04059a101c59714353209")

  if (any(grepl("samtools",whitelist))){
    dependencies=append(dependencies,"htslib")
  }

  if (any(grepl("fastx_toolkit",whitelist))){
    dependencies=append(dependencies,"libgtextutils")
  }

  if (any(!is.na(whitelist))){
    whitelist=append(whitelist,dependencies)
    urls=urls[whitelist]
  }else if (any(!is.na(blacklist))){
    blacklist=append(blacklist,dependencies)
    urls=urls[names(urls) != blacklist]
  }


  dir.create("tools")

  setwd("./tools")

    f=function(y,x){
      print(paste("Fetching source code for:",y))
      if (y!="platypus"){
        print(paste("git clone --recursive",x))
        system(paste("git clone --recursive",x))
      else{
        print(paste("wget",x))
        system(paste("wget",x))
      }
    }
    mapply(names(urls),urls,FUN=f )


  if(any(grepl("FastQC",names(urls)))){
    setwd("./FastQC")
    print("Compiling source code for: FastQC")
    system("sed -i 's/<property name=\"target\" value=\"*.*\"/<property name=\"target\" value=\"1.6\"/' build.xml")
    system("sed -i 's/<property name=\"source\" value=\"*.*\"/<property name=\"source\" value=\"1.6\"/' build.xml")
    system("ant")
    system("chmod 755 bin/fastqc")
    setwd("..")


  }

  if(any(grepl("skewer",names(urls)))){
    setwd("./skewer")
    print("Compiling source code for: skewer")
    system("make")
    setwd("..")
  }


  if(any(grepl("htslib",names(urls)))){
    setwd("./htslib")
    print("Compiling source code for: htslib")
    system("autoheader")
    system("autoconf -Wno-syntax")
    system("./configure")
    system("make")
    setwd("..")
  }



  if(any(grepl("bwa",names(urls)))){
    setwd("./bwa")
    print("Compiling source code for: bwa")
    system("make")
    setwd("..")
  }

  if(any(grepl("samtools",names(urls)))){
    setwd("./samtools")
    print("Compiling source code for: samtools")
    system("autoheader")
    system("autoconf -Wno-syntax")
    system("./configure")
    system("make")
    setwd("..")
  }


  if(any(grepl("picard",names(urls)))){
    setwd("./picard")
    print("Compiling source code for: picard")
    system("./gradlew shadowJar")
    setwd("..")
  }

  if(any(grepl("hmmcopy_utils",names(urls)))){
    setwd("./hmmcopy_utils/")
    print("Compiling source code for: hmmcopy_utils")
    system(paste("cmake",getwd()))
    system("make")
    setwd("..")
  }



  if(any(grepl("bedtools",names(urls)))){
    setwd("./bedtools2")
    print("Compiling source code for: bedtools")
    system("make")
    setwd("..")
  }


  if(any(grepl("libgtextutils",names(urls)))){
    setwd("./libgtextutils")
    print("Compiling source code for: libgtextutils")
    system("./reconf")
    confg=getwd()
    system(paste0("./configure --prefix=",confg))
    system("make")
    system("make install")
    setwd("..")
  }

  if(any(grepl("fastx_toolkit",names(urls)))){
    setwd("./fastx_toolkit")
    print("Compiling source code for: fastx_toolkit")
    system("sed -i 's/usage();/usage(); exit(0);/' src/fasta_formatter/fasta_formatter.cpp")
    system("./reconf")
    system(paste0("export PKG_CONFIG_PATH=",confg,"; ./configure --prefix=",getwd()))
    system("make")
    system("make install")
    setwd("..")
  }

  if(any(grepl("bamUtil",names(urls)))){
    setwd("./bamUtil")
    print("Compiling source code for: bamUtil")
    system("make cloneLib")
    system("make")
    system(paste0("make install INSTALLDIR=",getwd()))
    setwd("..")
  }

  if(any(grepl("sambamba",names(urls)))){
    setwd("./sambamba")
    print("Compiling source code for: sambamba")
    system("make")
    setwd("./bin")
    system("find . -type f -not -name '*.o' -execdir mv {} sambamba ';'")
    setwd("..")
    setwd("..")
  }

  if(any(grepl("gatk",names(urls)))){
    setwd("./gatk")
    print("Compiling source code for: gatk")
    system("git lfs pull --include src/main/resources/large")
    system("./gradlew bundle")
    setwd("..")
  }

  if(any(grepl("platypus",names(urls)))){
    files=list.files()
    files=files[grepl("latypus",files)]
    system(paste0("tar xvf ",files))
    setwd(paste0("./",files))
    print("Compiling source code for: platypus")
    system("./buildPlatypus.sh")
    setwd("..")
  }



  setwd("..")
}
