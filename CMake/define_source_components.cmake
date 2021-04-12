# define source components - CMake "targets" - as separate compilation components

# serial modules

add_executable( GITR src/gitr.cpp )

# extra compile options for CUDA
if( GITR_USE_CUDA )

  set_source_files_properties( src/gitr.cpp PROPERTIES LANGUAGE CUDA )
  set_target_properties( GITR PROPERTIES LINKER_LANGUAGE CUDA )
  set_property(TARGET GITR PROPERTY CUDA_SEPARABLE_COMPILATION ON)
  target_compile_options( GITR PRIVATE --expt-relaxed-constexpr )

endif()

target_include_directories( GITR PUBLIC include )

# CPU targets
set( cpu_targets
     efield_interp
     particle
     utils
     flags
     setup)

set( gpu_targets
     surface_model
     interp2d
     interpRateCoeff
     ionize
     spectroscopy )

if( NOT GITR_USE_CUDA )

  set( cpu_targets ${cpu_targets} ${gpu_targets} )

endif()

foreach( component IN LISTS cpu_targets )

  add_library( ${component} src/${component}.cpp )

  target_include_directories( ${component} PUBLIC include )

endforeach()

# Compile gpu_targets
if( GITR_USE_CUDA )

  foreach( component IN LISTS gpu_targets )

    add_library( ${component} src/${component}.cpp )
    set_source_files_properties( src/${component}.cpp PROPERTIES LANGUAGE CUDA )
    set_target_properties( ${component} PROPERTIES COMPILE_FLAGS "-dc" )
    target_include_directories( ${component} PUBLIC include )
    target_compile_options( ${component} PRIVATE --expt-relaxed-constexpr )

  endforeach()

endif()