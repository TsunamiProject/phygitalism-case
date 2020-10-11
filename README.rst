=====================
Phygitalism test case for an python internship
=====================

Docker image: 

build::

   $ sudo docker build -t phygi_task .

run::

   $ sudo docker run --rm -it --network=host phygi_task

api/meta::

   localhost:8000/api/meta/
 
To change the path to the directory overwrite the config file: django_microservice/file_microservice/config.py
