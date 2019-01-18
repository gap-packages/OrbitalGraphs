FROM gapsystem/gap-docker-master

MAINTAINER Markus Pfeiffer <markus.pfeiffer@morphism.de>

COPY --chown=1000:1000 . $HOME/OrbitalGraphs

USER root

RUN apt-get update && apt-get install python3-pip -y


RUN rm -rf $HOME/inst/gap-master/pkg/francy && mv $HOME/OrbitalGraphs $HOME/inst/gap-master/pkg \
  && cd $HOME/inst/gap-master/pkg && rm -rf francy* && git clone https://github.com/mcmartins/francy 

# lab extension installation
RUN cd $HOME/inst/gap-master/pkg/francy/js && npm install && npm run build:all \
  && cd $HOME/inst/gap-master/pkg/francy/extensions/jupyter && npm install && npm run build:all && pip3 install -e . && jupyter labextension link \
  && mv $HOME/inst/gap-master/pkg/francy/extensions/jupyter/jupyter_francy/nbextension $HOME/inst/gap-master/pkg/francy/extensions/jupyter/jupyter_francy/jupyter_francy \
  && jupyter nbextension install $HOME/inst/gap-master/pkg/francy/extensions/jupyter/jupyter_francy/jupyter_francy --user \
  && jupyter nbextension enable jupyter_francy/extension --user


USER gap

WORKDIR $HOME/inst/gap-master/pkg/OrbitalGraphs/notebooks

