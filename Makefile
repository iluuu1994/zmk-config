BOARD=nice_nano_v2

all: build/left.uf2 build/right.uf2

setup:
	west init -l config || exit
	west update || exit
	west zephyr-export || exit

clean:
	rm -rf build

keymap: config/corne.keymap

build/left.uf2: config/*
	west build -d build/left -s zmk/app -b $(BOARD) -- -DSHIELD=corne_left -DZMK_CONFIG="`pwd`/config" || exit
	cp build/left/zephyr/zmk.uf2 build/left.uf2

build/right.uf2: config/*
	west build -d build/right -s zmk/app -b $(BOARD) -- -DSHIELD=corne_right -DZMK_CONFIG="`pwd`/config" || exit
	cp build/right/zephyr/zmk.uf2 build/right.uf2

flash-left: build/left.uf2
	cp build/left.uf2 /run/media/ilutov/NICENANO/

flash-right: build/right.uf2
	cp build/right.uf2 /run/media/ilutov/NICENANO/

.PHONY: setup clean keymap flash-left flash-right
