FROM python:3.10-slim-buster

# Inside Container
WORKDIR /backend-flask

# Outside container --> Inside container
COPY requirements.txt  requirements.txt

# Inside Container
RUN pip3 install -r requirements.txt

# Outside container --> Inside container
COPY . .

ENV FLASK_ENV=development
# ENV FRONTEND_URL="*"
# ENV BACKEND_URL="*"

EXPOSE ${PORT}
CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=4567"]
