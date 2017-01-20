# homebrew-mbsystem
##Homebrew tap for MB-System

MB-System goes through numerous updates. To account for these updates I created this Homebrew tap to avoid constantly bothering the `homebrew-science` guys. Additionally this tap includes a dependency that is not yet present in the Homebrew repo.
That is `OTPS`, a tide prediction program that is used by the MB-System module `mbotps`.


##Install:
`brew install zimonkaizoku/mbsystem/otps --with-tpxo8`

`brew install zimonkaizoku/mbsystem/mbsystem`

You can also install MB-System directly, but this will install OTPS without a tide model and you need to add your own. Or you can install MB-System `--without-otps` if tide preditiction is not needed.

The usual way of using `brew tap zimonkaizoku/mbsystem` and then `brew install mbsystem`unfortunately conflicts with `homebrew-science`.

Please read the Caveats carefully!
