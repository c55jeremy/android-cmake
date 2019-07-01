cmake_minimum_required (VERSION 3.5)
#第一個Project: helloworld
project (helloworld)

#Android編譯通用設定
include(${CMAKE_CURRENT_SOURCE_DIR}/AndroidCommon.cmake)

#Project設定
#set(CMAKE_REQUIRED_FLAGS --std=c++14)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_BINARY_DIR "/home/jeremychen/android-workspace/helloworld/")
add_executable(helloworld  main.cpp func.c)

