################################################################################
#	MODULE		:	buildsys.mk
#	AUTHOR 		:	Michael A. Uman
#	DATE		:	April 10, 2013
################################################################################

GPP ?= g++			# c++ compiler
GCC ?= gcc			# c compiler
AR  ?= ar			# archive tool
TAR ?= tar			# tar tool

CPP_OBJS=$(CPP_SOURCES:%.cpp=$(OBJ_DIR)/%.o)
C_OBJS=$(C_SOURCES:%.c=$(OBJ_DIR)/%.o)

OBJS=$(CPP_OBJS) $(C_OBJS)

ifdef DEBUG
	EXE_DIR=bin/Debug
	OBJ_DIR=obj/Debug
	CFLAGS+= -D_DEBUG=1 -g3
else
	EXE_DIR=bin/Release
	OBJ_DIR=obj/Release
	CFLAGS+= -DNDEBUG -O2
endif

################################################################################
#	Generate the targets full name
################################################################################
ifeq ($(TARGET_TYPE), exe)
TARGET=$(EXE_DIR)/$(TARGET_EXE)
endif
ifeq ($(TARGET_TYPE), statlib)
TARGET=$(LIBNAME).a
endif

CFLAGS+=$(INCLUDES)
LDFLAGS+=$(EXTERN_LIBS) $(LIBS)


#	Default rules
$(OBJ_DIR)/%.o : %.cpp Makefile
	@echo "Compiling $*.cpp"
	@$(GPP) -c -o $(OBJ_DIR)/$*.o $(CFLAGS) $*.cpp

$(OBJ_DIR)/%.o : %.c Makefile
	@echo "Compiling $*.c"
	@$(GCC) -c -o $(OBJ_DIR)/$*.o $(CFLAGS) $*.cpp
	
################################################################################
#	executable target
################################################################################
ifeq ($(TARGET_TYPE), exe)
$(TARGET): objdir exedir $(OBJS) $(EXTERN_LIBS)
	@echo "Linking $(TARGET)"
	@$(GPP) -o $(TARGET) $(OBJS) $(LDFLAGS)
endif

################################################################################
#	static library target
################################################################################
ifeq ($(TARGET_TYPE), statlib)
$(TARGET): objdir $(OBJS)
	@echo "Generating static library $(TARGET)"
	@$(AR) -r -s $(TARGET) $(OBJS)
endif

clean:
	rm -rf $(OBJS) $(TARGET)

objdir: $(OBJ_DIR)
	@echo "Creating object directory..."
	@mkdir -p $(OBJ_DIR) 

exedir: $(EXE_DIR)
	@echo "Creating exe directory..."
	@mkdir -p $(EXE_DIR)

depends:
	makedepend -Y  $(INCLUDES) -p'$$(OBJ_DIR)/' *.cpp

.PHONY:
	@true
