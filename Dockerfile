# dockerfile for deploying streamlit apps
# https://docs.streamlit.io/knowledge-base/tutorials/deploy/docker
FROM 888374473732.dkr.ecr.us-east-2.amazonaws.com/docker-hub/library/python:3.11-slim-bookworm

WORKDIR /srv

RUN pip install streamlit --no-cache-dir

# Caching Introduced here
COPY requirements.txt /srv/
RUN pip install -r requirements.txt --no-cache-dir

COPY . /srv

ENTRYPOINT ["streamlit", "run", "app.py", \
            "--server.port=80", \
            "--server.headless=true", \
            "--server.address=0.0.0.0", \
            "--browser.gatherUsageStats=false", \
            "--server.enableStaticServing=true", \
            "--server.fileWatcherType=none", \
            # hide the Streamlit menu
            "--client.toolbarMode=viewer"]