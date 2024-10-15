#FROM registry.access.redhat.com/ubi9/python-39:1-172
FROM ubi9/s2i-base:rhel9.4.0
USER root

COPY requirements.txt ./
COPY crontab /etc/crontab

#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir -r ./requirements.txt

RUN INSTALL_PKGS="python3 python3-devel python3-setuptools python3-pip nss_wrapper \
        httpd httpd-devel mod_ssl mod_auth_gssapi mod_ldap \
        mod_session atlas-devel gcc-gfortran libffi-devel libtool-ltdl \
        enchant krb5-devel" && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    # Remove redhat-logos-httpd (httpd dependency) to keep image size smaller.
    rpm -e --nodeps redhat-logos-httpd && \
    yum -y clean all --enablerepo='*'
    
# OpenShift requires images to run as non-root by default
USER 1001
ENTRYPOINT ["/bin/bash"]
