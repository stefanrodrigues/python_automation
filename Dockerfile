FROM registry.access.redhat.com/ubi9/python-39:1-172

# Install necessary software
RUN yum update && \
    yum -y install cron

COPY requirements.txt ./
COPY crontab /etc/cron.d/crontab

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r ./requirements.txt

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Start the cron service
CMD cron && tail -f /var/log/cron.log
