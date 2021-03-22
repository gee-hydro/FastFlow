# CC=g++

# #Compilation flags. Feel free to add optimization options here
# CFLAGS=-I$(IDIR) --std=c++11 -m64 -fpermissive -O3 -I /usr/include/gdal -g

# ODIR=build
# IDIR =src

# LIBS=-lm -lgdal 

# _DEPS = Node.h DEM.h utils.h FlowDirection.h FlowAccu.h
# DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

# _OBJ = AccuMethodBTI.o AccuMethodJiang.o AccuMethodRecursive.o AccuMethodWang.o AccuMethodZhou.o dem.o FastFlow.o FlowAccu.o FlowDirection.o utils.o

# OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))


# $(ODIR)/%.o: $(IDIR)/%.cpp $(DEPS)
# 	$(CC) -c -o $@ $< $(CFLAGS)

# FastFlow: $(OBJ)
# 	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

# .PHONY: clean

install:
	sudo cp bin/* /usr/bin

# clean:
# 	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~

