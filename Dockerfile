FROM registry.access.redhat.com/ubi9/python-39:1-172

COPY requirements.txt ./
COPY crontab /etc/crontab

#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir -r ./requirements.txt

# Update image
RUN dnf update --disablerepo=* --enablerepo=ubi-9-appstream-rpms --enablerepo=ubi-9-baseos-rpms	 -y && rm -rf /var/cache/yum
RUN dnf install --disablerepo=* --enablerepo=ubi-9-appstream-rpms --enablerepo=ubi-9-baseos-rpms	 cronie -y && rm -rf /var/cache/yum

#RUN dnf update && dnf install cronie

RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
#RUN systemctl start crond.service
