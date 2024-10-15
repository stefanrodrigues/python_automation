FROM registry.access.redhat.com/ubi9/python-39:1-172
USER root

COPY requirements.txt ./
COPY crontab /etc/crontab

#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir -r ./requirements.txt

RUN rm /etc/rhsm-host && \
    yum repolist --disablerepo=* && \
    subscription-manager repos --enable ubi-9-baseos-rpms && \
    yum -y update && \
    yum -y install cronie && \
    # Remove entitlements and Subscription Manager configs
    rm -rf /etc/pki/entitlement && \
    rm -rf /etc/rhsm
# OpenShift requires images to run as non-root by default
USER 1001
ENTRYPOINT ["/bin/bash"]
