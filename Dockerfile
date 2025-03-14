FROM python:3.9


WORKDIR /app


COPY requirements.txt .
COPY app.py .
COPY templates/ templates/


RUN pip install -r requirements.txt


EXPOSE 5000


CMD ["python", "app.py"]
