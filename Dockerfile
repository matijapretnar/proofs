FROM debian:jessie-slim
MAINTAINER Matija Pretnar <matija.pretnar@fmf.uni-lj.si>

# Set up environment variables
ENV GIT_REPOSITORY=https://github.com/matijapretnar/proofs.git
ENV GIT_BRANCH=master
ENV WORKING_DIRECTORY=/proofs

# Install necessary packages
RUN apt-get update \
    && apt-get install -y \
        git \
        m4 \
        opam \
        python3
RUN opam init -y --auto-setup \
    && opam switch 4.02.3 \
    && opam install -y \
        abella.2.0.4

# Pull the source into the working directory
RUN git clone -b ${GIT_BRANCH} ${GIT_REPOSITORY} ${WORKING_DIRECTORY}

# Start the interactive shell
WORKDIR ${WORKING_DIRECTORY}
CMD ["bash", "-l"]
