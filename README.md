# SeriesAcceleration
Investigation of series acceleration thechniques

# Organisation
- since this is our first project, the outline of our team organisation has to be established.
- Code could be either put in code subdirectory or placed into a separat git repo, which would then be links.
- All write-ups will be placed into the docs directory (code documentation is contained within code). Some consensus for the organisation should be reached.
- The website code containes pulls to the docs subdirectory of projects in order to build a blog from all articles.
- Contributions to any part of the project should be possible at any time by any member. TODO: A suitable workflow for code and text review has to be established.

Overview (german, TODO: translate)
# Topics
- Ein erstes Beispiel mit Plots in dem gezeigt wird, dass verschiedene Reihen verschieden schnell konvergieren. Dabei koennen wir schon eine Sammlung an Reihen fuer Benchmarks bauen, auf die wir dann verschiedene Algorithmen loslassen. Manche divergierenden Reihen (Konvergenzradius 0) "konvergieren" mit nur 1-2 Termen auch ziemlich schnell zu super Werten, aber mit mehr Termen werden sie dann schlechter. Beispiel: Stirling Reihe fuer die Fakultaet
- Shanks Transformation. Shanks Trafo kann man relativ allgemein ueber Pade Aproximanten definieren,
- Richardson Transformation
- Conformal Mappings
- Der Julian meinte, dass er sich auch selbst eine ausgedacht hat, die bisschen besser als Richardson ist
- Ich hab vor viel mit divergierenden Reihen und Borel-Transformationen und Resurgence zu machen, da mein PhD damit zu tun hat. Ich hab von der Numerik allerdings wenig Plan.

# Resourses
- [Bender-Orszag book](https://www.springer.com/us/book/9780387989310)
- [Bender Lectures](https://www.youtube.com/watch?v=LYNOGk3ZjFM) (hab vergessen in welcher Vorlesung er Shanks etc dranbringt)
- [Wikipedia: Series Acceleration](https://en.wikipedia.org/wiki/Series_acceleration)
- [GNU: Series Acceleration](https://www.gnu.org/software/gsl/doc/html/sum.html)
- [Digital Library of Mathematical Functions](https://dlmf.nist.gov/3.9)
- [Overview overtransformation technqiques](https://www.cis.twcu.ac.jp/~osada/thesis_osada.pdf)
- [Overview paper, specializing on algorithms and Levin transformation](https://arxiv.org/pdf/math/0306302.pdf)
