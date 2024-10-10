# pull official base image
FROM python:3.11-slim

# set work directory
WORKDIR /src

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# copy requirements file
COPY ./requirements.txt /src/requirements.txt

# install dependencies
RUN set -eux \
    && apt -y update \
    && apt -y upgrade \
    && apt install -y gcc g++ libc-dev libffi-dev musl-dev \
    && pip install --upgrade pip setuptools wheel \
    && pip install --prefer-binary --no-cache-dir --upgrade -r /src/requirements.txt \
    && rm -rf /root/.cache/pip

# copy project
COPY . /src/