# https://pt.quarkus.io/blog/quarkus-devservices-testcontainers-podman/
export DOCKER_HOST=unix:///run/user/${UID}/podman/podman.sock
export TESTCONTAINERS_RYUK_DISABLED=true
