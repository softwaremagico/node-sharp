FROM jorgehortelano/node-alpine-edge
LABEL Description="Sharp library compilation and instalation for docker Alpine"

ENV VIPS_VERSION 8.5.5

#Compile Vips and Sharp
RUN apk --no-cache add --virtual .build-dependencies g++ make python libpng-dev libjpeg-turbo-dev giflib-dev librsvg-dev curl tar gtk-doc gobject-introspection expat-dev glib-dev \
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
	&& su node \
	&& npm install sharp --g --production --unsafe-perm \
	&& chown node:node /usr/local/lib/node_modules -R \
	&& apk del .build-dependencies 

#User node is defined in node-alpine-edge
#USER node

# Install Sharp node image processing library
#RUN npm install sharp --g --production
