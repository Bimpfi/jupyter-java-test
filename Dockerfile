FROM continuumio/anaconda3:2021.11

RUN apt-get update
RUN apt-get install unzip

ARG NB_USER=java
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY ./notebooks ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR /home/${NB_USER}/

RUN pip install --no-cache-dir notebook

RUN wget https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip
RUN unzip ijava-1.3.0.zip
RUN python install.py --sys-prefix
