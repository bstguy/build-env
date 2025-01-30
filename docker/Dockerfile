FROM debian:unstable

############
# apt repo #
############

ENV DEBIAN_PRIORITY=critical
ENV DEBIAN_FRONTEND=noninteractive

RUN truncate --size=0 /etc/apt/sources.list
RUN rm -rf /etc/apt/sources.list.d
RUN mkdir -p /etc/apt/sources.list.d
COPY debian-bookworm.list /etc/apt/sources.list.d/
COPY debian-trixie.list /etc/apt/sources.list.d/
COPY debian-testing.list /etc/apt/sources.list.d/

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    debian-ports-archive-keyring

COPY debian-unstable.list /etc/apt/sources.list.d/

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    aptitude

##################
# basic packages #
##################

RUN apt-get update && apt-get install -y --no-install-recommends \
  file cpio coreutils time \
  sudo bash-completion \
  gettext gettext-base \
  gzip bzip2 xz-utils unzip \
  dos2unix recode

###################
# shell utilities #
###################

RUN apt-get update && apt-get install -y --no-install-recommends \
  fzf

############
# security #
############

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  pinentry-curses \
  gnupg \
  pass pass-otp

###########
# network #
###########

RUN apt-get update && apt-get install -y --no-install-recommends \
  openssh-client \
  curl \
  wget

#################
# documentation #
#################

RUN apt-get update && apt-get install -y --no-install-recommends \
  man-db manpages manpages-dev manpages-posix manpages-posix-dev

#######
# vcs #
#######

RUN apt-get update && apt-get install -y --no-install-recommends \
  git

########
# text #
########

RUN apt-get update && apt-get install -y --no-install-recommends \
  vim-nox \
  ripgrep \
  less \
  jq \
  icdiff

###################
# build/dev tools #
###################

RUN apt-get update && apt-get install -y --no-install-recommends \
  make \
  build-essential \
  cgdb \
  cmake meson ninja-build

#############
# utilities #
#############

RUN apt-get update && apt-get install -y --no-install-recommends \
  bc

###############
# TeX / LaTeX #
###############

ARG WITH_TEX=false

RUN [ "${WITH_TEX}" != true ] || ( \
  apt-get update && apt-get install -y --no-install-recommends \
    texlive \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-bibtex-extra \
    texlive-luatex \
    texlive-pstricks \
    texlive-pictures \
    texlive-science \
    texlive-metapost \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-font-utils \
    texlive-extra-utils \
    texlive-binaries-sse2 \
)

RUN [ "${WITH_TEX}" != true ] || ( \
  apt-get update && apt-get install -y --no-install-recommends \
    biber \
    latexmk \
)

RUN [ "${WITH_TEX}" != true ] || ( \
  apt-get update && apt-get install -y --no-install-recommends \
    dot2tex \
    ps2eps \
    psutils \
    graphviz \
    inkscape \
)

RUN [ "${WITH_TEX}" != true ] || ( \
  apt-get update && apt-get install -y --no-install-recommends \
    hunspell \
    iamerican \
    wamerican \
)

RUN [ "${WITH_TEX}" != true ] || ( \
  apt-get update && apt-get install -y --no-install-recommends \
    texlive-lang-english \
    texlive-lang-european \
)

##########
# python #
##########

RUN apt-get update && apt-get install -y --no-install-recommends \
  python-is-python3 \
  python3-numpy \
  python3-matplotlib \
  python3-pygments

########
# ruby #
########

RUN apt-get update && apt-get install -y --no-install-recommends \
  ruby \
  ruby-rails

#######
# c++ #
#######

RUN apt-get update && apt-get install -y --no-install-recommends \
  clang g++

######
# go #
######

RUN apt-get update && apt-get install -y --no-install-recommends \
  golang-go

########
# java #
########

RUN apt-get update && apt-get install -y --no-install-recommends \
  default-jdk-headless \
  junit4

#######
# lua #
#######

RUN apt-get update && apt-get install -y --no-install-recommends \
  lua5.4

#########################
# javascript/typescript #
#########################

RUN apt-get update && apt-get install -y --no-install-recommends \
  nodejs \
  node-typescript \
  npm yarnpkg \
  jest ts-jest

########
# rust #
########

RUN apt-get update && apt-get install -y --no-install-recommends \
  rustc \
  cargo

######
# c# #
######

RUN apt-get update && apt-get install -y --no-install-recommends \
  mono-devel \
  mono-csharp-shell \
  mono-utils \
  cli-common \
  libnunit-cil-dev \
  nunit-console

#############
# textidote #
#############

# https://github.com/sylvainhalle/textidote/releases
ARG TEXTIDOTE_VERSION=0.8.3

RUN [ "${WITH_TEX}" != true ] || ( \
  curl -sfLo /tmp/textidote.deb \
    "https://github.com/sylvainhalle/textidote/releases/download/v${TEXTIDOTE_VERSION}/textidote_${TEXTIDOTE_VERSION}_all.deb" \
  && dpkg -i /tmp/textidote.deb \
)

#################
# language tool #
#################

# https://github.com/languagetool-org/languagetool/tags
ARG LANGUAGETOOL_VERSION=6.5

RUN [ "${WITH_TEX}" != true ] || ( \
  mkdir -p /tmp/build/languagetool \
  && curl -sfLo /tmp/install-language-tool.sh \
    "https://raw.githubusercontent.com/languagetool-org/languagetool/master/install.sh" \
  && cd /tmp/build/languagetool \
  && bash /tmp/install-language-tool.sh \
  && mv /tmp/build/languagetool/LanguageTool-*-stable /opt/languagetool \
  && echo '#!/bin/bash -e' > /usr/local/bin/languagetool \
  && echo 'java -jar /opt/languagetool/languagetool-commandline.jar "$@"' \
    >> /usr/local/bin/languagetool \
  && chmod +x /usr/local/bin/languagetool \
)

##################
# ruby libraries #
##################

RUN gem install humanize

#########################
# repo metadata cleanup #
#########################

RUN apt-get update && apt-get upgrade -y
RUN apt autoremove --purge -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

#############
# provision #
#############

ARG IMAGE_ENV_ROOT="/srv"
RUN mkdir -p "${IMAGE_ENV_ROOT}"

ARG IMAGE_ETC_DIR="${IMAGE_ENV_ROOT}/etc"
RUN mkdir -p "${IMAGE_ETC_DIR}"

ARG IMAGE_ENV_DIR="${IMAGE_ENV_ROOT}/env"
RUN mkdir -p "${IMAGE_ENV_DIR}"

ARG TMP_PROVISION_DIR="/tmp/.build-env-provision"
RUN mkdir -p "${TMP_PROVISION_DIR}"

COPY import-profile "${IMAGE_ENV_DIR}/import-profile"

########
# user #
########

ARG IMAGE_USER="root"
ARG IMAGE_HOME="/root"
ARG IMAGE_GROUP="${IMAGE_USER}"
ARG IMAGE_GID="0"
ARG IMAGE_UID="0"
ARG IMAGE_SHELL="/bin/bash"

COPY create-user.sh "${TMP_PROVISION_DIR}"
RUN "${TMP_PROVISION_DIR}/create-user.sh"
USER "${IMAGE_USER}"

##############
# entrypoint #
##############

WORKDIR "/src"
ENTRYPOINT ["bash", "-o", "history"]
