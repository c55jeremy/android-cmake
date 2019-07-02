cmake_minimum_required (VERSION 3.5)
#第一個Project: helloworld
project (helloworld)

#Android編譯通用設定
include(${CMAKE_CURRENT_SOURCE_DIR}/AndroidCommon.cmake)

#Project設定
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_BINARY_DIR "/home/jeremychen/android-workspace/helloworld/")
#add_executable(helloworld main.cpp func.c)
SET(CMAKE_SKIP_BUILD_RPATH TRUE) #解決DT_RPATH unused的警告，這是由linker發出
add_executable(helloworld main.cpp)
add_library(myfunc SHARED func.c)
target_link_libraries(helloworld PRIVATE myfunc)
target_link_libraries(helloworld PRIVATE c++ c m dl)
