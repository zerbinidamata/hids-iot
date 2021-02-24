FROM alpine:3.7

WORKDIR /usr/src/app
COPY . .

RUN apk add python3 py-pip
RUN apk add --no-cache bash
RUN pip3 install -r requirements.txt

CMD ["/entry.sh"]


