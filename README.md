# Diesel CLI Docker Image

This repository hosts the Dockerfile used to build the `diesel` CLI.

# Why?

This Dockerfile move the result `diesel` binary to a smaller debian image
s.t. it downloads faster in tester's computer / CI environment.

# Usage

This image is intended to be used against another db container, or as part of
a docker-compose file.

For example, to connect to another postgres container in the network `diesel`
and run migration:

```sh
> docker network create diesel
3287b47e1373c49a9bba8c5c5a4a21c7531493ab6095f5e6f55e9cd90e28d83f
> docker run --name db --rm --network diesel -d postgres
ca1cf4fb669c137fbd75f32a4ea55706e02b690b1f949c9dfee96d9b4ca77f36
> docker run \
    --name diesel-cli \
    --rm \
    --network diesel \
    -v "$(pwd)":"/usr/src" \
    -e DATABASE_URL=postgres://postgres@db/postgres \
    limouren/diesel-cli diesel migration run
Running migration ...
# clean up everything
> docker stop db
db
> docker network rm diesel
diesel
```
