FROM jorgehortelano/node-alpine-edge
LABEL Description="Sharp library compilation and instalation for docker Alpine"

ENV VIPS_VERSION 8.5.5

#Compile Vips
RUN apk --no-cache add g++ make python libpng-dev libjpeg-turbo-dev giflib-dev librsvg-dev \
	&& apk --no-cache add --virtual .build-dependencies curl tar gtk-doc gobject-introspection expat-dev glib-dev \
        && mkdir -p /usr/src \
        && curl -o vips.tar.gz -SL https://github.com/jcupitt/libvips/releases/download/v8.5.5/vips-${VIPS_VERSION}.tar.gz \
	&& tar -xzf vips.tar.gz -C /usr/src/ \
	&& rm vips.tar.gz \
	&& chown -R nobody.nobody /usr/src/vips-${VIPS_VERSION} \
	&& cd /usr/src/vips-${VIPS_VERSION} \
	&& ./configure \
	&& make \
	&& make install \
	&& cd / \
	&& rm -r /usr/src/vips-${VIPS_VERSION} \
	&& chown node:node /usr/local/lib/node_modules \
	&& apk del curl tar gtk-doc gobject-introspection expat-dev glib-dev \
	&& apk del .build-dependencies 

#User node is defined in node-alpine-edge
USER node

# Install Sharp node image processing library
RUN npm install sharp --g 
