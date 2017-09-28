# Pimcore Docker Image

Installs a nginx server with PHP7 and all needed Pimcore requirements. 

Build the image:

```
$ docker build -t dvonrohr-docker .
```

Run the image:

```
$ docker run -it -v /local/path:/var/www/html -p8080:80 dvonrohr-docker
```
