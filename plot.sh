cat << 'EOF' | gnuplot

set terminal pngcairo size 640,360 enhanced font 'DejaVuSansMono,8'

# set xrange [1:60000]
# set yrange [0:100]

set mytics 2
set grid mytics

set offsets 0.1, 0.1, 0.1, 0.1

# set xlabel ""
# set ylabel "accuracy"
# plot \
#     "aaaa" w l ls 8 t 'aaaa'
# plot \
#     "output" w p ls 8 t ''
# plot "< awk -F , '$3 == 1 ' train.csv" using 1:2 w p ls 8 ps 1 t '', \
#      "< awk -F , '$3 == -1' train.csv" using 1:2 w p ls 4 t '',  \
#      "< awk      '$3 == 1'  output"    using 1:2 w p ls 2 t '', \
#      "< awk      '$3 == -1' output"    using 1:2 w p ls 6 t ''
# set datafile separator ","

# plot "< awk      '$3 == 1'  output"                       using 1:2 w p ls 10 pt 1 ps 0.5 lw 1 t '', \
#      "< awk      '$3 == -1' output"                       using 1:2 w p ls 9  pt 1 ps 0.5 lw 1 t '', \
#      "< awk -F , '$3 == 1'  train.csv | sed -e 's/,/ /g'" using 1:2 w p ls 6 ps 1.5 t '', \
#      "< awk -F , '$3 == -1' train.csv | sed -e 's/,/ /g'" using 1:2 w p ls 8 ps 1.5 t ''

# plot "< awk '$3 == 1'  test2"  using 1:2 w p ls 10 pt 1 ps 0.5 lw 1 t '', \
#      "< awk '$3 == -1' test2"  using 1:2 w p ls 9  pt 1 ps 0.5 lw 1 t '', \
#      "< awk '$3 == 1'  output" using 1:2 w p ls 6 ps 1.5 t '', \
#      "< awk '$3 == -1' output" using 1:2 w p ls 8 ps 1.5 t ''

# plot "< awk '$3 == 0' output" using 1:2 w p ls 2  ps 1.5 lw 1 t 'a', \
#      "< awk '$3 == 1' output" using 1:2 w p ls 4  ps 1.5 lw 1 t 'i', \
#      "< awk '$3 == 2' output" using 1:2 w p ls 6  ps 1.5 lw 1 t 'u', \
#      "< awk '$3 == 3' output" using 1:2 w p ls 8  ps 1.5 lw 1 t 'e', \
#      "< awk '$3 == 4' output" using 1:2 w p ls 1  ps 1.5 lw 1 t 'o', \

# plot "< awk '$3 == 0' output" using 1:2 w p ls 2 lc rgb '#8E68A6' ps 1.5 lw 1 t 'yukari', \
#      "< awk '$3 == 1' output" using 1:2 w p ls 4 lc rgb '#F5D800' ps 1.5 lw 1 t 'makimaki', \
#      "< awk '$3 == 2' output" using 1:2 w p ls 6 lc rgb '#E2738A' ps 1.5 lw 1 t 'akane', \

# plot "output"                       using 1:2 w p ls 10 pt 1 ps 0.5 lw 1 t '', \

# plot (x ** 10) * (13 ** 11) / exp(x * 13) / gamma(11) ls 10 t 'gamma', \
#      exp(- (x - 1.0) * (x - 1.0) / (2 * 0.5 * 0.5)) / sqrt(2.0 * pi * 0.5 * 0.5) ls 12 t 'gauss', \
#      "output" using 1:2 w p ls 11 pt 6 ps 1.0 lw 1 t ''

# binv(p,q)=exp(lgamma(p+q)-lgamma(p)-lgamma(q))
# beta(x,p,q)=p<=0||q<=0?1/0:x<0||x>1?0.0:binv(p,q)*x**(p-1.0)*(1.0-x)**(q-1.0)
# set xrange [0:1]
# plot beta(x, 10.2, 5.8) ls 10 t 'beta', \
#      1 ls 12 t 'uniform', \
#      "output" using 1:2 w p ls 11 pt 6 ps 1.0 lw 1 t ''

# plot "output" using 1:2 w p ls 11 pt 6 ps 1.0 lw 1 t ''

# binwidth=0.5
# bin(x,width)=width*floor(x/width)+width/2.0
# plot [-20:20] "output" using (bin($1,binwidth)):1 smooth freq with boxes

# binwidth = 0.1
# set boxwidth binwidth
# sum = 0
#
# s(x)          = ((sum=sum+1), 0)
# bin(x, width) = width*floor(x/width) + binwidth/2.0
#
# plot "output" u ($1):(s($1))
# plot "output" u (bin($1, binwidth)):(1.0/(binwidth*sum)) smooth freq w boxes

# plot s(x), exp(log(s(x)) * 0.1), exp(log(s(x)) * 0.01)

# set xrange [-20:20]
# t(x) = exp (- (x+10) * (x+10) / (2*1)) / sqrt(2*pi*1) / 2 + \
#        exp (- (x-10) * (x-10) / (2*1)) / sqrt(2*pi*1) / 2
# binwidth = 0.4
# filter(x,y)=int(x/y)*y
# sum  = 0
# s(x) = ((sum=sum+1), 0)
# plot "output" u (filter($1,binwidth)):(1.0/(binwidth*900000)) smooth frequency with boxes ls 10 lw 1 t '', \
#      t(x) ls 12 t ''

# plot t(x)    ls 10 t 'T=1',  \
# t(x) ** 0.1  ls 11 t 'T=10', \
# t(x) ** 0.01 ls 12 t 'T=100'

# set xlabel "lag"
# set ylabel "auto-correlation"
# plot "output" using 1 ls 10 t 'remc', \
#      "output2" using 1 ls 12 t 'mh',


EOF
