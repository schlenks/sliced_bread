FROM python:3
ENV PYTHONUNBUFFERED=1
WORKDIR /data
EXPOSE 8000

# Install shards
COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . /data
