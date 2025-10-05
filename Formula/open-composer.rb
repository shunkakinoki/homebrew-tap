class OpenComposer < Formula
  desc "Open Composer CLI - AI-powered development workflow tool"
  homepage "https://github.com/shunkakinoki/open-composer"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.17/open-composer-cli-darwin-arm64.zip"
      sha256 "3c46111e083c71e44f8ce6edf276305f99d6b213e87a14d7c2cc4806c49a8834"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.17/open-composer-cli-darwin-x64.zip"
      sha256 "520d6fd7285e20fb92c6028cafbdc6d8f90c20a4ee5a08c6c76b3707ed508d3f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.17/open-composer-cli-linux-aarch64-musl.zip"
      sha256 "1d7e5a58a439c2d97395e1e35b2021afe426d548d33e303decab5bc78782eee9"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.17/open-composer-cli-linux-x64.zip"
      sha256 "51b87434e06464bcd8a3bd0ba9663895a01e09fcb341eb0be93978f990805bc3"
    end
  end

  def install
    # Determine the binary name based on OS and architecture
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arch.to_s

    arch = case arch
           when "x86_64" then "x64"
           when "arm64" then "arm64"
           else arch
           end

    os_suffix = if os == "linux" && arch == "arm64"
                  "linux-aarch64-musl"
                else
                  "#{os}-#{arch}"
                end

    binary_dir = "open-composer-cli-#{os_suffix}"

    bin.install "#{binary_dir}/bin/open-composer"
    bin.install_symlink bin/"open-composer" => "oc"
    bin.install_symlink bin/"open-composer" => "opencomposer"
  end

  test do
    system "#{bin}/open-composer", "--version"
  end
end
