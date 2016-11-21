all: main

main:
	$(CXX) main.cpp \
		-std=c++11 -Wall -O3 \
		-mavx \
		-fopenmp
	./a
	sh plot.sh

#   for assembler
# 	g++ main.cpp \
		-S -g -masm=intel \
		-std=c++11 -Wall -O3 \
		-mavx \
		-fopenmp
#	./a.out
