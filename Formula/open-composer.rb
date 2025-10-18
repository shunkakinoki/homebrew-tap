class OpenComposer < Formula
  desc "Open Composer CLI - AI-powered development workflow tool"
  homepage "https://github.com/shunkakinoki/open-composer"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.22/open-composer-cli-darwin-arm64.zip"
      sha256 "90137d636cae5ee13c99774b8f4c21ecde530b45b20167a5e6ad365b11d85c06"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.22/open-composer-cli-darwin-x64.zip"
      sha256 "42c8963d84e0fc7496af25b4d0101edf21c99ea4e8bd545b3ef966d67a0ac2a6"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.22/open-composer-cli-linux-aarch64-musl.zip"
      sha256 "871b6ba25ad8c69df6e2c233a3647f557af3eb091c78b9a0cd69b030ea19c9f3"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.22/open-composer-cli-linux-x64.zip"
      sha256 "2cdc8447c33af5ec6f8d23b41b3e05bca03759ef4dd498c82514f6172a66012f"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = case Hardware::CPU.arch.to_s
           when "x86_64" then "x64"
           when "arm64"  then "arm64"
           else Hardware::CPU.arch.to_s
           end

    os_suffix = os == "linux" && arch == "arm64" ? "linux-aarch64-musl" : "#{os}-#{arch}"
    bin_path = "cli-#{os_suffix}/bin/open-composer"

    bin.install bin_path => "open-composer"
    bin.install_symlink bin/"open-composer" => "oc"
    bin.install_symlink bin/"open-composer" => "opencomposer"
  end

  test do
    system "#{bin}/open-composer", "--version"
  end
end
