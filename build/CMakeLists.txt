cmake_minimum_required (VERSION 2.8)

#------------------------------------------------------------------------------

set (PROJECT netsuite_tree_manager)

# name of the project
project ( ${PROJECT} )

set ( CPACK_PACKAGE_VERSION_MAJOR 8)
set ( CPACK_PACKAGE_VERSION_MINOR 0 )
set ( CPACK_PACKAGE_VERSION_PATCH 13 )

#-------------------------------------------------------------------------------
# install section

install ( DIRECTORY lib DESTINATION ./ PATTERN ".git" EXCLUDE PATTERN "build" EXCLUDE PATTERN "t" EXCLUDE )

#-------------------------------------------------------------------------------
# section for package (RPM)

set ( INSTALL_PREFIX /tmp/netsuite/ )

# CPACK_RPM_<POST/PRE>_<UN>INSTALL_SCRIPT_FILE
set ( CPACK_RPM_PACKAGE_ARCHITECTURE "noarch" )

set ( REQUIRES "libyaml-appconfig-perl")
set ( REQUIRES "${REQUIRES}, libmoose-perl")
set ( REQUIRES "${REQUIRES}, libdbix-class-schema-loader-perl")
set ( REQUIRES "${REQUIRES}, libdbd-mysql-perl")
set ( REQUIRES "${REQUIRES}, libplack-perl")
set ( REQUIRES "${REQUIRES}, libanyevent-perl")
set ( REQUIRES "${REQUIRES}, libhtml-template-perl")
set ( REQUIRES "${REQUIRES}, mysql-server")
set ( REQUIRES "${REQUIRES}, starman")
set ( CPACK_RPM_PACKAGE_REQUIRES "${REQUIRES}" )

set ( CPACK_GENERATOR RPM )
set ( CMAKE_INSTALL_PREFIX ${INSTALL_PREFIX} )
set ( CPACK_SET_DESTDIR ON)
set ( CPACK_PACKAGE_VERSION ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH} )
set ( CPACK_PACKAGE_CONTACT "Artem Piskun <kleto4kin@gmail.com>")
set ( CPACK_PACKAGE_DESCRIPTION_SUMMARY "NetSuite Tree Manager packages" )
set ( CPACK_RPM_PACKAGE_ARCHITECTURE "${CMAKE_SYSTEM_PROCESSOR}" )
set ( CPACK_PACKAGE_NAME ${PROJECT} )
set ( CPACK_PACKAGE_VENDOR "Artem Piskun" )
set ( CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_PROCESSOR} )
set ( PROJECT_VERSION_REVISION 1 )
set ( PROJECT_RELEASE_ID ${PROJECT_VERSION_REVISION} )
set ( CPACK_RPM_PACKAGE_ARCHITECTURE "${CMAKE_SYSTEM_PROCESSOR}" )
execute_process ( COMMAND sed -nr "s/^.+\\s([0-9]+).*/kmm\\1/p" /etc/issue
                  COMMAND tr -d "\n"
                  OUTPUT_VARIABLE CPACK_RPM_PACKAGE_OS_VERSION )
set ( CPACK_RPM_PACKAGE_RELEASE "r${PROJECT_VERSION_REVISION}.${CPACK_RPM_PACKAGE_OS_VERSION}" )
set ( CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_RPM_PACKAGE_RELEASE}.${CMAKE_SYSTEM_PROCESSOR}" )

INCLUDE(CPack)

add_custom_target ( test )
add_custom_command ( TARGET test
                     COMMAND cd ${CMAKE_CURRENT_SOURCE_DIR}/t
                     COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/t/run_unit-tests >> ${CMAKE_CURRENT_SOURCE_DIR}/t/test.results
                     WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
                     COMMENT "Running tests..."
                     VERBATIM
                   )
add_dependencies ( test run_unit-tests )
