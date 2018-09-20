
all: build/activity01

clean:
	rm -rf build

build:
	mkdir build

build/activity01: build src/*.pony
	ponyc -o build -b activity01 src

run: build/activity01
	./build/activity01

.PHONY: all clean run
