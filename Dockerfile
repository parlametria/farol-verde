FROM python:3.7

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
RUN apt-get update \
    && apt-get -y install libpq-dev gcc
ENV PATH /root/.local/bin:$PATH
COPY landing /landing
WORKDIR landing
RUN poetry install