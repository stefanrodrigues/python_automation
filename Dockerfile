FROM registry.access.redhat.com/ubi9/python-39:1-172

COPY requirements.txt ./
COPY crontab /etc/crontab

#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir -r ./requirements.txt

RUN yum install -y cronie && yum clean all

RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN systemctl start crond.service
