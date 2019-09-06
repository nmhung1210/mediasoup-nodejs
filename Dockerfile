FROM node:12-alpine

ENV NPM_CONFIG_PREFIX=/root/.npm-global
ENV NODE_LIB=${NPM_CONFIG_PREFIX}/lib
ENV NODE_PATH=${NODE_LIB}/node_modules

# Install mediasoup globally to avoid compile time.
RUN apk add --no-cache --virtual .build-deps \
  build-base \
  python \
  py-pip \
  gcc \
  clang \
  linux-headers \
  openssl-dev \
  musl-dev \
  libffi-dev \
  && mkdir -p ${NODE_LIB} \
  && npm config set prefix ${NPM_CONFIG_PREFIX} \
  && cd ${NODE_LIB} && npm i mediasoup \
  && apk del .build-deps \
  && rm -rf /root/.npm-global/lib/node_modules/mediasoup/worker/out/Release/obj.target

  ENTRYPOINT [ "node" ]