class OpenComposer < Formula
  desc "Open Composer CLI - AI-powered development workflow tool"
  homepage "https://github.com/shunkakinoki/open-composer"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shunkakinoki/open-composer/releases/download/292/merge/open-composer-cli-darwin-arm64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/292/merge/open-composer-cli-darwin-x64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shunkakinoki/open-composer/releases/download/292/merge/open-composer-cli-linux-aarch64-musl.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/292/merge/open-composer-cli-linux-x64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
