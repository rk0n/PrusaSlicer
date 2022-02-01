set(_wx_git_tag v3.1.4-patched)

set(_wx_toolkit "")
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(_gtk_ver 2)
    if (DEP_WX_GTK3)
        set(_gtk_ver 3)
    endif ()
    set(_wx_toolkit "-DwxBUILD_TOOLKIT=gtk${_gtk_ver}")
endif()

prusaslicer_add_cmake_project(wxWidgets
    # GIT_REPOSITORY "https://github.com/prusa3d/wxWidgets"
    # GIT_TAG tm_cross_compile #${_wx_git_tag}
    URL https://github.com/prusa3d/wxWidgets/archive/refs/heads/v3.1.4-patched.zip
    URL_HASH SHA256=69dec874981d2fc3d90345660c27f3450d8430c483e8446edcc87b6ed18bff8f
    DEPENDS ${LIBCXX_PKG} ${FONTCONFIG_PKG} ${PNG_PKG} ${ZLIB_PKG} ${EXPAT_PKG} dep_TIFF dep_JPEG
    CMAKE_ARGS
        -DwxBUILD_PRECOMP=OFF
        ${_wx_toolkit}
        "-DCMAKE_DEBUG_POSTFIX:STRING="
        -DwxBUILD_DEBUG_LEVEL=0
        -DwxUSE_MEDIACTRL=OFF
        -DwxUSE_DETECT_SM=OFF
        -DwxUSE_UNICODE=ON
        -DwxUSE_OPENGL=ON
        -DwxUSE_LIBPNG=sys
        -DwxUSE_ZLIB=sys
        -DwxUSE_REGEX=builtin
        -DwxUSE_LIBXPM=builtin
        -DwxUSE_LIBJPEG=sys
        -DwxUSE_LIBTIFF=sys
        -DwxUSE_EXPAT=sys
        -DwxUSE_LIBSDL=OFF
        -DwxUSE_XTEST=OFF
        ${MSAN_CMAKE_ARGS}
)

if (MSVC)
    add_debug_dep(dep_wxWidgets)
endif ()