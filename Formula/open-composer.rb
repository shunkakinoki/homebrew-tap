class OpenComposer < Formula
  desc "Open Composer CLI - AI-powered development workflow tool"
  homepage "https://github.com/shunkakinoki/open-composer"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.19/open-composer-cli-darwin-arm64.zip"
      sha256 "f8aa3aa4e02e32a0d5add9b72e4d8784225ad6863b9edc823c781693af1b5676"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.19/open-composer-cli-darwin-x64.zip"
      sha256 "a4a149f852f2ca1215e634d36864a24bbb707e530f008de5963e08c8752fcf2f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.19/open-composer-cli-linux-aarch64-musl.zip"
      sha256 "79b33a2ff2d09c9bc5e44e3ff2542bdf304bbe7958d06c34b56b4c6c7afa9f7f"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.19/open-composer-cli-linux-x64.zip"
      sha256 "c2f04b76e5afd42146a273f0ab4cc8d19128c965a27476483602a432de8d4a2f"
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

    binary_dir = "@open-composer/cli-#{os_suffix}"

    bin.install "#{binary_dir}/bin/open-composer"
    bin.install_symlink bin/"open-composer" => "oc"
    bin.install_symlink bin/"open-composer" => "opencomposer"
  end

  test do
    system "#{bin}/open-composer", "--version"
  end
end
