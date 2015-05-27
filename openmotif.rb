class Openmotif < Formula
  url 'https://downloads.sourceforge.net/project/motif/Motif%202.3.4%20Source%20Code/motif-2.3.4-src.tgz'
  homepage 'http://motif.ics.com/'
  sha256 '637efa09608e0b8f93465dbeb7c92e58ebb14c4bc1b488040eb79a65af3efbe0'

  depends_on 'jpeg'
  depends_on 'libpng'
  depends_on :x11

  depends_on 'pkg-config' => :build
  depends_on :autoconf    => :build
  depends_on :automake    => :build
  depends_on :libtool     => :build

  conflicts_with 'lesstif'

  def patches
    # MacPorts patches
    { p0: ['https://trac.macports.org/export/118594/trunk/dports/x11/openmotif/files/patch-uintptr_t-cast.diff',
     'https://trac.macports.org/export/118594/trunk/dports/x11/openmotif/files/patch-lib-XmP.h.diff',
     'https://trac.macports.org/export/118594/trunk/dports/x11/openmotif/files/patch-autogen.sh.diff',
     'https://trac.macports.org/export/118594/trunk/dports/x11/openmotif/files/patch-automake-1.13.diff',
     'https://trac.macports.org/export/118594/trunk/dports/x11/openmotif/files/patch-configure.ac.diff'
    ]}
  end

  def install
    ENV.deparallelize
    system 'rm -f demos/lib/Exm/String{.h,.c,P.h}'
    system './autogen.sh'
    system './configure',
      '--disable-dependency-tracking',
      "--x-includes=#{MacOS::X11.include}",
      "--x-libraries=#{MacOS::X11.lib}",
      "--prefix=#{prefix}",
      '--enable-xft',
      '--enable-jpeg',
      '--enable-png'
    system 'make install'
  end
end