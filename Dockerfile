FROM continuumio/anaconda3
CMD ["bash"]
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl netbase wget && rm -rf /var/lib/apt/lists/*
RUN set -ex; if !command -v gpg > /dev/null; then apt-get update; apt-get install -y --no-install-recommends gnupg dirmngr; rm -rf /var/lib/apt/lists/*; fi
RUN apt-get update && apt-get install -y --no-install-recommends bzr git mercurial openssh-client subversion procps && rm -rf /var/lib/apt/lists/*
RUN set -ex; apt-get update && apt-get install -y --no-install-recommends autoconf automake bzip2 dpkg-dev file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev libdb-dev libevent-dev libffi-dev libgdbm-dev libgeoip-dev libglib2.0-dev libgmp-dev libjpeg-dev libkrb5-dev liblzma-dev libmagickcore-dev libmagickwand-dev libncurses5-dev libncursesw5-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev libyaml-dev make patch unzip xz-utils zlib1g-dev $(if apt-cache show 'default-libmysqlclient-dev' 2>/dev/null | grep -q '^Version:'; then echo 'default-libmysqlclient-dev'; else echo 'libmysqlclient-dev'; fi); rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6
ENV LANG=C.UTF-8
RUN apt-get update && apt-get install -y --no-install-recommends gnupg tk-dev && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libblas-dev liblapack-dev gfortran perl && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace/
COPY ./environment.yml /workspace/
RUN conda env create -f environment.yml
RUN sed -i 's/conda activate base/conda activate easyvision-env/' ~/.bashrc
ENV PATH=/opt/conda/envs/easyvision-env/bin/:$PATH