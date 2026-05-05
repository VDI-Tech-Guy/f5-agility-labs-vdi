FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    make \
    git \
    curl \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip first
RUN pip install --upgrade pip

# Core Sphinx build requirements
RUN pip install \
    "docutils>=0.18.1,<=0.19" \
    "sphinx>=7.0,<8.0" \
    f5-sphinx-theme \
    gitpython \
    myst-parser \
    sphinx-autobuild \
    sphinx-copybutton \
    sphinxcontrib-mermaid \
    sphinxcontrib-serializinghtml \
    pre-commit

# AWS publishing requirements
RUN pip install \
    awscli \
    boto3

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]