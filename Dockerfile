FROM jorgehortelano/node-alpine-edge

LABEL Description="Sharp instalation for node"
      
# Install packages from testing repo's
RUN apk add --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing vips-tools \
    && apk --no-cache add g++ python make gcc
    && rm -rf /var/cache/apk/*
      
RUN npm install sharp --g 
   
RUN apk del make gcc g++ python
