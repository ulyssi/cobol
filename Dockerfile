# Pull base image
FROM debian:jessie
RUN apt-get update
RUN apt-get install -y open-cobol
