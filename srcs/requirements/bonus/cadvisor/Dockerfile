FROM debian:bullseye

WORKDIR /usr/local

RUN apt update -y && apt install wget git make gcc -y
RUN wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN git clone https://github.com/google/cadvisor
WORKDIR /usr/local/cadvisor
RUN make build
ENV PATH=$PATH:/usr/local/cadvisor/_output
CMD ["cadvisor"]