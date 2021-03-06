ifneq ($(AMBERHOME), clean)
  -include $(AMBERHOME)/AmberTools/src/config.h
endif

install:
	$(PYTHON) setup.py install --prefix=$(AMBERHOME) --install-scripts=$(BINDIR)

installalone:
	mkdir -p bin ; \
	$(PYTHON) setup.py install --prefix=$(MSMTHOME) --install-scripts=$(MSMTBINDIR)

installtc:
	python setup.py install

clean:
	/bin/rm -rf build/

uninstall:
	/bin/rm -f $(BINDIR)/MCPB.py $(BINDIR)/OptC4.py $(BINDIR)/PdbSearcher.py ${BINDIR}/espgen.py ${BINDIR}/CartHess2FC.py

uninstallalone:
	/bin/rm -f $(MSMTBINDIR)/MCPB.py $(MSMTBINDIR)/OptC4.py $(MSMTBINDIR)/PdbSearcher.py ${MSMTBINDIR}/espgen.py ${MSMTBINDIR}/CartHess2FC.py

test:
	cp -r $(AMBERHOME)/AmberTools/src/pymsmt/tests/gaussian/ $(AMBERHOME)/AmberTools/test/pymsmt/mcpb/ ; \
     cd $(AMBERHOME)/AmberTools/test/pymsmt/mcpb ; ./Run.pymsmt
	cp -r $(AMBERHOME)/AmberTools/src/pymsmt/tests/gamess/ $(AMBERHOME)/AmberTools/test/pymsmt/mcpb/ ; \
     cd $(AMBERHOME)/AmberTools/test/pymsmt/mcpb ; ./Run.pymsmt

testalone:
	cd $(MSMTHOME)/tests/gaussian ; ./Run.pymsmtalone ;\
    cd $(MSMTHOME)/tests/gamess ; ./Run.pymsmtalone

testtc:
	cd ./tests/gaussian ; ls ; MCPB.py -h ; sh Run.pymsmttc ; ls ; \
    cd ../gamess ; ls ; MCPB.py -h ; sh Run.pymsmttc ; ls

skip:
	@echo ""
	@echo "Skipping installation of pyMSMT."
	@echo ""


