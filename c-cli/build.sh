#! /usr/bin/env bash

APP_NAME=c-cli

function run() {
  ./build/$APP_NAME
}

function build() {

if [[ $1 = "clean" ]]; then 
rm -fr ./build # clean build
fi


function make_build_dir() {
	if type "ninja" > /dev/null 2>&1; then
		printf '\033[32m%s\033[m\n' 'Use ninja'
		cmake -B ./build -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -GNinja
	else
		printf '\033[32m%s\033[m\n' 'Use make'
		cmake -B ./build -DCMAKE_EXPORT_COMPILE_COMMANDS=1
	fi
	
	if [ -L ./compile_commands.json ]; then
		ln -s ./build/compile_commands.json . # for clangd
	fi
}

if [ ! -d ./build ]; then
	make_build_dir
fi

cmake --build build
}


if [[  $1 = "build"  ]]; then
  build
elif [[  $1 = "run"  ]]; then
  build
  run
else
  # fallback
  build
  run
fi 
