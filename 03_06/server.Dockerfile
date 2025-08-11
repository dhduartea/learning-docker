FROM ubuntu
LABEL maintainer="David Duarte <dhduarte@gmail.com>"

USER root
COPY ./server.bash /

RUN apt-get update && \
    apt-get install -y curl bash && \
    chmod 755 /server.bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER nobody

ENTRYPOINT [ "/server.bash" ]
