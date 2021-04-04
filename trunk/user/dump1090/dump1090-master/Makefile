CFLAGS += $(shell PKG_CONFIG_PATH=$(STAGEDIR)/lib/pkgconfig/ pkg-config --cflags librtlsdr)
LDLIBS += $(shell PKG_CONFIG_PATH=$(STAGEDIR)/lib/pkgconfig/ pkg-config --libs librtlsdr) -lpthread -lm

PROGNAME=dump1090

all: dump1090

%.o: %.c
	$(CC) $(CFLAGS) -c $<

dump1090: dump1090.o anet.o
	$(CC) -g -o dump1090 dump1090.o anet.o $(LDFLAGS) $(LDLIBS)

clean:
	rm -f *.o dump1090
