#Android P Codebase (AOSP) 預設編譯
#確保Android Build環境完整!
if ($ENV{ANDROID_BUILD_TOP} STREQUAL "")
  message(FATAL_ERROR "Please make sure Android Build environment is setup!")
else()
  message(STATUS "Android codebase in " $ENV{ANDROID_BUILD_TOP})
endif()

#設定C/C++ Compiler
set(CMAKE_CXX_COMPILER $ENV{ANDROID_TOOLCHAIN}/aarch64-linux-android-g++)
set(CMAKE_C_COMPILER $ENV{ANDROID_TOOLCHAIN}/aarch64-linux-android-gcc)

#設定通用Definitions
add_definitions(
  -DANDROID 
  -D_FORTIFY_SOURCE=2 
  -D__compiler_offsetof=__builtin_offsetof 
  -D_USING_LIBCXX 
  -D_LIBCPP_ENABLE_THREAD_SAFETY_ANNOTATIONS)

#設定通用Compile C/C++ Flags
set(CMAKE_COMMON_FLAGS "-Wall -fmessage-length=0")
set(CMAKE_C_FLAGS "${CMAKE_COMMON_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_COMMON_FLAGS}")

#設定通用Include Path
include_directories(
  $ENV{ANDROID_BUILD_TOP}/external/libcxx/include
  $ENV{ANDROID_BUILD_TOP}/external/libcxxabi/include
  $ENV{ANDROID_BUILD_TOP}/bionic/libc/kernel/uapi/asm-arm64
  $ENV{ANDROID_BUILD_TOP}/bionic/libc/include
  $ENV{ANDROID_BUILD_TOP}/bionic/libc/kernel/uapi
  $ENV{ANDROID_BUILD_TOP}/bionic/libc/kernel/android/uapi
)

#設定連結Flags及函式庫變數
set(ANDROID_LINK_FLAGS64 "-pie -nostdlib -Bdynamic -Wl,--gc-sections -Wl,-z,nocopyreloc -Wl,-dynamic-linker,/system/bin/linker64 -Wl,-rpath-link=$ENV{ANDROID_PRODUCT_OUT}/obj/lib")
set(ANDROID_COMMON_STATIC_LIBS64 "-Wl,--whole-archive -Wl,--no-whole-archive $ENV{ANDROID_PRODUCT_OUT}/obj/STATIC_LIBRARIES/libcompiler_rt-extras_intermediates/libcompiler_rt-extras.a $ENV{ANDROID_PRODUCT_OUT}/obj/STATIC_LIBRARIES//libatomic_intermediates/libatomic.a $ENV{ANDROID_PRODUCT_OUT}/obj/STATIC_LIBRARIES/libgcc_intermediates/libgcc.a")
set(ANDROID_CRTBEDING_DYNAMIC64 "$ENV{ANDROID_PRODUCT_OUT}/obj/lib/crtbegin_dynamic.o")
set(ANDROID_CRTEND_ANDROID64 "$ENV{ANDROID_PRODUCT_OUT}/obj/lib/crtend_android.o")
set(ANDROID_COMMON_SHARED_LIBS64 "-L$ENV{ANDROID_PRODUCT_OUT}/system/lib64 -lc++ -lc -lm -ldl $ENV{ANDROID_PRODUCT_OUT}/system/lib64/ld-android.so")
set(ANDROID_SYSTEM_SHARED_LIBS64 "-Wl,--no-undefined $ENV{ANDROID_PRODUCT_OUT}/obj/lib/libc++.so $ENV{ANDROID_PRODUCT_OUT}/obj/lib/libc.so $ENV{ANDROID_PRODUCT_OUT}/obj/lib/libm.so $ENV{ANDROID_PRODUCT_OUT}/obj/lib/libdl.so $ENV{ANDROID_PRODUCT_OUT}/system/lib64/ld-android.so")
#整合以上變數，產生Linker Flags
set(CMAKE_EXE_LINKER_FLAGS "${ANDROID_LINK_FLAGS64} ${ANDROID_COMMON_STATIC_LIBS64} ${ANDROID_COMMON_SHARED_LIBS64} ${ANDROID_CRTBEDING_DYNAMIC64}")
