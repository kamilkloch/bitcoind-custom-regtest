# Build stage for Bitcoin Core
FROM alpine as bitcoin-core

RUN apk --no-cache add alpine-sdk autoconf automake pkgconfig python3 boost-dev build-base chrpath file \
    gnupg libevent-dev libressl libressl-dev libtool protobuf-dev zeromq-dev sqlite-dev

ENV BITCOIN_VERSION=27.0

RUN wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}.tar.gz
RUN tar -xzf *.tar.gz \
    && cd bitcoin-${BITCOIN_VERSION} \
    && sed -i 's/consensus.nSubsidyHalvingInterval = 150/consensus.nSubsidyHalvingInterval = 210000/g' src/kernel/chainparams.cpp \
    && ./autogen.sh \
    && ./configure LDFLAGS=-L`ls -d /opt/db`/lib/ CPPFLAGS=-I`ls -d /opt/db`/include/ \
    --prefix=/opt/bitcoin \
    --disable-man \
    --disable-tests \
    --disable-bench \
    --disable-ccache \
    --with-gui=no \
    --enable-util-cli \
    --with-sqlite=yes \
    --with-daemon \
    && make -j4 \
    && make install \
    && strip /opt/bitcoin/bin/bitcoin-cli \
    && strip /opt/bitcoin/bin/bitcoind

# Build stage for compiled artifacts
FROM alpine

RUN apk --no-cache add boost bash libevent libzmq libressl jq
ENV PATH=/opt/bitcoin/bin:$PATH
ENV BITCOIN_DATA=/regtest-data

COPY --from=bitcoin-core /opt /opt

ADD *.sh /
ADD bitcoin.conf /.bitcoin/
VOLUME ["$BITCOIN_DATA"]

EXPOSE 19000 19001 28332
WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
