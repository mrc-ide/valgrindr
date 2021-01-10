FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt upgrade -y
RUN apt install git -y
RUN apt install build-essential cmake valgrind r-base r-base-core r-base-dev -y
RUN apt install libxml2-dev libudunits2-dev libcurl4-openssl-dev libnode-dev libgdal-dev
