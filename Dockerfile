FROM registry.access.redhat.com/ubi9/python-39:1-172
#USER root

ENV PYTHON_VERSION=3.9 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    CNB_STACK_ID=com.redhat.stacks.ubi9-python-39 \
    CNB_USER_ID=1001 \
    CNB_GROUP_ID=0 \
    PIP_NO_CACHE_DIR=off

COPY requirements.txt ./
COPY crontab /etc/crontab

#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir -r ./requirements.txt

RUN INSTALL_PKGS="cronie libffi-devel libtool-ltdl \
        enchant krb5-devel" && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    # Remove redhat-logos-httpd (httpd dependency) to keep image size smaller.
    rpm -e --nodeps redhat-logos-httpd && \
    yum -y clean all --enablerepo='*'
    
# OpenShift requires images to run as non-root by default
USER 1001
ENTRYPOINT ["/bin/bash"]
