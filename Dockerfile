# Use Python 3.11 Slim Buster as base image
FROM python:3.11.3-slim-buster

# Set the working directory to contain everything at one place
WORKDIR /opt/oracle

# Copy the rest of your app's source code from your host to your image filesystem.
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy function code
COPY oraconnect.py .
COPY sql_string.py .

# Install necessary packages and download Oracle Instant Client
RUN apt-get update && apt-get install -y libaio1 wget unzip \
  && wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
  && unzip instantclient-basiclite-linuxx64.zip \
  && rm -f instantclient-basiclite-linuxx64.zip

# Set up Oracle Instant Client
RUN cd /opt/oracle/instantclient* \
  && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
  && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
  && ldconfig

ENTRYPOINT [ "python", "oraconnect.py" ]