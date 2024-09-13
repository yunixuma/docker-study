FROM debian:bullseye-slim

# Install WordPress dependencies
RUN apt-get update
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-server
