cmake_minimum_required (VERSION 3.5)
#第一個Project: helloworld
project (cmake_test)

#使用CLANG
set(USE_CLANG TRUE)
#Android編譯通用設定
include(${CMAKE_CURRENT_SOURCE_DIR}/AndroidCommon.cmake)

#Project設定
#C99 for C;C++14 for C++
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
#Project Build Targets
set(ANDROID_TARGET helloworld)
set(ANDROID_LIB_MYFUNC myfunc)

add_executable(${ANDROID_TARGET} main.cpp)
add_library(${ANDROID_LIB_MYFUNC} SHARED func.c)
#讓myfunc lib使用C99
set_property(TARGET ${ANDROID_LIB_MYFUNC} PROPERTY C_STANDARD 99)

target_link_libraries(${ANDROID_TARGET} PRIVATE ${ANDROID_LIB_MYFUNC})
target_link_libraries(${ANDROID_TARGET} PRIVATE c++ c m dl)

#執行檔依賴動態函式庫
add_dependencies(${ANDROID_TARGET} ${ANDROID_LIB_MYFUNC})
#加入Target專有的Link option
set_target_properties(${ANDROID_TARGET} PROPERTIES LINK_FLAGS "-fPIC -DPIC") 

#[[ Strip Commands
add_custom_command(TARGET ${ANDROID_TARGET}
    POST_BUILD
    COMMAND $ENV{ANDROID_TOOLCHAIN}/aarch64-linux-android-strip --remove-section=.comment --strip-debug --strip-unneeded ${ANDROID_TARGET}
    COMMAND $ENV{ANDROID_TOOLCHAIN}/aarch64-linux-android-strip --remove-section=.comment --strip-debug --strip-unneeded lib${ANDROID_LIB_MYFUNC}.so
)
#]]

#[[
add_custom_command(OUTPUT dummy.cpp
  COMMAND echo "//HelloDummy" >  dummy.cpp
  COMMENT "Generate dummy.cpp from IDL"
)
add_executable(${ANDROID_TARGET} main.cpp dummy.cpp)

add_custom_command(TARGET ${ANDROID_LIB_MYFUNC}
    POST_BUILD
    COMMAND adb root
    COMMAND adb wait-for-device 
    COMMAND adb remount
    COMMAND adb wait-for-device
    COMMAND adb push libmyfunc.so /system/lib64
    COMMENT  "This is a test"
)

add_custom_command(TARGET ${ANDROID_TARGET}
    POST_BUILD
    COMMAND adb root
    COMMAND adb wait-for-device 
    COMMAND adb remount
    COMMAND adb wait-for-device
    COMMAND adb push helloworld /system/bin
    COMMAND adb shell helloworld
    #COMMAND rm ${CMAKE_BINARY_DIR}
    COMMENT  "This is a test"
)
#]]