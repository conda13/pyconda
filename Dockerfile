FROM ubuntu:20.04
COPY . /app
WORKDIR /app
RUN apt update -y && apt install software-properties-common -y \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt update && apt install python3.10 -y \
    && apt install python3-pip -y && pip install poetry \
    && poetry install
EXPOSE 8000
ENTRYPOINT [".venv/bin/gunicorn", "main:app", "--bind=0.0.0.0:8000", "-k uvicorn.workers.UvicornWorker", "--timeout=180"]
#ENTRYPOINT ["/bin/bash"]