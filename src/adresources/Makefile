GRADLEW=sed -e 's/\r//' gradlew | sh -s

default: 
	$(GRADLEW) build --quiet
	mv build/libs/*.jar .

.PHONY: install
install: default
	mv *.jar "$(INSTALL_DIR)/"

.PHONY: clean
clean:
	$(GRADLEW) clean --quiet
