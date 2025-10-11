class OpenComposer < Formula
  desc "Open Composer CLI - AI-powered development workflow tool"
  homepage "https://github.com/shunkakinoki/open-composer"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.20/open-composer-cli-darwin-arm64.zip"
      sha256 "62124adaaf74395ef20fe1cf55e45fa6ea92342eb0a10b69de6bd74fb3085c38"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.20/open-composer-cli-darwin-x64.zip"
      sha256 "bea114151050dbd585dea031d1b490dc988d335385ee8c34266abbfbd92c54f2"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.20/open-composer-cli-linux-aarch64-musl.zip"
      sha256 "3dd2bbb35b6d44b5e759cf33c7a2eb1e51920dd141b39c2902e23756788e6808"
    elsif Hardware::CPU.intel?
      url "https://github.com/shunkakinoki/open-composer/releases/download/open-composer@0.8.20/open-composer-cli-linux-x64.zip"
      sha256 "fa4c0ce44c25d1f25ec6c38e5ec5b7e618fc6563a8032b9bf7ac29329115b919"
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
