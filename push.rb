#!/usr/bin/env ruby

KIND = %w(debug ruby)
USER = %w(root nonroot)
ARCH = %w(amd64 arm64)
DISTRO = %w(debian10 debian11)
PREFIX = "//experimental/ruby"

build_date = Time.now.strftime("%F")

KIND.each do |kind|
  USER.each do |user|
    ARCH.each do |arch|
      DISTRO.each do |distro|
        bazel_target_name = "#{PREFIX}:#{kind}_#{user}_#{arch}_#{distro}"
        bazel_image_name = "bazel/experimental/ruby:#{kind}_#{user}_#{arch}_#{distro}"
        docker_image_tag = "ghcr.io/#{ENV["GITHUB_REPOSITORY_OWNER"]}/distroless/ruby:#{kind == 'ruby' ? '' : kind + "_"}#{user}_#{arch}_#{distro}"

        system "bazel run #{bazel_target_name}"

        system "docker tag #{bazel_image_name} #{docker_image_tag}-#{build_date}"
        system "docker push #{docker_image_tag}-#{build_date}"

        system "docker tag #{bazel_image_name} #{docker_image_tag}-latest"
        system "docker push #{docker_image_tag}-latest"
      end
    end
  end
end
