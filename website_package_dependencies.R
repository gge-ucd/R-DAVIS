### this isn't roadworthy, but it's a start

if(!require(renv)){install.packages('renv');require(renv)}
deps <- renv::dependencies()

while(any(!deps$Package %in% installed.packages()[,'Package'])){
need <- deps$Package[!deps$Package %in% installed.packages()[,'Package']]
install.packages(need)
}




