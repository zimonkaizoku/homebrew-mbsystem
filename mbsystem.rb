class Mbsystem < Formula
  desc "MB-System seafloor mapping software"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url "ftp://mbsystemftp@ftp.mbari.org/mbsystem-5.5.2306.tar.gz"
  sha256 "e843717d8fc330c7f8d39ccbc550a4697ca9d8a7b99172555557e092094fa843"

  depends_on :x11
  depends_on "gmt"
  depends_on "gdal"
  depends_on "netcdf"
  depends_on "proj"
  depends_on "fftw"
  depends_on "gv"
  depends_on "openmotif"
  depends_on "dwcaress/mbsystem/otps"

  option "without-check", "Disable build time checks (not recommended)"

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-static",
      "--enable-shared",
      "--with-proj-lib=#{Formula["proj"].opt_lib}",
      "--with-proj-include=#{Formula["proj"].opt_include}",
      "--with-fftw-lib=#{Formula["fftw"].opt_lib}",
      "--with-fftw-include=#{Formula["fftw"].opt_include}",
      "--with-motif-lib=#{Formula["openmotif"].opt_lib}",
      "--with-motif-include=#{Formula["openmotif"].opt_include}"
    ]
    args << "--with-otps-dir=#{Formula["otps"].prefix}" if build.with? "otps"

    ENV['CFLAGS']="-I/opt/X11/include -L/opt/X11/lib"

    system "./configure", *args
    system "make", "check" if build.with? "check"
    system "make", "install"
  end

  def caveats
    <<-EOS.undent

      The GMT_CUSTOM_LIBS needs to be set for all users
      on this computer that want to use mbsystem. Run the
      following command within the home directory:
          gmtset GMT_CUSTOM_LIBS #{HOMEBREW_PREFIX}/lib/mbsystem.so

      Additionally, if not already done within the gmt
      installation, the directories for DCW and GSHHG (borders,
      coast lines, rivers, etc.) need to be set:
          gmtset DIR_DCW #{HOMEBREW_PREFIX}/share/gmt/dcw
          gmtset DIR_GSHHG #{HOMEBREW_PREFIX}/share/gmt/coast

    EOS
  end
end
