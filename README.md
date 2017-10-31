# homebrew-mbsystem
## Homebrew tap for MB-System

MB-System is an open source software package for the processing and display of bathymetry and backscatter imagery data derived from multibeam, interferometry, and sidescan sonars. This software is documented and distributed at:

http://www.mbari.org/products/research-software/mb-system/

The MB-System project is maintaining this separate homebrew tap because this package is frequently updated and has a dependency, OTPS (tidal prediction software), that is not available through the normal homebrew repositories (`homebrew-core` and `homebrew-science`). 

## Install:

`brew update`

`brew tap dwcaress/mbsystem`

`brew install otps --with-tpxo8`

`brew install mbsystem`

You can also install MB-System directly, but this will install OTPS without a tide model and you need to add your own. Or you can install MB-System `--without-otps` if tide prediction is not needed.

## GMT compatibility:

Since new GMT releases might not be backwards compatible with the mbsystem-gmt-modules, one can prevent homebrew from updating gmt within the 'brew upgrade‘ command by pinning it.

`brew pin gmt`

If compatibility allows it, gmt can then be upgraded by unpinning and upgrading it.

`brew unpin gmt`
`brew upgrade gmt`
