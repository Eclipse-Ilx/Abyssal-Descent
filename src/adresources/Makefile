default: 
	./gradlew build --quiet
	mv build/libs/*.jar .

.PHONY: install
install: default
	mv *.jar "$(INSTALL_DIR)/"

.PHONY: clean
clean:
	./gradlew clean --quiet
