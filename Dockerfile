FROM gapsystem/gap-docker-master:francy

MAINTAINER Markus Pfeiffer <markus.pfeiffer@morphism.de>

COPY --chown=1000:1000 . $HOME/OrbitalGraphs

USER root

RUN apt-get update && apt-get install python3-pip -y

RUN rm -rf $HOME/inst/gap-master/pkg/francy && mv $HOME/OrbitalGraphs $HOME/inst/gap-master/pkg \
  && cd $HOME/inst/gap-master/pkg && git clone https://github.com/mcmartins/francy 

USER gap

WORKDIR $HOME/OrbitalGraphs/notebooks

