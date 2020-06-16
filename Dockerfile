FROM debian:9

# set the locales
RUN apt-get update && apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# install all essential build tools
RUN apt-get update && apt-get install -y \
    python3 \
    git \
    gcc \
    chrpath \
    cpio \
    diffstat \
    g++ \
    gawk \
    make \
    wget

# create 'build' user (as bitbake does not like building as `root`)
RUN id build 2>/dev/null || useradd --uid 30000 --create-home build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER build

COPY . /poky
