ARG PYTHON_VERSION=3.13
FROM python:${PYTHON_VERSION}-slim

RUN pip install --no-cache-dir pypiserver[passlib] twine

RUN mkdir /packages

EXPOSE 8080

CMD ["pypi-server", "run", "--port", "8080", "--host", "0.0.0.0", "/packages"]
