FROM registry.access.redhat.com/ubi9/python-39:1-172

COPY requirements.txt ./

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r ./requirements.txt

#OLD
#RUN pip install --upgrade --no-cache-dir jupyterlab

#Port Expose
EXPOSE 8888

CMD [ "jupyter","lab","--ip=0.0.0.0" ]
