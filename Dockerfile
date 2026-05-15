FROM python:3.10-slim

WORKDIR /app

RUN pip install --no-cache-dir poetry

COPY focus_converter_base/pyproject.toml .
COPY focus_converter_base/poetry.lock .

RUN poetry config virtualenvs.create false

COPY focus_converter_base/ .

RUN poetry install --no-interaction --no-ansi

ENTRYPOINT ["focus-converter"]
