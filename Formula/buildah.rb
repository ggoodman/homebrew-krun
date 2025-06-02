class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://buildah.io"
  url "https://github.com/containers/buildah/archive/refs/tags/v1.28.0.tar.gz"
  sha256 "4e406a0cc6a90066cd471deea252fe8862dbd7fa9cb72b274617673d6159a32b"
  license "Apache-2.0"

  bottle do
    root_url "https://raw.githubusercontent.com/ggoodman/homebrew-krun/master/bottles"
    sha256 cellar: :any, arm64_ventura: "62df65e2b7a98f59dd3e683c18992c35144ea780947cb0fc164165329972d878"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "gpgme"

  def install
    system "make", "bin/buildah", "docs"
    bin.install "bin/buildah" => "buildah"
    mkdir_p etc/"containers"
    etc.install "docs/samples/registries.conf" => "containers/registries.conf"
    etc.install "tests/policy.json" => "containers/policy.json"
    man1.install Dir["docs/*.1"]
  end

  test do
    assert_match "buildah version", shell_output("#{bin}/buildah -v")
  end
end
