FROM debian:bullseye
RUN apt update \
      && apt install wget nginx gnupg xz-utils gpg bzip2 vim git -y
RUN cd /tmp \
      && wget -q -O - https://github.com/aptly-dev/aptly/releases/download/v1.5.0/aptly_1.5.0_linux_amd64.tar.gz | tar xvzf - \
      && mv aptly_1.5.0_linux_amd64/aptly /usr/bin/aptly \
      && aptly version
COPY ./entrypoint.sh /entrypoint.sh
WORKDIR /data
COPY ./src ./src
COPY ./repo-list ./repo-list
COPY ./html ./html
RUN tar cvfz /data.tar.gz . >> /dev/null
CMD [ "/entrypoint.sh" ]