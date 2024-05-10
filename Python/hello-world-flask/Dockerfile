FROM python:3.12.3
WORKDIR /hello-world-flask
COPY . /hello-world-flask
RUN pip install -r requirements.txt
EXPOSE 8080
CMD python ./main.py