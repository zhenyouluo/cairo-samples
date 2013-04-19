SUBDIRS=draw1 pdf svg cairomm-1 cairomm-2 pango-1

.PHONY : $(SUBDIRS)

all: $(SUBDIRS)
	$(foreach var, $(SUBDIRS), make -C $(var);)

cleanall: $(SUBDIRS)
	$(foreach var, $(SUBDIRS), make -C $(var) clean;)

