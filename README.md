# homebrew-mbsystem
##Homebrew tap for MB-System

MB-System goes through numerous updates. To account for these updates I created this Homebrew tap to avoid constantly bothering the `homebrew-science` guys. Additionally this tap includes two dependencies that are not yet present in the Homebrew repo (or not updated yet).

One is `OTPS`, a tide prediction program that is used by the MB-System module `mbotps`.
The other is the bug fixed verson 2.3.4 of `openmotif` which I stole from here `https://gist.github.com/steakknife/60a39a32ae84e12238a2` to make it directly accessible for homebrew.


##Install:
`brew install zimonkaizoku/mbsystem/mbsystem`

The usual way of using `brew tap zimonkaizoku/mbsystem` and then `brew install mbsystem`unfortunately conflicts with `homebrew-science`.
