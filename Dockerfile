FROM python:3.8-slim-buster

ENV VIRTUAL_ENV=/code

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.1.2


WORKDIR /code 

COPY poetry.lock pyproject.toml /code/

RUN python3 -m venv $VIRTUAL_ENV

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip3 install "poetry==$POETRY_VERSION"

RUN poetry install

COPY django_microservice /code

CMD ["python3", "manage.py", "runserver"]