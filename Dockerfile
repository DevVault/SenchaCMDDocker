FROM openjdk:8-jre-alpine

MAINTAINER Max Vorobyev (gtvolk31@gmail.com)

# Basic system ports and entrypoint
EXPOSE 1841
CMD [ "sencha", "help" ]

# Initializing working directory
ENV WORK_DIR="/code"
RUN mkdir -p "${WORK_DIR}"
VOLUME [ "${WORK_DIR}" ]
WORKDIR "${WORK_DIR}"

# System-wide environments
ENV LANG=C.UTF-8 \
    _JAVA_OPTIONS="-Xms1024m -Xmx2048m"

# Installing base tools and libs
RUN apk update && \
    apk add \
    ruby \
    ruby-dev \
    build-base \
    libffi-dev \
    libstdc++ \
    tzdata \
    ttf-dejavu \
    freetype \
    fontconfig \
    wget \
    curl \
    nodejs \
    npm

# Installing Compass
ENV COMPASS_VERSION=1.0.3
RUN gem install --no-rdoc --no-ri \
                                  listen \
                                  sass \
                                  compass:${COMPASS_VERSION}

# Installing JsDuck
ENV JSDUCK_VERSION=5.3.4
RUN gem install --no-rdoc --no-ri \
                                  jsduck:${JSDUCK_VERSION}

# Cleaning all
RUN gem cleanup && \
    apk del \
            ruby-dev \
            libffi-dev && \
    rm -rf /usr/lib/ruby/gems/*/cache/* \
           /var/cache/apk/* \
           /tmp/* \
           /var/tmp/*

ENV SENCHA_VERSION=7.0.0.40 \
    SENCHA_PATH="/opt/Sencha/Cmd" \
    PATH="${SENCHA_PATH}/${SENCHA_VERSION}/:${PATH}"
RUN curl -o "/cmd.run.zip" "http://cdn.sencha.com/cmd/${SENCHA_VERSION}/no-jre/SenchaCmd-${SENCHA_VERSION}-linux-amd64.sh.zip" && \
    unzip -p "/cmd.run.zip" > "/cmd-install.run" && \
    chmod +x "/cmd-install.run" && \
    /cmd-install.run -q -Dall=true -dir "${SENCHA_PATH}/${SENCHA_VERSION}" && \
    rm "/cmd-install.run" "/cmd.run.zip"

ENV PJS_VERSION=2.1.1 \
    PJS_PATH="/usr/lib/phantomjs"
RUN cd /tmp && \
    curl -Ls "https://github.com/israelroldan/docker-sencha-cmd/raw/phantomjs-${PJS_VERSION}/dockerized-phantomjs-${PJS_VERSION}.tar.gz" | tar xz -C / && \
    ln -s "${PJS_PATH}/bin/phantomjs" "/usr/bin/phantomjs" && \
    rm "${SENCHA_PATH}/${SENCHA_VERSION}/bin/linux-x64/phantomjs/phantomjs" && \
    ln -s "${PJS_PATH}/bin/phantomjs" "${SENCHA_PATH}/${SENCHA_VERSION}/bin/linux-x64/phantomjs/phantomjs" && \
    rm -rf "/tmp/*"
