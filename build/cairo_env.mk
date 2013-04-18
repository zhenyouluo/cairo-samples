################################################################################
#	MODULE	:	cairo_env.mk
#	PROJECT	:	Cairo examples
#	AUTHOR	:	Michael Uman
#	DATE	:	April 18, 2013
################################################################################

CAIRO_CFLAGS   = $(shell pkg-config --cflags cairo)
CAIRO_LIBS     = $(shell pkg-config --libs cairo)
CAIRO_VERSION  = $(shell pkg-config --modversion cairo)

