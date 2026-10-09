class Castcut < Formula
  desc "Record, annotate and cut captioned terminal demos"
  homepage "https://github.com/xianxu/tools"
  url "https://github.com/xianxu/tools/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "a11b928cd3a4851cc4b75166482c710492ef1b38b6fd30a5b1cdff64ba29063d"
  license "Apache-2.0"

  # record runs asciinema (not reimplemented); annotate and cut need nothing.
  depends_on "asciinema"
  depends_on "go" => :build

  def install
    ENV["GOFLAGS"] = "-trimpath -mod=readonly"
    # Stamped from the tag, as define.rb does: the tag and the formula already
    # have to agree, so the version lives nowhere else.
    system "go", "build", "-ldflags", "-X main.version=v#{version}",
           "-o", bin/"castcut", "./cmd/castcut"
  end

  test do
    assert_match "castcut v#{version}", shell_output("#{bin}/castcut --version")

    # A cut needs no network, no browser and no asciinema: two events and one
    # caption must come out with the caption in the header and as a marker.
    (testpath/"take.cast").write <<~CAST
      {"version": 3, "term": {"cols": 20, "rows": 5}}
      [0.5, "o", "hello"]
      [6.0, "o", " world"]
    CAST
    (testpath/"take.captions.txt").write "~0:00.5  Says hello.\n"
    system bin/"castcut", "cut", "take.cast", "-o", "cut.cast"
    out = (testpath/"cut.cast").read
    assert_match '"captions":[{"start":0,"end":4,"text":"Says hello."}]', out
    assert_match '"m", "Says hello."', out
  end
end
