FROM ubuntu:14.04
MAINTAINER Ridwan Shariffdeen <ridwan@comp.nus.edu.sg>
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  --no-install-recommends --force-yes \
    gcc \
    oracle-java8-installer \
    python \
    python-dev \
    python-pip \
    scala


# building apache spark
RUN wget https://www-us.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
RUN mv spark-2.4.0-bin-hadoop2.7.tgz /opt/spark-2.4.0-bin-hadoop2.7.tgz
RUN cd /opt; tar xvf spark-2.4.0-bin-hadoop2.7.tgz; mv /opt/spark-2.4.0-bin-hadoop2.7 /opt/spark
ENV PATH=$PATH:/opt/spark/bin

# install python modules
RUN pip2 install \
    numpy

# clean up
RUN DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*