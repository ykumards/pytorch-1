def define_targets(rules):
    rules.cc_library(
        name = "cuda",
        srcs = rules.glob(
            [
                "*.cpp",
                "impl/*.cpp",
            ],
            exclude = [
                "test/**/*.cpp",
            ],
        ),
        hdrs = rules.glob(
            [
                "*.h",
                "impl/*.h",
            ],
            exclude = [
                "CUDAMacros.h",
            ],
        ),
        # This library uses registration. Don't let registered
        # entities be removed.
        alwayslink = True,
        linkstatic = True,
        local_defines = ["C10_BUILD_MAIN_LIB"],
        visibility = ["//visibility:public"],
        deps = [
            ":Macros",
            "@cuda",
            "//c10/core:base",
            "//c10/macros",
            "//c10/util:base",
        ],
    )

    rules.cc_library(
        name = "Macros",
        srcs = [":cuda_cmake_macros"],
        hdrs = ["CUDAMacros.h"],
        linkstatic = True,
        local_defines = ["C10_BUILD_MAIN_LIB"],
        visibility = ["//visibility:public"],
    )

    rules.cmake_configure_file(
        name = "cuda_cmake_macros",
        src = "impl/cuda_cmake_macros.h.in",
        out = "impl/cuda_cmake_macros.h",
        definitions = [],
    )

    rules.filegroup(
        name = "headers",
        srcs = rules.glob(
            [
                "*.h",
                "impl/*.h",
            ],
            exclude = [
            ],
        ),
        visibility = ["//c10:__pkg__"],
    )
