FROM python:3.9

RUN apt-get update -y
RUN apt-get install -y gnupg2 dos2unix
RUN apt-get install -y python3-pip
RUN pip3 install sett==4.4.2
RUN pip3 --version

RUN mkdir /src
RUN mkdir /pgp
RUN mkdir /ssh

COPY ./entrypoint.sh /src
RUN chmod +x /src/entrypoint.sh
RUN dos2unix /src/entrypoint.sh

COPY ./set_sett_to_legacy_mode.py /src

WORKDIR /src
ENTRYPOINT ["./entrypoint.sh"]
