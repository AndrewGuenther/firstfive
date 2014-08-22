HOME=$(CURDIR)/test/sandbox

build-sandbox:
	mkdir $(CURDIR)/test/sandbox

test-infect: build-sandbox
	./infect.sh https://github.com/AndrewGuenther/firstfive-example.git

test-submodules: test-infect
	./test/test_submodules.sh

test-specific: test-infect
	./test/test_specific.sh

test-link: test-infect
	./test/test_link.sh

test-custom: test-infect
	./test/test_custom.sh

test-all: test-infect test-submodules test-specific test-link test-custom

clean:
	rm -rf $(CURDIR)/test/sandbox
	rm -rf $(CURDIR)/firstfive
