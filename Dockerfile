FROM python:3.10.13 AS builder

ENV PACKAGES="\
    bash \
    cmake \
    libboost-all-dev \
    build-essential \
    curl \
"

RUN python -m venv /eis_env

ENV PATH="/root/.cargo/bin:/eis_env/bin:$PATH"

ENV CAMELTOOLS_DATA="eis_env/"

RUN apt update && apt install -y $PACKAGES && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y && \
    pip install --upgrade pip && \
    pip install --no-cache-dir eis1600[EIS] && \
    camel_data -i disambig-mle-calima-msa-r13


FROM python:3.10.13-slim

LABEL org.opencontainers.image.authors="Lisa Mischer <mischer.lisa@gmail.com>"
LABEL org.opencontainers.image.vendor="EIS1600 Project"
LABEL org.opencontainers.image.image.version=1.1.1
LABEL org.opencontainers.image.licence="MIT License"
LABEL org.opencontainers.image.title="eis1600-pkg"
LABEL org.opencontainers.image.description="Dockerized version of Pypi package 'eis1600-pkg'"
LABEL org.opencontainers.image.base.name="python:3.10.13-slim"
LABEL org.opencontainers.image.url"https://github.com/EIS1600/docker-eis1600-pkg"
LABEL org.opencontainers.image.source"https://github.com/EIS1600/docker-eis1600-pkg"

LABEL de.uni-hamburg.aai.eis1600.website="https://eis1600.aai.uni-hamburg.de/"
LABEL de.uni-hamburg.aai.eis1600.pypi="https://pypi.org/project/eis1600/"


COPY --from=builder /eis_env /eis_env

ENV PATH="/eis_env/bin:$PATH"
ENV CAMELTOOLS_DATA="/eis_env/"

WORKDIR /EIS1600

VOLUME EIS1600

CMD ["annotate_goldstandard", "-D", "Training_Data/10k_random_bios/"]
