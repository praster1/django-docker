# docker hub에 존재하는 ubuntu 16.04 버전의 이미지를 base로 사용
FROM ubuntu:latest

 
# 우부투 기본 세팅
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install apt-utils
RUN apt-get install -y software-properties-common -y
RUN add-apt-repository -y ppa:deadsnakes/ppa

# 파이썬 3.11 설치
RUN apt-get update
RUN apt install -y python3.11
RUN apt install -y python3-pip
RUN apt install -y python3.11-dev libpq-dev

# 파이썬 default version 3.10 -> 3.11 설정
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
RUN update-alternatives --config python3

# net-tools, dnsutils 설치
RUN apt-get install -y net-tools
RUN apt-get install -y dnsutils
RUN apt-get update
 
ENV PYTHONUNBUFFERED 1
WORKDIR /web
COPY . .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt