FROM pandastrike/arch_plus
MAINTAINER David Harper (david@pandastrike.com)
#===============================================================================
# Mint Example - Dockerfile
#===============================================================================
# This Dockerfile describes a container holding the Node server that is part of
# the Huxley Mint example.

RUN pacman -Syu --noconfirm
RUN pacman-db-upgrade
RUN pacman -S --noconfirm git nodejs

# Install Node dependencies that must be global.
RUN npm install -g coffee-script

# Install the Mint repository.
RUN git clone git://hook.flavor.cluster:2001/repos/mint.git mint

# Install local repository dependencies.
RUN cd mint && npm install
