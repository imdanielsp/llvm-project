add_gen_header(
  cacheline_size
  DEF_FILE
    cacheline_size.h.def
  GEN_HDR
    cacheline_size.h
  PARAMS
    machine_cacheline_size=cacheline_size_${LIBC_TARGET_MACHINE}.h.inc
  DATA_FILES
    cacheline_size_${LIBC_TARGET_MACHINE}.h.inc
)

add_header_library(
  memory_utils
  HDRS utils.h
  DEPENDS cacheline_size
)
