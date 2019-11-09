FROM ubuntu:18.04

RUN apt-get update

RUN apt-get upgrade -y

RUN apt-get install -y sudo curl python3-pip

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

RUN pip3 install deepspeech deepspeech-server

RUN curl -LO https://github.com/mozilla/DeepSpeech/releases/download/v0.5.1/deepspeech-0.5.1-models.tar.gz

RUN mkdir models

RUN tar xvf deepspeech-0.5.1-models.tar.gz -C models --strip-components=1

RUN curl -LO https://github.com/mozilla/DeepSpeech/releases/download/v0.5.1/audio-0.5.1.tar.gz

RUN mkdir audio

RUN tar xvf audio-0.5.1.tar.gz -C audio --strip-components=1

COPY config.json config.json

EXPOSE 8080

CMD ["sh", "-c", "/usr/local/bin/deepspeech-server --config config.json"]
