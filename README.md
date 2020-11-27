# Unifi Controller

## Build Image

```console 
docker build -t seanking/unifi-controller .
```

## Run Container
```console
docker run --rm -p 6789:6789 -p 8443:8443 -p 8080:8080 -p 8880:8880 -p 8843:8843 -p3478:3478/udp -v "$(pwd)"/data:/usr/lib/unifi/data seanking/unifi-controller
```

## Export Image

```console
docker save -o unifi-controller.tar seanking/unifi-controller 
```