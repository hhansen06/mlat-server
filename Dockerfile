FROM python:3

RUN apt-get update
RUN apt-get install build-essential git python3-pip python3 python3-venv gcc -y
RUN apt-get install python3-uvloop -y

WORKDIR /app

RUN git clone -b master https://github.com/adsbxchange/mlat-server.git /app
RUN rm -rf /opt/mlat-python-venv
RUN python3 -m venv /opt/mlat-python-venv
RUN sh /opt/mlat-python-venv/bin/activate && pip3 install numpy scipy pykalman python-graph-core uvloop ujson Cython && python3 setup.py build_ext --inplace 

#cmd bash
#CmD . /opt/mlat-python-venv/bin/activate && exec python3 /app/mlat-server

CMD [ "sh", "-c", "python3 /app/mlat-server --client-listen 5000 --basestation-listen 5001 --work-dir /app/config" ]


