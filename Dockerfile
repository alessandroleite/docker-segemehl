# vim:set ft=dockerfile:

FROM ubuntu:14.04

ENV SEGEMEHL_VERSION="0_2_0" \
    SEGEMEHL_HOME="/opt/segemehl"
ENV SEGEMEHL_URL="http://www.bioinf.uni-leipzig.de/Software/segemehl/segemehl_${SEGEMEHL_VERSION}.tar.gz" \
    PATH="$SEGEMEHL_HOME:$PATH" \
    SEGEMEHL_DATA="/var/lib/segemehl/data" \
    DATA_D="/var/lib/data" \
    ENTRYPOINT_D="/docker-entrypoint-script.d"

ENV ENTRYPOINT_D_CONTAINER ${ENTRYPOINT_D}
COPY docker-entrypoint.sh /

RUN apt-get update -yqq &&  \
    apt-get install -yq     \
            build-essential \
            curl            \
            libncurses5-dev \
            zlib1g-dev &&   \
    curl -s ${SEGEMEHL_URL} | tar xzvf - &&     \
    cd segemehl_${SEGEMEHL_VERSION}/segemehl && \
    make --quiet && \
    mv /segemehl_${SEGEMEHL_VERSION}/segemehl/ /opt/ && \
    rm -rf /segemehl_${SEGEMEHL_VERSION} && \
    apt-get purge -y --auto-remove curl &&  \
    apt-get clean -yq && \
    mkdir ${ENTRYPOINT_D} && \
    chmod +x /docker-entrypoint.sh

VOLUME ["${SEGEMEHL_DATA}", "${DATA_D}"]
ENTRYPOINT ["/docker-entrypoint.sh"]
