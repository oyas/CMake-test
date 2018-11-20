#!/bin/bash

#
# user interface for MC sim
#

source_directory="src"
build_directory="build"
run_command_name="run"

function help_text(){
	echo "Usage: run.sh [build] [clean] [-h]"
	echo ""
	echo "options:"
	echo "      build     execute building"
	echo "      clean     remove build directory"
	echo "         -h     show this message"
}

function build(){
	# Make build directory and move there
	mkdir -p $build_directory
	cd $build_directory

	# Run cmake ( '|| exit $?' はエラーがあった場合に終了するコード )
	cmake ../${source_directory} || exit $?

	make || exit $?

	# Return to the original directory
	cd -
}

function run(){
	run_command="./${build_directory}/${run_command_name}"

	if [ ! -x $run_command ]; then
		echo "Cannot find ${run_command}"
		echo "Please build. '$0 build'"
		exit 1
	fi

	$run_command
}

function clean(){
	set -x
	rm -r $build_directory
	# 間違えてsource_directoryで cmake を実行してしまったとき用
	cd $source_directory
	rm -rf CMakeCache.txt cmake_install.cmake CMakeFiles Makefile
	cd -
	set +x
}


# move to this script directory
cd `dirname $0`		# 作業ディレクトリ移動

# parse arguments
if [ $# -ge 1 ]; then
	if [ $1 == "-h" ]; then
		help_text
		exit
	elif [ $1 == "build" ]; then
		build
		exit
	elif [ $1 == "clean" ]; then
		clean
		exit
	else
		echo "See '$0 -h'"
		exit
	fi
fi

# running
run
