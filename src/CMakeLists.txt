cmake_minimum_required(VERSION 3.1.0)
project(geehydro)

set(CMAKE_BUILD_TYPE "Debug") 
# Debug Release
set (CMAKE_CXX_STANDARD 11)

# set (shape_srcs ReadOutlets.cpp)
set (srcs_comm utils.cpp)
set (srcs_flowdir dem.cpp FlowDirection.cpp ${srcs_comm} )
set (srcs_accu FlowAccu.cpp AccuMethodBTI.cpp AccuMethodJiang.cpp AccuMethodRecursive.cpp AccuMethodWang.cpp AccuMethodZhou.cpp)

set (FASTFlow FastFlow.cpp ${srcs_flowdir} ${srcs_accu})
set (D8_convert d8_convert.cpp ${srcs_flowdir} )

# MPI is required
# find_package(MPI REQUIRED)
# include_directories(${MPI_INCLUDE_PATH})
# set(CMAKE_CXX_FLAG "${CMAKE_CXX_FLAG} ${MPI_COMPILE_FLAGS}")
# set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} ${MPI_LINK_FLAGS}")

# GDAL is required
find_package(GDAL REQUIRED)
include_directories(${GDAL_INCLUDE_DIR})

add_executable (FastFlow ${FASTFlow})
add_executable (d8_convert ${D8_convert})

set (MY_TARGETS FastFlow d8_convert)

foreach( c_target ${MY_TARGETS} )
    target_link_libraries(${c_target} ${MPI_LIBRARIES} ${GDAL_LIBRARY})
    install(TARGETS ${c_target} DESTINATION geehydro)
endforeach( c_target ${MY_TARGETS} )
