# valgrindr

A ~~minimal~~ docker image for testing  packages that have C++ code on Mac OS
with `valgrind` (such as `odin/naomi/TMB/eppasm`). The image is based on
`ubuntu` as `alpine` has a hard time to install `V8` - which surprisinglly is
required by multiple packages..

Included:

- R 3.6 (and R development suite)
- g++
- valgrind
- libxml2-dev
- libudunits2-dev
- libcurl4-openssl-dev
- libgdal-dev
- and the troublesome for `alpine linux`, `libv8`, which does not let us have a
  smaller size image

# Installation

- Install docker [on Mac](https://docs.docker.com/docker-for-mac/install/)
- Clone this repo and build the image by

```
git clone https://github.com/kklot/valgrindr
cd valgrindr
docker build -t valgrindr:latest .
```

This builds the Linux, installs R and necessities listed above.

# Workflow

R crashed on Mac after some implementation in C++ > Can't find where the errors
are > Spin up this image > Run the same code in this image with R debug flag
turn on.

## Quick `docker run` reference

`docker run -it --name mydb --rm -v /home/Users/test:/test valgrindr command`

- `docker run`: run a container instance based on an image
- `-it`: optional - open an interactive terminal
- `--name mydb`: optional - name the container as `mydb`, useful if we are
  going to reuse this image
- `--rm`: optional - remove the container after run? save space but will need
  to reinstall packages,...the next time we boot up this image.
- `-v`: mapping folder from our machine to the image, need to use absolute path
  (e.g., current directory need to be expanded from `.` to `$(PWD)`)
- `valgrindr`: the name we used in the previous `build` block.
- `command`: any valid command to run such as `R`, `sh`, `Rscript` 

## Example testing TMB code

Using the example in `ex` folder in this directory. `valgrind` is not designed
for bound checks but it can show where the problem is as this example.

### One line run

```bash
# Assuming current working directory is this repo clone, make the contents of
# `ex` available to the programs inside the image at path `/ex` and evaluate R's
# script
docker run --rm -v $(PWD)/ex:/ex valgrindr R -d valgrind -e 'setwd('/ex'); source('e.R')'
```

Looking for the file in question `e.cpp`, we see somthing like this

```bash
...
==1==    by 0x18283FBE: objective_function<double>::operator()() (e.cpp:8)
```

which means there is a problem at line 8.

```cpp
  Type dv1 = dv[1];
```

### Manually

We can start the image's console and do R directly as normal:

```bash
docker run --rm -v $(PWD)/ex:/ex valgrindr sh
R # this R has access to the ex
> setwd(ex)
> source('e.R')
```
