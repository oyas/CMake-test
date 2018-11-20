cmake_minimum_required(VERSION 3.1)
enable_language(CXX)
set(CMAKE_CXX_STANDARD 14)  # C++14...
set(CMAKE_CXX_STANDARD_REQUIRED ON)  #...is required...
set(CMAKE_CXX_EXTENSIONS OFF)  #...without compiler extensions like gnu++11
find_package(Threads REQUIRED)

## Set our project name
project(project_name)

# get list of all source codes
file(GLOB_RECURSE sources *.cpp *.c)
message("source files are:")
message("${sources}")

# set Wall flag
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wno-long-long -pedantic")

## Define the executable
set(outputName run)
add_executable(${outputName} ${sources})
target_link_libraries(${outputName} Threads::Threads)
