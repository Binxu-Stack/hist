.SUFFIXES : .o .cpp
# compiler and flags
CC     = g++ -Wno-unused-result
LINK   = $(CC)
CFLAGS = -O3 $(DEBUG)
#
OFLAGS = -O3 $(DEBUG)
INC    = $(FFTINC) $(LPKINC) $(USRINC)
LIB    = $(FFTLIB) $(LPKLIB) $(USRLIB)
#
# fftw 3 library
#FFTINC    = -I/opt/fftw/fftw3/include
#FFTLIB    = -L/opt/fftw/fftw3/lib -lfftw3
#
# Lapack library
#LPKINC = -I/opt/clapack/3.2.1/include
#LPKLIB = -L/opt/clapack/3.2.1/lib -lclapack -lblas -lf2c -lm
#
# Debug flags
#DEBUG = -g
#====================================================================
ROOT   = hist
# executable name
EXE    = $(ROOT)
#====================================================================
# source and rules
SRC = $(wildcard *.cpp)
OBJ = $(SRC:.cpp=.o)

#====================================================================
all:  ${EXE}

${EXE}: $(OBJ)
	$(LINK) $(OFLAGS) $(OBJ) $(LIB) -o $@

clean: 
	rm -f *.o *~ *.mod ${EXE}

tar:
	rm -f ${ROOT}.tar; tar -czvf ${ROOT}.tar.gz *.cpp  *.h Makefile README

.f.o:
	$(FC) $(FFLAGS) $(FREE) $(MPI) ${INC} -c $<
.f90.o:
	$(FC) $(FFLAGS) $(FREE) $(MPI) ${INC} -c $<
.c.o:
	$(CC) $(CFLAGS) -c $<
.cpp.o:
	$(CC) $(CFLAGS) $(INC) -c $<
