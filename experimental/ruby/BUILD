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

[
    container_image(
        name = ("ruby" if (not mode) else mode[1:]) + "_root_" + arch + distro_suffix,
        architecture = arch,
        # Based on //cc so that C extensions work properly.
        base = "//cc" + (mode if mode else ":cc") + "_root_" + arch + distro_suffix,
        debs = [
            DISTRO_PACKAGES[arch][distro_suffix]["libgmp10"],
            DISTRO_PACKAGES[arch][distro_suffix]["libreadline7"],
            DISTRO_PACKAGES[arch][distro_suffix]["libyaml-0-2"],
            DISTRO_PACKAGES[arch][distro_suffix]["rake"],
            DISTRO_PACKAGES[arch][distro_suffix]["ruby"],
            DISTRO_PACKAGES[arch][distro_suffix]["rubygems-integration"],
            DISTRO_PACKAGES[arch][distro_suffix]["ruby-did-you-mean"],
            DISTRO_PACKAGES[arch][distro_suffix]["ruby-minitest"],
            DISTRO_PACKAGES[arch][distro_suffix]["ruby-net-telnet"],
            DISTRO_PACKAGES[arch][distro_suffix]["ruby-power-assert"],
            DISTRO_PACKAGES[arch][distro_suffix]["ruby-test-unit"],
            DISTRO_PACKAGES[arch][distro_suffix]["zlib1g"],
        ] + [DISTRO_PACKAGES[arch][distro_suffix][deb] for deb in DISTRO_DEBS[distro_suffix]],
        entrypoint = [
            "/usr/bin/ruby"
        ],
        # Use UTF-8 encoding for file system: match modern Linux
        env = {"LANG": "C.UTF-8"},
    )
    for mode in [
        "",
        ":debug",
    ]
    for arch in ARCHITECTURES
    for distro_suffix in DISTRO_SUFFIXES
]

[
    container_image(
        name = ("ruby" if (not mode) else mode[1:]) + "_nonroot_" + arch + distro_suffix,
        architecture = arch,
        base = ("ruby" if (not mode) else mode[1:]) + "_root_" + arch + distro_suffix,
        user = "%d" % NONROOT,
        workdir = "/home/nonroot",
    )
    for mode in [
        "",
        ":debug",
    ]
    for arch in ARCHITECTURES
    for distro_suffix in DISTRO_SUFFIXES
]
