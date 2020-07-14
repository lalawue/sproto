.PHONY : all clean

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
CC=gcc
CFLAGS=-O2 -shared -fPIC
else ifeq ($(UNAME_S), FreeBSD)
CC=cc
CFLAGS=-O2 -shared -fPIC
else ifeq ($(UNAME_S), Darwin)
CC=clang
CFLAGS=-bundle -undefined dynamic_lookup
else
CC=gcc
CFLAGS=-O2 -Wall --shared
endif


all: sproto.so
	make sproto.so "DLLFLAGS = $(CFLAGS)"

sproto.so : sproto.c lsproto.c
	${CC} -O2 -Wall $(CFLAGS) -o $@ $^ -I$(LUA_JIT_INCLUDE_PATH) 

clean :
	rm -f sproto.so
