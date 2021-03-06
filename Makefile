DOCS := site/autosecret/REFERENCE.md site/ud/REFERENCE.md

all : docs lint

docs : $(DOCS)

$(DOCS) : %/REFERENCE.md :
	cd $* && puppet strings generate --format markdown --out $(notdir $@)

lint :
	puppet lint .

.PHONY : $(DOCS)
