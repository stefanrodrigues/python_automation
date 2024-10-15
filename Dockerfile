FROM registry.access.redhat.com/ubi9/python-39:1-172
USER root

COPY requirements.txt ./
COPY crontab /etc/crontab

#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir -r ./requirements.txt

#RUN rm /etc/rhsm-host && \
#    yum repolist --disablerepo=* && \
#    subscription-manager repos --enable ubi-9-baseos-rpms && \
#    yum -y update && \
#    yum -y install cronie && \
#    # Remove entitlements and Subscription Manager configs
#    rm -rf /etc/pki/entitlement && \
#    rm -rf /etc/rhsm
    
RUN ls -la /etc/pki/entitlement
RUN rm /etc/rhsm-host
RUN yum repolist --disablerepo=*
RUN subscription-manager repos --enable rhocp-4.9-for-rhel-8-x86_64-rpms
RUN yum -y update
RUN yum install -y openshift-clients.x86_64
    
# OpenShift requires images to run as non-root by default
USER 1001
ENTRYPOINT ["/bin/bash"]
