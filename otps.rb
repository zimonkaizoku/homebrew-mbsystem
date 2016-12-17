class Otps < Formula
  homepage "http://volkov.oce.orst.edu/tides/tpxo8_atlas.html"
  url "ftp://anonymous:anonymous%40homebrew.com@ftp.oce.orst.edu/dist/tides/OTPS2.tar.Z"
  sha256 "c3e15679515e6e358d173eb9b46276c51ceb5bcd80ecb50822030e1d2900c361"

  depends_on :fortran

  option "with-tpxo8", "Install TPXO8-atlas-compact tide model"

  resource "tpxo8" do
    url "ftp://anonymous:anonymous%40homebrew.com@ftp.oce.orst.edu/pub/lana/TPXO8_compact/tpxo8_atlas_compact.tar.Z"
    sha256 "e23378e1eb2555aa3b75cae98cc2fa09d240d5f5b7b5094947264a5c694c446a"
  end

  def install
    system "make", "extract_HC"
    system "make", "predict_tide"
    system "make", "extract_local_model"

    prefix.install Dir["*"]

    if build.with? "tpxo8"
      (prefix/"DATA").install resource("tpxo8")

      link = open("#{prefix}/DATA/Model_atlas", "w")
      link.write <<-EOS.undent
        #{prefix}/DATA/hf.tpxo8_atlas_30
        #{prefix}/DATA/uv.tpxo8_atlas_30
        #{prefix}/DATA/grid_tpxo8atlas_30
      EOS
      link.close
    end
  end

  def caveats
    <<-EOS.undent

      Please install a tide model.
      E.g. use '--with-tpxo8' to install
      the TPXO8-atlas-compact model.
      Each tide model needs to be linked into:
        #{prefix}/DATA/Model_<model_name>

    EOS
  end
end
