class Mbsystem < Formula
  homepage "http://www.mbari.org/data/mbsystem/index.html"
  url "ftp://ftp.ldeo.columbia.edu/pub/mbsystem/mbsystem-5.5.2263.tar.gz"
  sha256 "299fb75bdb4d346ccefbce99be87ee1510fea0d31fe8958eb220fab4004e8d26"

  depends_on :x11
  depends_on "gmt"
  depends_on "gdal"
  depends_on "netcdf"
  depends_on "proj"
  depends_on "fftw"
  depends_on "homebrew/x11/gv"
  depends_on "lesstif"
  #depends_on "zimonkaizoku/mbsystem/openmotif"
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
      "--with-netcdf-lib=#{Formula["netcdf"].opt_lib}",
      "--with-netcdf-include=#{Formula["netcdf"].opt_include}",
      "--with-gdal-lib=#{Formula["gdal"].opt_lib}",
      "--with-gdal-include=#{Formula["gdal"].opt_include}",
      "--with-gmt-lib=#{Formula["gmt"].opt_lib}",
      "--with-gmt-include=#{Formula["gmt"].opt_include}/gmt",
      "--with-proj-lib=#{Formula["proj"].opt_lib}",
      "--with-proj-include=#{Formula["proj"].opt_include}",
      "--with-fftw-lib=#{Formula["fftw"].opt_lib}",
      "--with-fftw-include=#{Formula["fftw"].opt_include}",
      "--with-motif-lib=#{Formula["lesstif"].opt_lib}",
      "--with-motif-include=#{Formula["lesstif"].opt_include}"
      #"--with-motif-lib=#{Formula["openmotif"].opt_lib}",
      #"--with-motif-include=#{Formula["openmotif"].opt_include}"

      # Ignore this, it's for later:
      #"--with-netcdf-config=#{Formula["netcdf"].opt_lib}/pkgconfig/netcdf.pc"
      #"--with-gdal-config=#{Formula["gdal"].opt_include}/cpl_config.h"
      #"--with-gmt-config=#{Formula["gmt"].opt_include}/gmt/config.h"

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
          gmtset GMT_CUSTOM_LIBS #{HOMEBREW_PREFIX}/lib/libmbgmt.dylib

      Additionally, if not already done within the gmt
      installation, the directories for DCW and GSHHG (borders,
      coast lines, rivers, etc.) need to be set:
          gmtset DIR_DCW #{HOMEBREW_PREFIX}/share/gmt/dcw
          gmtset DIR_GSHHG #{HOMEBREW_PREFIX}/share/gmt/coast

    EOS
  end
end
