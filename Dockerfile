FROM continuumio/anaconda3:2021.11
RUN pip install --no-cache-dir notebook

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