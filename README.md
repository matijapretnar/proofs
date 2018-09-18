# A collection of mechanised proofs

This repository collects proofs I have formalised in various proof assistants:

* `eff-safety`:
    Twelf formalisation of proofs that appear in the paper (tag `lmcs-2014`)

    > Andrej Bauer, Matija Pretnar:
    > *An Effect System for Algebraic Effects and Handlers*,
    > Logical Methods in Computer Science, Volume 10, Issue 4, 2014

* `explicit-effect-subtyping`:

    Abella formalisation of proofs that appear in the paper (tag `esop-2018`)

    > Amr Hany Saleh, Georgios Karachalias, Matija Pretnar, Tom Schrijvers:
    > *Explicit Effect Subtyping*,
    > ESOP 2018

* `no-value-restriction-is-needed`:
    Twelf formalisation of proofs that appear in the paper (tag `jfp-2017`)

    > Ohad Kammar, Matija Pretnar:
    > *No value restriction is needed for algebraic effects and handlers*,
    > Journal of Functional Programming, Volume 27, 2017

* `polymorphic-fgcbv`:
    Abella formalisation of safety for polymorphic fine-grain call-by-value
    lambda calculus. Not particular interesting, but a good starting point.

* `user-defined-effects-expressive-power`:
    Abella formalisation of proofs that appear in the paper (tag `icfp-2017`)

    > Yannick Forster, Ohad Kammar, Sam Lindley, Matija Pretnar:
    > *On the Expressive Power of User-Defined Effects:*
    > *Effect Handlers, Monadic Reflection, Delimited Control*,
    > ICFP 2017

    and paper (branch `jfp-2018`)

    > Yannick Forster, Ohad Kammar, Sam Lindley, Matija Pretnar:
    > *On the expressive power of user-defined effects:*
    > *effect handlers, monadic reflection, delimited control*,
    > Submitted to JFP

More details about the proofs can be found in the respective subdirectories.
Note that proofs may change over time if I find a better way of writing them.
If you want the exact version that was used for a given publication, check
out the suitably labelled Git commit.

## Set up

You have three options for setting up your environment.

### Using a provided Docker image

The easiest way is loading a pre-built Docker image, which already contains
everything you need to evaluate the proofs. To use it, you first need to
[install Docker](https://docs.docker.com/engine/installation/).
With Docker in place, download the Docker image with:

    docker pull matijapretnar/proofs

and start an interactive Bash session inside the main directory with:

    docker run --interactive --tty matijapretnar/proofs

In order to keep the image size small, only the necessary packages have been
installed. Since the Bash session is run with root privileges, you are free to
install your preferred text editor or any other package you desire.

If you want to check out an older version that has been tagged with `tag`, use:

    docker pull matijapretnar/proofs:tag
    docker run --interactive --tty matijapretnar/proofs:tag

### Building your own Docker image

If you do not trust the provided Docker image and want to see the exact steps
that went into making it, you can recreate it using the provided `Dockerfile`.
If you have not done so already, you must first
[install Docker](https://docs.docker.com/engine/installation/). Then, go into
the directory that holds the repository and build a Docker image with the
command:

    docker build --tag proofs .

This might take a while, but once it finishes, you can start the Docker
container using the same command as above:

    docker run --interactive --tty proofs

You can replace the tag `proofs` in both commands with one of your choosing.
If you want to access the Docker image for an older version, check out the
appropriate commit before building the image.

### Setting up your own environment

If you think that setting up a Docker container in order to evaluate a few
proofs is an overkill, you are free to set up your own environment. In this
case, you are on your own, but feel free to look into the provided `Dockerfile`
to see what packages are required. The file itself is quite short and you should
be able to figure it out even if you do not know or care what Docker is.
