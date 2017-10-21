# homebrew-mbsystem
##Homebrew tap for MB-System

MB-System is an open source software package for the processing and display of seafloor mapping data, particularly swath mapping sonar data. The MB-System is documented and distributed from:

http://www.mbari.org/products/research-software/mb-system/

The MB-System project is maintaining this separate tap because MB-System is frequently updated and has one dependency, OTPS (tidal prediction software), that is not available through the normal homebrew repositories (`homebrew-core` and `homebrew-science`). 

##Install:

`brew install dwcaress/mbsystem/otps --with-tpxo8`

`brew install dwcaress/mbsystem/mbsystem`

You can also install MB-System directly, but this will install OTPS without a tide model and you need to add your own. Or you can install MB-System `--without-otps` if tide prediction is not needed.

There is a usual way of using `brew tap dwcaress/mbsystem` and then `brew install mbsystem`unfortunately conflicts with `homebrew-science`.

Please read the Caveats carefully!
