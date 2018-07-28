FROM gapsystem/gap-docker-master

MAINTAINER Markus Pfeiffer <markus.pfeiffer@morphism.de>

COPY --chown=1000:1000 . $HOME/OrbitalGraphs

USER root

RUN apt-get update && apt-get install python3-pip -y

USER gap

WORKDIR $HOME/OrbitalGraphs/notebooks

