HOME=$(CURDIR)/test/sandbox

build-sandbox:
	mkdir $(CURDIR)/test/sandbox

run-infect: build-sandbox
	./infect.sh example

test-submodules: run-infect
	./test/test_submodules.sh

test-specific: run-infect
	./test/test_specific.sh

test-link: run-infect
	./test/test_link.sh

test-custom: run-infect
	./test/test_custom.sh

test-all: run-infect test-submodules test-specific test-link test-custom

clean:
	rm -rf $(CURDIR)/test/sandbox
	rm -rf $(CURDIR)/example/link/oh-my-zsh
