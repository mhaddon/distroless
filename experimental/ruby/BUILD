package(default_visibility = ["//visibility:public"])

load("//base:distro.bzl", "DISTRO_PACKAGES", "DISTRO_SUFFIXES")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("//:checksums.bzl", ARCHITECTURES = "BASE_ARCHITECTURES")
load("//base:base.bzl", "NONROOT")

# distribution-specific deb dependencies
DISTRO_DEBS = {
    "_debian9": [
        "libgdbm3",
        "libncurses5",
        "libruby2.3",
        "libssl1.0.2",
        "libtinfo5",
        "ruby2.3",
    ],
    "_debian10": [
        "libgdbm6",
        "libgdbm-compat4",
        "libncurses6",
        "libruby2.5",
        "libssl1.1",
        "libtinfo6",
        "ruby-xmlrpc",
        "ruby2.5",
    ],
}

DISTRO_VERSION = {
    "_debian9": "2.3",
    "_debian10": "2.5",
}

