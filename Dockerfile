ARG PERL_VERSION=5.36.0
FROM perl:$PERL_VERSION-slim

RUN set -x \
    && DEBIAN_FRONTEND=noninteractive apt-get update -qq -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends \
       ca-certificates \
       curl \
       g++ \
       gcc \
       libatomic1 \
       libc6 \
       libc6-dev \
       libdbd-mysql \
       libdbd-mysql-perl \
       libdbd-pg-perl \
       libdbd-pgsql \
       libdbi-perl \
       libjemalloc2 \
       liblua5.1-0 \
       liblzf1 \
       libssl-dev \
       libsystemd0 \
       libversion-perl \
       lua-bitop \
       lua-cjson \
       redis-tools \
    && DEBIAN_FRONTEND=noninteractive apt-get clean -qq -y

RUN set -x \
    && mkdir -p /usr/local/bin \
    && curl -fsSL --output /usr/local/bin/cpm "https://raw.githubusercontent.com/skaji/cpm/main/cpm" \
    && chmod 755 /usr/local/bin/cpm \
    && cpm --version

RUN set -x \
    && cpm install --global --verbose --show-build-log-on-failure \
       "Bundle::Camelcade" \
       "B::Hooks::Parser"

RUN useradd -d /app -m -U -s /usr/sbin/nologin -u 1001 app
USER app
WORKDIR /app
