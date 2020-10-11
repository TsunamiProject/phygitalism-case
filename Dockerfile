FROM python:3.8-slim-buster

ENV VIRTUAL_ENV=/code

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.1.2

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR /code 

COPY poetry.lock pyproject.toml /code/

COPY django_microservice /code

RUN python3 -m venv $VIRTUAL_ENV

RUN pip3 install "poetry==$POETRY_VERSION"

RUN poetry install

RUN python3 manage.py migrate

CMD ["python3", "manage.py", "runserver"]