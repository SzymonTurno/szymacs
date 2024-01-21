REL_DIR = szymacs-rel

all: ${REL_DIR}.zip
${REL_DIR}.zip: ${REL_DIR}
	zip -r $@ ${REL_DIR}

${REL_DIR}:
	mkdir -p $@
	cp init.el $@/
	cp -r misc $@/
	cp README.md $@/
	cp setup.sh $@/
	cp -r themes $@/

clean:
	rm -rf ${REL_DIR}
	rm -f ${REL_DIR}.zip

.PHONY: all, clean
