class Mbsystem < Formula
  homepage "http://www.mbari.org/data/mbsystem/index.html"
  url "ftp://ftp.ldeo.columbia.edu/pub/mbsystem/mbsystem-5.5.2248.tar.gz"
  sha256 "7cf143a61d8c2fa3c76d5209a0acfdcc9f4f4cc5e68914cb208f561b77bf70c8"

  depends_on :x11
  depends_on "gmt"
  depends_on "netcdf"
  depends_on "proj"
  depends_on "fftw"
  depends_on "homebrew/x11/gv"
  depends_on "zimonkaizoku/mbsystem/openmotif"
  depends_on "zimonkaizoku/mbsystem/otps" => :recommended

  option "without-levitus", "Don't install Levitus database (no mblevitus)"
  option "without-check", "Disable build time checks (not recommended)"

  resource "levitus" do
    url "ftp://ftp.ldeo.columbia.edu/pub/MB-System/annual.gz"
    sha256 "0b57ce813259843ca0b141e2a34a001bc5ebb53b24020a891d0715b9282ebeac"
  end

  def install
    if build.with? "levitus"
      resource("levitus").stage do
        mkdir_p "#{share}/mbsystem"
        ln_s "annual", "#{share}/mbsystem/LevitusAnnual82.dat"
      end
    end

    args = [
      "--prefix=#{prefix}",
      "--disable-static",
      "--enable-shared",
      "--with-netcdf-include=#{Formula["gmt"].opt_include}",
      "--with-netcdf-lib=#{Formula["gmt"].opt_lib}",
      "--with-gmt-include=#{Formula["gmt"].opt_include}/gmt",
      "--with-gmt-lib=#{Formula["gmt"].opt_lib}",
      "--with-proj-include=#{Formula["proj"].opt_include}",
      "--with-proj-lib=#{Formula["proj"].opt_lib}",
      "--with-fftw-include=#{Formula["fftw"].opt_include}",
      "--with-fftw-lib=#{Formula["fftw"].opt_lib}",
      "--with-motif-include=#{Formula["openmotif"].opt_include}",
      "--with-motif-lib=#{Formula["openmotif"].opt_lib}"
    ]
    args << "--with-otps-dir=#{Formula["otps"].prefix}" if build.with? "otps"

    system "./configure", *args
    system "make", "check" if build.with? "check"
    system "make", "install"
  end

  def caveats
    <<-EOS.undent

      The GMT_CUSTOM_LIBS needs to be set for all users
      on this computer that want to use mbsystem. Run the
      following command within the home directory:
          gmtset GMT_CUSTOM_LIBS #{HOMEBREW_PREFIX}/lib/libmbgmt.dylib

    EOS
  end
end
