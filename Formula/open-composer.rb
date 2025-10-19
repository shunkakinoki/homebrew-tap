class OpenComposer < Formula
  desc "Open Composer CLI - AI-powered development workflow tool"
  homepage "https://github.com/shunkakinoki/open-composer"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.23/open-composer-cli-darwin-arm64.zip"
      sha256 "ca7fab674b2acca296f550a8a2f6f104e52446732d67b1911fdec4d26ffd70e7"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.23/open-composer-cli-darwin-x64.zip"
      sha256 "2f2800c86bea274bd2ccef9439df1061b182a83137a044a27be3119a182b52c7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.23/open-composer-cli-linux-aarch64-musl.zip"
      sha256 "749ba34e9e4beb314d0ca7e6264c0ab6c984551003a85b99c41962780c0f31e6"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.23/open-composer-cli-linux-x64.zip"
      sha256 "2de5e2748e596316b9a987f897c314bb0368a512c8a59f4842d2f25461ffb1f3"
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
