FROM python:3.8.2-alpine as builder

#1
RUN apk update && apk add --no-cache make curl autoconf automake libtool gcc musl-dev jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev
RUN curl -o awscli.tar.gz https://awscli.amazonaws.com/awscli.tar.gz
RUN tar -xzf awscli.tar.gz

#2
WORKDIR /awscli-2.13.37
RUN ./configure --with-download-deps

#3
RUN make

#4
RUN make install


FROM python:3.8.2-alpine

COPY --from=builder /usr/local/lib/aws-cli /usr/local/lib/aws-cli
ENV PATH="/usr/local/lib/aws-cli/bin:$PATH"
VOLUME "/root/.aws/"

CMD ["sleep", "infinity"]
