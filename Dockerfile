FROM ubuntu:20.04

RUN apt-get update -y
RUN apt-get install -y python3 python3-pip gnupg2
RUN pip install sett

RUN mkdir /src
RUN mkdir /pgp

COPY ./entrypoint.sh /src
RUN chmod +x /src/entrypoint.sh

WORKDIR /src
ENTRYPOINT ["./entrypoint.sh"]
