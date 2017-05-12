# On the Expressive Power of User-Defined Effects:
# Effect Handlers, Monadic Reflection, Delimited Control

This repository contains Abella formalization of proofs in the paper and
instructions on how to set up an environment in which to evaluate them.

## Set up

You have three options for setting up your environment.

### Using a provided Docker image

The easiest way is running a precompiled Docker image, which already contains
everything you need to evaluate the proofs. To do so, you first need to
[install Docker](https://docs.docker.com/engine/installation/). With Docker in
place, you first need to run

    docker pull matijapretnar/abella:icfp2017

which will download the Docker image. Next, using

    docker run --interactive --tty matijapretnar/abella:icfp2017

you will start an interactive Bash session in which you can evaluate the proof
following the instructions below. In order to keep the image size small, only
the necessary packages have been installed. Since the Bash session is run with
root privileges, you are free to install your preferred text editor or window
manager.

### Building your own Docker image

If you do not trust the provided Docker image and want to see the exact steps
that went into making it, you can recreate it using the provided `Dockerfile`.
First, go into the directory holding the `Dockerfile` and build a Docker image
with the command:

    docker build --tag abella:icfp2017 .

Then, start a Docker container with:

    docker run --interactive --tty abella:icfp2017

which will again drop you into a Bash shell as described above. If you wish, you
can replace the tag `abella:icfp2017` in both commands with one you prefer.

### Setting up your own environment

If you think that setting up a Docker container in order to evaluate a few
Abella proofs is an overkill, you are free to set up your own environment. The
only thing you need to set up is Abella, preferably version 2.0.3, on which the
proofs were tested. The easiest way of doing this is through OPAM:

    opam install abella.2.0.3

If you wish to run auxiliary Python scripts described below, you also need to
install Python 3, preferably version 3.6.1, which was used to generate the code.


## Evaluation

