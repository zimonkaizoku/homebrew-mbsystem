# homebrew-mbsystem
##Homebrew tap for MB-System

MB-System is an open source software package for the processing and display of bathymetry and backscatter imagery data derived from multibeam, interferometry, and sidescan sonars. This software is documented and distributed at:

http://www.mbari.org/products/research-software/mb-system/

The MB-System project is maintaining this separate homebrew tap because this package is frequently updated and has a dependency, OTPS (tidal prediction software), that is not available through the normal homebrew repositories (`homebrew-core` and `homebrew-science`). 

##Install:

`brew install dwcaress/mbsystem/otps --with-tpxo8`

`brew install dwcaress/mbsystem/mbsystem`

You can also install MB-System directly, but this will install OTPS without a tide model and you need to add your own. Or you can install MB-System `--without-otps` if tide prediction is not needed.

Unfortunately, an outdated version of MB-System is referenced by a formula in `homebrew-science`, so running `brew tap dwcaress/mbsystem` followed by `brew install mbsystem` will result in a conflict. Instead, run `brew install dwcaress/mbsystem/mbsystem` as shown above.
