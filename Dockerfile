FROM ubuntu:latest
RUN apt update
RUN apt upgrade -y
RUN apt install git -y
RUN apt install build-essential cmake valgrind r-base r-base-core r-base-dev -y
RUN apt install r-cran-tmb r-cran-cpp r-cran-rcppeigen -y
