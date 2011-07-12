INCLUDE(ExternalProject)

SET(bullet_PREFIX ${PROJECT_BINARY_DIR}/bullet)

SET(bullet_CMAKE_ARGS 
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DINSTALL_LIBS=ON
    -DBUILD_DEMOS=OFF
    -DBUILD_EXTRAS=OFF
    -DBUILD_UNIT_TESTS=OFF
)

IF(CMAKE_COMPILER_IS_GNUCXX)
    # Needs fpic to link in shared lib on Linux with GCC
    LIST(APPEND bullet_CMAKE_ARGS -DCMAKE_CXX_FLAGS=-fPIC)
ENDIF(CMAKE_COMPILER_IS_GNUCXX)

ExternalProject_Add(bullet
    PREFIX ${bullet_PREFIX}
    
    DOWNLOAD_DIR ${POLYCODE_DEPS_DOWNLOAD_DIR}

    URL http://bullet.googlecode.com/files/bullet-2.78.zip
    URL_MD5 99d4070864c9f73521481ba9cda25038

    CMAKE_ARGS ${bullet_CMAKE_ARGS}
)

ExternalProject_Get_Property(bullet install_dir)

# install includes
INSTALL(DIRECTORY ${install_dir}/include/
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Include
    FILES_MATCHING PATTERN "*.h")

# install debug libs
INSTALL(FILES ${install_dir}/lib/BulletDynamics${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Debug
    CONFIGURATIONS Debug
    RENAME BulletDynamics_d${CMAKE_STATIC_LIBRARY_SUFFIX})

INSTALL(FILES ${install_dir}/lib/BulletCollision${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Debug
    CONFIGURATIONS Debug
    RENAME BulletCollision_d${CMAKE_STATIC_LIBRARY_SUFFIX})

INSTALL(FILES ${install_dir}/lib/BulletSoftBody${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Debug
    CONFIGURATIONS Debug
    RENAME BulletSoftBody_d${CMAKE_STATIC_LIBRARY_SUFFIX})

INSTALL(FILES ${install_dir}/lib/LinearMath${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Debug
    CONFIGURATIONS Debug
    RENAME LinearMath_d${CMAKE_STATIC_LIBRARY_SUFFIX})

# install release libs
INSTALL(FILES ${install_dir}/lib/BulletDynamics${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Release
    CONFIGURATIONS Release)

INSTALL(FILES ${install_dir}/lib/BulletCollision${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Release
    CONFIGURATIONS Release)

INSTALL(FILES ${install_dir}/lib/BulletSoftBody${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Release
    CONFIGURATIONS Release)

INSTALL(FILES ${install_dir}/lib/LinearMath${CMAKE_STATIC_LIBRARY_SUFFIX} 
    DESTINATION ${POLYCODE_DEPS_MODULES_PREFIX}/Lib/Release
    CONFIGURATIONS Release)
