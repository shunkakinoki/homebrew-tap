class OpenComposer < Formula
  desc "Open Composer CLI - AI-powered development workflow tool"
  homepage "https://github.com/shunkakinoki/open-composer"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.18/open-composer-cli-darwin-arm64.zip"
      sha256 "965cc5d0f0ed969b25c8d137937264fb50c8eb3d9ecd829c846768ef8e631002"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.18/open-composer-cli-darwin-x64.zip"
      sha256 "e5afeee2b47c16f0e096902000ebf586fbf20d493df0e92f4c36b6d5c9536d64"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.18/open-composer-cli-linux-aarch64-musl.zip"
      sha256 "746f6d1f18c1d0ff9536447294ec62cacfd3bcc62583ce360566036df513371f"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.18/open-composer-cli-linux-x64.zip"
      sha256 "1c30a408d0e1a013af376e92c81c4bf9b3e2c696f4ba1650fbff2e58614f831c"
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
