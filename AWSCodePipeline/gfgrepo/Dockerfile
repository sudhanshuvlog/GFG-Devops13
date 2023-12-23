FROM amazonlinux:latest
RUN yum install python3 python3-pip -y
WORKDIR /app
COPY . /app
RUN pip3 install -r requirements.txt
EXPOSE 80
CMD ["/usr/bin/python3", "app.py"]
