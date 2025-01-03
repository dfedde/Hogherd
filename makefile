all: android-debug

clean-build: clean all
.PHONY: android-debug
android-debug: build/HogHerder.apk

build/HogHerder.apk:
	godot --export-debug "Android" "build/HogHerder.apk"

.PHONY: clean
clean:
	rm -f build/*

