FROM streamsets/datacollector:latest
MAINTAINER Guido Schmutz <guido.schmutz@trivadis.com>

ARG ADD_LIBS

RUN sed -i -e 's/run sha1sum --status/run sha1sum -s/g'  ${SDC_DIST}/libexec/_stagelibs

RUN chown sdc /opt/streamsets-datacollector-2.1.0.1/libs-common-lib

RUN if [ "$ADD_LIBS" != "" ]; then ${SDC_DIST}/bin/streamsets stagelibs -install=${ADD_LIBS}; fi

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dc", "-exec"]