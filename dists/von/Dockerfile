FROM bcgovimages/von-image:node-1.12-3

ENV LOG_LEVEL ${LOG_LEVEL:-info}
ENV RUST_LOG ${RUST_LOG:-warning}
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

USER root
RUN apt-get update && apt-get install -y tzdata

USER indy
ADD config ./config
ADD server/requirements.txt server/
#RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r server/requirements.txt

ADD --chown=indy:indy indy_config.py /etc/indy/
ADD --chown=indy:indy . $HOME

RUN mkdir -p \
    $HOME/cli-scripts \
    && chmod -R ug+rw $HOME/cli-scripts
