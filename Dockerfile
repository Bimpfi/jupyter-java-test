FROM continuumio/anaconda3:2021.11

RUN apt-get update
RUN apt-get install -y unzip texlive texlive-latex-extra texlive-xetex pandoc

RUN wget https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip
RUN unzip ijava-1.3.0.zip
RUN python install.py --sys-prefix

RUN wget https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz
RUN tar -xvzf openjdk-17.0.1_linux-x64_bin.tar.gz -C /usr/
ENV JAVA_HOME=/usr/jdk-17.0.1/bin/
ENV PATH=${JAVA_HOME}:${PATH}

RUN chmod 755 -R /usr/jdk-17.0.1/

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
# RUN chown -R ${NB_UID} ${HOME}
RUN chmod 644 -R ${HOME}
USER ${NB_USER}

WORKDIR /home/${NB_USER}/

# RUN pip install --no-cache-dir notebook
