package(default_visibility = ["//visibility:public"])

load("//base:distro.bzl", "DISTROS")
load("//base:base.bzl", "deb_file")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("//:checksums.bzl", ARCHITECTURES = "BASE_ARCHITECTURES")
load("//base:distro.bzl", "DISTROS")
load("//base:base.bzl", "NONROOT")

# distribution-specific deb dependencies
DISTRO_DEBS = {
    "debian10": [
        "libffi6",
        "libncurses6",
        "libreadline7",
        "libruby2.5",
        "readline-common",
        "ruby-did-you-mean",
        "ruby-molinillo",
        "ruby-net-http-persistent",
        "ruby-thor",
        "ruby2.5",
    ],
    "debian11": [
        "libbsd0",
        "libcrypt1",
        "libedit2",
        "libffi7",
        "libruby2.7",
        "ruby2.7",
    ],
}

DISTRO_VERSION = {
    "debian10": "2.5",
    "debian11": "2.7",
}

[
    container_image(
        name = ("ruby" if (not mode) else mode[1:]) + "_root_" + arch + "_" + distro,
        architecture = arch,
        # Based on //cc so that C extensions work properly.
        base = "//cc" + (mode if mode else ":cc") + "_root_" + arch + "_" + distro,
        debs = [
            deb_file(arch, distro, "bundler"),
            deb_file(arch, distro, "libgdbm-compat4"),
            deb_file(arch, distro, "libgdbm6"),
            deb_file(arch, distro, "libgmp10"),
            deb_file(arch, distro, "libtinfo6"),
            deb_file(arch, distro, "libyaml-0-2"),
            deb_file(arch, distro, "rake"),
            deb_file(arch, distro, "ruby-bundler"),
            deb_file(arch, distro, "ruby-minitest"),
            deb_file(arch, distro, "ruby-net-telnet"),
            deb_file(arch, distro, "ruby-power-assert"),
            deb_file(arch, distro, "ruby-test-unit"),
            deb_file(arch, distro, "ruby-xmlrpc"),
            deb_file(arch, distro, "ruby"),
            deb_file(arch, distro, "rubygems-integration"),
            deb_file(arch, distro, "zlib1g"),
        ] + [deb_file(arch, distro, deb) for deb in DISTRO_DEBS[distro]],
        entrypoint = [
            "/usr/bin/ruby",
        ],
        # Use UTF-8 encoding for file system: match modern Linux
        env = {"LANG": "C.UTF-8"},
    )
    for mode in [
        "",
        ":debug",
    ]
    for arch in ARCHITECTURES
    for distro in DISTROS
]

[
    container_image(
        name = ("ruby" if (not mode) else mode[1:]) + "_nonroot_" + arch + "_" + distro,
        architecture = arch,
        base = ("ruby" if (not mode) else mode[1:]) + "_root_" + arch + "_" + distro,
        user = "%d" % NONROOT,
        workdir = "/home/nonroot",
    )
    for mode in [
        "",
        ":debug",
    ]
    for arch in ARCHITECTURES
    for distro in DISTROS
]
