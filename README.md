# What is Segemehl?

segemehl is a software to map short sequencer reads to reference genomes.

# How to use this image

## running segemehl instance

```console
$ docker run --name some-segemehl-pipeline -v $PWD/data/segemehl:/var/lib/segemehl/data
```

Write your script and put it in the directory 

```console
docker-entrypoint-script.d
```