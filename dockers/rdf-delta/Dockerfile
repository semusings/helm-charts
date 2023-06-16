ARG JAVA_VERSION=17
#FROM openjdk:${JAVA_VERSION}-alpine
FROM amazoncorretto:${JAVA_VERSION}-alpine3.17-jdk

ARG RDF_DELTA_VERSION=1.1.2
ARG REPO=https://repo1.maven.org/maven2
ARG ZIP_FILE=${REPO}/org/seaborne/rdf-delta/rdf-delta-dist/${RDF_DELTA_VERSION}/rdf-delta-dist-${RDF_DELTA_VERSION}.zip

RUN echo && echo "==== Docker build for RDF Delta ${RDF_DELTA_VERSION} ====" && echo

RUN apk add --no-cache bash curl unzip

RUN curl ${ZIP_FILE} -o /tmp/rdf-delta-dist.zip \
    && unzip /tmp/rdf-delta-dist.zip -d /opt \
    && mv /opt/rdf-delta-* /opt/rdf-delta \
    && rm /tmp/rdf-delta-dist.zip

ENV DELTA_HOME=/opt/rdf-delta
RUN ln -s /opt/rdf-delta/dcmd /usr/local/bin/dcmd

EXPOSE 1066

ENTRYPOINT ["dcmd"]
CMD ["server", "-mem"]