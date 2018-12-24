FROM python:3.7.1

# Read argument passed in from docker compose
ARG DJANGO_ENV

# Create application directory
RUN mkdir /app
WORKDIR /app

# Install dependencies
RUN pip install pipenv
COPY ./Pipfile* ./
RUN pipenv install --system

# Setup codebase
ADD ./example ./

# Configure port
EXPOSE 8000

# Add scripts for handling entry
ADD ./build/bootstrap/${DJANGO_ENV}_entrypoint.sh ./entrypoint.sh

# Configure command
CMD bash ./entrypoint.sh
