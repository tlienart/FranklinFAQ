@def author = "Thibaut Lienart"
@def prepath = "FranklinFAQ"
@def generate_rss = false
@def mintoclevel = 2
@def maxtoclevel = 3

<!-- supports question 001 -->
@def members_from_csv = eachrow(readdlm("_assets/members.csv", ',', skipstart=1))
