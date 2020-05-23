############################################################################
# File:     build/bc56/makefile
#
# Purpose:  Makefile for STLSoft 1.10 for Borland C/C++ 5.6
#
############################################################################


############################################################################
# Environment

############################################################################
# Macros

TEST_VERBOSITY		=	2

INCL_STLSOFT_1_10	=	../../include
INCL_STLSOFT		=	$(STLSOFT)/include
INCL_XTESTS			=	$(XTESTS_C_ROOT)/include
LIB_XTESTS			=	$(XTESTS_C_ROOT)/lib

STLSOFT_INCLUDES	=	-I$(INCL_STLSOFT_1_10) -I$(INCL_STLSOFT)

############################################################################
# Externally-specifiable Targets

default:	build

clean:
	@if exist *.obj del /f *.obj

help:
	@echo "make [build | clean | compile | help | test]"

build:	\
 build.unit\
 build.component\
 \

build.all:	\
 build.unit\
 build.component\
 build.performance\
 build.scratch\
\

build.component:	\
 build.component.comstl\
 build.component.platformstl\
 build.component.stlsoft\
 build.component.winstl\
 \

build.unit:	\
 build.unit.comstl\
 build.unit.platformstl\
 build.unit.stlsoft\
 build.unit.winstl\
 \

build.performance:	\
 build.performance.comstl\
 build.performance.platformstl\
 build.performance.stlsoft\
 build.performance.winstl\
 \

build.scratch:	\
 build.scratch.comstl\
 build.scratch.platformstl\
 build.scratch.stlsoft\
 build.scratch.winstl\
 \

build.component.comstl:	check.bin.dir \
 ..\..\bin\test.component.comstl.collections.collection_sequence.bc56.exe\
 \

build.component.platformstl:	check.bin.dir \
 ..\..\bin\test.component.platformstl.filesystem.file_lines.bc56.exe\
 ..\..\bin\test.component.platformstl.filesystem.filesystem_traits.1.bc56.exe\
 ..\..\bin\test.component.platformstl.filesystem.properties_file.bc56.exe\
 ..\..\bin\test.component.platformstl.filesystem.readdir_sequence.bc56.exe\
 ..\..\bin\test.component.platformstl.performance.performance_counter.bc56.exe\
 \

build.component.stlsoft:	check.bin.dir \
 ..\..\bin\test.component.stlsoft.iterator.FILE_iterator.bc56.exe\
 \

build.component.winstl:	check.bin.dir \
 ..\..\bin\test.component.winstl.filesystem.findfile_sequence.bc56.exe\
 ..\..\bin\test.component.winstl.filesystem.hrw_file_lines.bc56.exe\
 ..\..\bin\test.component.winstl.filesystem.memory_map_functions.C.bc56.exe\
 ..\..\bin\test.component.winstl.filesystem.memory_map_functions.bc56.exe\
 ..\..\bin\test.component.winstl.filesystem.memory_mapped_file_view_handle.bc56.exe\
 ..\..\bin\test.component.winstl.filesystem.readonly_memory_mapped_file.bc56.exe\
 ..\..\bin\test.component.winstl.synch.semaphore.bc56.exe\
 ..\..\bin\test.component.winstl.system.console_functions.bc56.exe\
 ..\..\bin\test.component.winstl.system.environment_variable.bc56.exe\
 ..\..\bin\test.component.winstl.system.system_directory.bc56.exe\
 ..\..\bin\test.component.winstl.system.temporary_directory.bc56.exe\
 ..\..\bin\test.component.winstl.system.windows_directory.bc56.exe\
 \

build.performance.comstl:	check.bin.dir \
 \

build.performance.platformstl:	check.bin.dir \
 ..\..\bin\test.component.platformstl.performance.performance_counter.bc56.exe\
 \

build.performance.stlsoft:	check.bin.dir \
 ..\..\bin\test.performance.stlsoft.conversion.truncation_test.bc56.exe\
 \

build.performance.winstl:	check.bin.dir \
 ..\..\bin\test.scratch.winstl.performance.threadtimes_counter.bc56.exe\
 \

build.scratch.comstl:	check.bin.dir \
 ..\..\bin\test.scratch.comstl.conversion.interface_cast.bc56.exe\
 ..\..\bin\test.scratch.comstl.conversion.method_cast.bc56.exe\
 \

build.scratch.platformstl:	check.bin.dir \
 \

build.scratch.stlsoft:	check.bin.dir \
 ..\..\bin\test.scratch.stlsoft.error.error_desc.bc56.exe\
 ..\..\bin\test.scratch.stlsoft.smartptr.scoped_handle.bc56.exe\
 ..\..\bin\test.scratch.stlsoft.util.rand.bc56.exe\
 \

build.scratch.winstl:	check.bin.dir \
 ..\..\bin\test.scratch.winstl.performance.threadtimes_counter.bc56.exe\
 \

build.unit.comstl:	check.bin.dir \
 ..\..\bin\test.unit.comstl.shims.access.string.GUID.bc56.exe\
 ..\..\bin\test.unit.comstl.shims.access.string.VARIANT.bc56.exe\
 ..\..\bin\test.unit.comstl.string.BSTR_functions.C.bc56.exe\
 ..\..\bin\test.unit.comstl.string.BSTR_functions.bc56.exe\
 ..\..\bin\test.unit.comstl.util.GUID_functions.bc56.exe\
 ..\..\bin\test.unit.comstl.util.variant.bc56.exe\
 ..\..\bin\test.unit.comstl.util.VARIANT_functions.bc56.exe\
 \

build.unit.platformstl:	check.bin.dir \
 ..\..\bin\test.unit.platformstl.system.str_set.bc56.exe\
 \

build.unit.stlsoft:	check.bin.dir \
 ..\..\bin\test.unit.stlsoft.algorithm.literal_copy.bc56.exe\
 ..\..\bin\test.unit.stlsoft.algorithm.pod.bc56.exe\
 ..\..\bin\test.unit.stlsoft.collection.edge_case_index_sequence.bc56.exe\
 ..\..\bin\test.unit.stlsoft.container.fixed_arrays.bc56.exe\
 ..\..\bin\test.unit.stlsoft.container.frequency_map.bc56.exe\
 ..\..\bin\test.unit.stlsoft.container.initialised_array.bc56.exe\
 ..\..\bin\test.unit.stlsoft.container.layered_map.bc56.exe\
 ..\..\bin\test.unit.stlsoft.container.partially_initialised_array.bc56.exe\
 ..\..\bin\test.unit.stlsoft.container.pod_vector.bc56.exe\
 ..\..\bin\test.unit.stlsoft.conversion.integer_to_array.bc56.exe\
 ..\..\bin\test.unit.stlsoft.conversion.integer_to_hex_string.bc56.exe\
 ..\..\bin\test.unit.stlsoft.conversion.string_to_integer.bc56.exe\
 ..\..\bin\test.unit.stlsoft.conversion.truncation_test.bc56.exe\
 ..\..\bin\test.unit.stlsoft.conversion.union_cast.bc56.exe\
 ..\..\bin\test.unit.stlsoft.error.error_desc.bc56.exe\
 ..\..\bin\test.unit.stlsoft.exception.exception_string.bc56.exe\
 ..\..\bin\test.unit.stlsoft.filesystem.read_line.bc56.exe\
 ..\..\bin\test.unit.stlsoft.functional.bit_operations.bc56.exe\
 ..\..\bin\test.unit.stlsoft.iterator.associative_eraser_iterator.bc56.exe\
 ..\..\bin\test.unit.stlsoft.iterator.eraser_iterator.bc56.exe\
 ..\..\bin\test.unit.stlsoft.iterator.sorted_eraser_iterator.bc56.exe\
 ..\..\bin\test.unit.stlsoft.iterator.string_concatenator_iterator.bc56.exe\
 ..\..\bin\test.unit.stlsoft.iterator.transform_iterator.bc56.exe\
 ..\..\bin\test.unit.stlsoft.iterator.unsorted_eraser_iterator.bc56.exe\
 ..\..\bin\test.unit.stlsoft.memory.auto_buffer.bc56.exe\
 ..\..\bin\test.unit.stlsoft.meta.is_printf_type.bc56.exe\
 ..\..\bin\test.unit.stlsoft.shims.access.string.std.time.bc56.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.scoped_handle.bc56.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.scoped_method.bc56.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.scoped_ptr.bc56.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.shared_ptr.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.replace_functions.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.shim_string.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.simple_string.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.slice_functions.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.split_functions.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.static_string.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.string_registry.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.string_slice.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.string_tokeniser.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.string_view.bc56.exe\
 ..\..\bin\test.unit.stlsoft.string.tokeniser_functions.bc56.exe\
 ..\..\bin\test.unit.stlsoft.tr1.smartptr.scoped_ptr.bc56.exe\
 ..\..\bin\test.unit.stlsoft.util.bit_functions.bc56.exe\
 ..\..\bin\test.unit.stlsoft.util.exception_string_creator.bc56.exe\
 ..\..\bin\test.unit.stlsoft.util.has_bom.bc56.exe\
 ..\..\bin\test.unit.stlsoft.util.minmax.bc56.exe\
 ..\..\bin\test.unit.stlsoft.util.must_init.bc56.exe\
 ..\..\bin\test.unit.stlsoft.util.rand.bc56.exe\
 ..\..\bin\test.unit.stlsoft.util.string_switch.bc56.exe\
 \

build.unit.winstl:	check.bin.dir \
 ..\..\bin\test.unit.winstl.filesystem.filesystem_traits.1.bc56.exe\
 ..\..\bin\test.unit.winstl.filesystem.filesystem_traits.2.bc56.exe\
 ..\..\bin\test.unit.winstl.filesystem.findvolume_sequence.bc56.exe\
 ..\..\bin\test.unit.winstl.filesystem.memory_mapped_file.bc56.exe\
 ..\..\bin\test.unit.winstl.filesystem.path.bc56.exe\
 ..\..\bin\test.unit.winstl.filesystem.path_functions.bc56.exe\
 ..\..\bin\test.unit.winstl.registry.reg_delete_tree.bc56.exe\
 ..\..\bin\test.unit.winstl.registry.reg_value.bc56.exe\
 ..\..\bin\test.unit.winstl.synch.w4mo.bc56.exe\
 ..\..\bin\test.unit.winstl.system.commandline_parser.bc56.exe\
 ..\..\bin\test.unit.winstl.system.searchpath_sequence.bc56.exe\
 ..\..\bin\test.unit.winstl.system.system_traits.1.bc56.exe\
 ..\..\bin\test.unit.winstl.system.system_traits.2.bc56.exe\
 \


test:	\
 build.unit\
 build.component\
 test.unit\
 test.component\
 \

test.component:	\
 test.component.comstl\
 test.component.platformstl\
 test.component.stlsoft\
 test.component.winstl\
 \

test.unit:	\
 test.unit.comstl\
 test.unit.platformstl\
 test.unit.stlsoft\
 test.unit.winstl\
 \

test.performance:	\
 test.performance.comstl\
 test.performance.platformstl\
 test.performance.stlsoft\
 test.performance.winstl\
 \

test.scratch:	\
 test.scratch.comstl\
 test.scratch.platformstl\
 test.scratch.stlsoft\
 test.scratch.winstl\
 \

test.all:	\
 build.all\
 test.unit\
 test.component\
 test.performance\
 test.scratch\
 \

test.component.comstl:	build.component.comstl
	@echo Running component tests for comstl
	..\..\bin\test.component.comstl.collections.collection_sequence.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.component.platformstl:	build.component.platformstl
	@echo Running component tests for platformstl
	..\..\bin\test.component.platformstl.filesystem.file_lines.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.filesystem.filesystem_traits.1.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.filesystem.properties_file.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.filesystem.readdir_sequence.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.performance.performance_counter.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.component.stlsoft:	build.component.stlsoft
	@echo Running component tests for stlsoft
	..\..\bin\test.component.stlsoft.iterator.FILE_iterator.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.component.winstl:	build.component.winstl
	@echo Running component tests for winstl
	..\..\bin\test.component.winstl.filesystem.findfile_sequence.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.hrw_file_lines.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.memory_map_functions.C.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.memory_map_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.memory_mapped_file_view_handle.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.readonly_memory_mapped_file.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.synch.semaphore.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.console_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.environment_variable.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.system_directory.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.temporary_directory.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.windows_directory.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.performance.comstl:	build.performance.comstl
	@echo Running performance tests for comstl

test.performance.platformstl:	build.performance.platformstl
	@echo Running performance tests for platformstl
	..\..\bin\test.component.platformstl.performance.performance_counter.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.performance.stlsoft:	build.performance.stlsoft
	@echo Running performance tests for stlsoft
	..\..\bin\test.performance.stlsoft.conversion.truncation_test.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.performance.winstl:	build.performance.winstl
	@echo Running performance tests for winstl
	..\..\bin\test.scratch.winstl.performance.threadtimes_counter.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.scratch.comstl:	build.scratch.comstl
	@echo Running scratch tests for comstl
	..\..\bin\test.scratch.comstl.conversion.interface_cast.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.scratch.comstl.conversion.method_cast.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.scratch.platformstl:	build.scratch.platformstl
	@echo Running scratch tests for platformstl

test.scratch.stlsoft:	build.scratch.stlsoft
	@echo Running scratch tests for stlsoft
	..\..\bin\test.scratch.stlsoft.error.error_desc.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.scratch.stlsoft.smartptr.scoped_handle.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.scratch.stlsoft.util.rand.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.scratch.winstl:	build.scratch.winstl
	@echo Running scratch tests for winstl
	..\..\bin\test.scratch.winstl.performance.threadtimes_counter.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.unit.comstl:	build.unit.comstl
	@echo Running unit tests for comstl
	..\..\bin\test.unit.comstl.shims.access.string.GUID.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.shims.access.string.VARIANT.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.string.BSTR_functions.C.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.string.BSTR_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.util.GUID_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.util.variant.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.util.VARIANT_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.unit.platformstl:	build.unit.platformstl
	@echo Running unit tests for platformstl
	..\..\bin\test.unit.platformstl.system.str_set.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.unit.stlsoft:	build.unit.stlsoft
	@echo Running unit tests for stlsoft
	..\..\bin\test.unit.stlsoft.algorithm.literal_copy.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.algorithm.pod.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.collection.edge_case_index_sequence.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.fixed_arrays.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.frequency_map.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.initialised_array.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.layered_map.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.partially_initialised_array.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.pod_vector.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.integer_to_array.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.integer_to_hex_string.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.string_to_integer.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.truncation_test.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.union_cast.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.error.error_desc.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.exception.exception_string.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.filesystem.read_line.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.functional.bit_operations.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.associative_eraser_iterator.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.eraser_iterator.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.sorted_eraser_iterator.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.string_concatenator_iterator.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.transform_iterator.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.unsorted_eraser_iterator.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.memory.auto_buffer.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.meta.is_printf_type.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.shims.access.string.std.time.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.scoped_handle.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.scoped_method.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.scoped_ptr.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.shared_ptr.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.replace_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.shim_string.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.simple_string.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.slice_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.split_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.static_string.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_registry.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_slice.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_tokeniser.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_view.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.tokeniser_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.tr1.smartptr.scoped_ptr.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.bit_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.exception_string_creator.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.has_bom.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.minmax.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.must_init.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.rand.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.string_switch.bc56.exe --verbosity=$(TEST_VERBOSITY)

test.unit.winstl:	build.unit.winstl
	@echo Running unit tests for winstl
	..\..\bin\test.unit.winstl.filesystem.filesystem_traits.1.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.filesystem_traits.2.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.findvolume_sequence.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.memory_mapped_file.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.path.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.path_functions.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.registry.reg_delete_tree.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.registry.reg_value.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.synch.w4mo.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.commandline_parser.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.searchpath_sequence.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.system_traits.1.bc56.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.system_traits.2.bc56.exe --verbosity=$(TEST_VERBOSITY)

 \

############################################################################
# Helper Targets

check.lib.dir:              makefile
	@-if not exist ..\..\lib\NUL mkdir ..\..\lib

check.bin.dir:              makefile
	@-if not exist ..\..\bin\NUL mkdir ..\..\bin



############################################################################
# Internal Targets

########################################
# comstl:

..\..\bin\test.component.comstl.collections.collection_sequence.bc56.exe:	.\test.component.comstl.collections.collection_sequence.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.comstl.collections.collection_sequence.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.component.comstl.collections.collection_sequence.obj:	..\..\test\component\comstl\collections\test.component.comstl.collections.collection_sequence\test.component.comstl.collections.collection_sequence.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\comstl\collections\test.component.comstl.collections.collection_sequence\test.component.comstl.collections.collection_sequence.cpp

..\..\bin\test.scratch.comstl.conversion.interface_cast.bc56.exe:	.\test.scratch.comstl.conversion.interface_cast.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.scratch.comstl.conversion.interface_cast.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.scratch.comstl.conversion.interface_cast.obj:	..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.interface_cast\test.scratch.comstl.conversion.interface_cast.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.interface_cast\test.scratch.comstl.conversion.interface_cast.cpp

..\..\bin\test.scratch.comstl.conversion.method_cast.bc56.exe:	.\test.scratch.comstl.conversion.method_cast.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.scratch.comstl.conversion.method_cast.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.scratch.comstl.conversion.method_cast.obj:	..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.method_cast\test.scratch.comstl.conversion.method_cast.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.method_cast\test.scratch.comstl.conversion.method_cast.cpp

..\..\bin\test.unit.comstl.shims.access.string.GUID.bc56.exe:	.\test.unit.comstl.shims.access.string.GUID.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.comstl.shims.access.string.GUID.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.unit.comstl.shims.access.string.GUID.obj:	..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.guid\test.unit.comstl.shims.access.string.GUID.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.guid\test.unit.comstl.shims.access.string.GUID.cpp

..\..\bin\test.unit.comstl.shims.access.string.VARIANT.bc56.exe:	.\test.unit.comstl.shims.access.string.VARIANT.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.comstl.shims.access.string.VARIANT.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.unit.comstl.shims.access.string.VARIANT.obj:	..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.variant\test.unit.comstl.shims.access.string.VARIANT.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.variant\test.unit.comstl.shims.access.string.VARIANT.cpp

..\..\bin\test.unit.comstl.string.BSTR_functions.C.bc56.exe:	.\test.unit.comstl.string.BSTR_functions.C.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.comstl.string.BSTR_functions.C.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.unit.comstl.string.BSTR_functions.C.obj:	..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions.C\test.unit.comstl.string.BSTR_functions.C.c
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions.C\test.unit.comstl.string.BSTR_functions.C.c

..\..\bin\test.unit.comstl.string.BSTR_functions.bc56.exe:	.\test.unit.comstl.string.BSTR_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.comstl.string.BSTR_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.unit.comstl.string.BSTR_functions.obj:	..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions\test.unit.comstl.string.BSTR_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions\test.unit.comstl.string.BSTR_functions.cpp

..\..\bin\test.unit.comstl.util.GUID_functions.bc56.exe:	.\test.unit.comstl.util.GUID_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.comstl.util.GUID_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.unit.comstl.util.GUID_functions.obj:	..\..\test\unit\comstl\util\test.unit.comstl.util.GUID_functions\test.unit.comstl.util.GUID_functions.c
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\util\test.unit.comstl.util.GUID_functions\test.unit.comstl.util.GUID_functions.c

..\..\bin\test.unit.comstl.util.variant.bc56.exe:	.\test.unit.comstl.util.variant.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.comstl.util.variant.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.unit.comstl.util.variant.obj:	..\..\test\unit\comstl\util\test.unit.comstl.util.variant\test.unit.comstl.util.variant.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\util\test.unit.comstl.util.variant\test.unit.comstl.util.variant.cpp

..\..\bin\test.unit.comstl.util.VARIANT_functions.bc56.exe:	.\test.unit.comstl.util.VARIANT_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.comstl.util.VARIANT_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib uuid.lib
.\test.unit.comstl.util.VARIANT_functions.obj:	..\..\test\unit\comstl\util\test.unit.comstl.util.VARIANT_functions\test.unit.comstl.util.VARIANT_functions.c
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\util\test.unit.comstl.util.VARIANT_functions\test.unit.comstl.util.VARIANT_functions.c


############################################################################
# Internal Targets

########################################
# platformstl:

..\..\bin\test.component.platformstl.filesystem.file_lines.bc56.exe:	.\test.component.platformstl.filesystem.file_lines.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.platformstl.filesystem.file_lines.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.component.platformstl.filesystem.file_lines.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.file_lines\test.component.platformstl.filesystem.file_lines.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.file_lines\test.component.platformstl.filesystem.file_lines.cpp

..\..\bin\test.component.platformstl.filesystem.filesystem_traits.1.bc56.exe:	.\test.component.platformstl.filesystem.filesystem_traits.1.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.platformstl.filesystem.filesystem_traits.1.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.component.platformstl.filesystem.filesystem_traits.1.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.filesystem_traits.1\test.component.platformstl.filesystem.filesystem_traits.1.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.filesystem_traits.1\test.component.platformstl.filesystem.filesystem_traits.1.cpp

..\..\bin\test.component.platformstl.filesystem.properties_file.bc56.exe:	.\test.component.platformstl.filesystem.properties_file.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.platformstl.filesystem.properties_file.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.component.platformstl.filesystem.properties_file.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.properties_file\test.component.platformstl.filesystem.properties_file.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.properties_file\test.component.platformstl.filesystem.properties_file.cpp

..\..\bin\test.component.platformstl.filesystem.readdir_sequence.bc56.exe:	.\test.component.platformstl.filesystem.readdir_sequence.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.platformstl.filesystem.readdir_sequence.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.component.platformstl.filesystem.readdir_sequence.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.readdir_sequence\test.component.platformstl.filesystem.readdir_sequence.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.readdir_sequence\test.component.platformstl.filesystem.readdir_sequence.cpp

..\..\bin\test.component.platformstl.performance.performance_counter.bc56.exe:	.\test.component.platformstl.performance.performance_counter.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.platformstl.performance.performance_counter.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.component.platformstl.performance.performance_counter.obj:	..\..\test\component\platformstl\performance\test.component.platformstl.performance.performance_counter\test.component.platformstl.performance.performance_counter.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\performance\test.component.platformstl.performance.performance_counter\test.component.platformstl.performance.performance_counter.cpp

..\..\bin\test.unit.platformstl.system.str_set.bc56.exe:	.\test.unit.platformstl.system.str_set.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.platformstl.system.str_set.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.platformstl.system.str_set.obj:	..\..\test\unit\platformstl\system\test.unit.platformstl.system.str_set\test.unit.platformstl.system.str_set.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\platformstl\system\test.unit.platformstl.system.str_set\test.unit.platformstl.system.str_set.cpp


############################################################################
# Internal Targets

########################################
# stlsoft:

..\..\bin\test.component.stlsoft.iterator.FILE_iterator.bc56.exe:	.\test.component.stlsoft.iterator.FILE_iterator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.stlsoft.iterator.FILE_iterator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.component.stlsoft.iterator.FILE_iterator.obj:	..\..\test\component\stlsoft\iterator\test.component.stlsoft.iterator.FILE_iterator\test.component.stlsoft.iterator.FILE_iterator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\stlsoft\iterator\test.component.stlsoft.iterator.FILE_iterator\test.component.stlsoft.iterator.FILE_iterator.cpp

..\..\bin\test.performance.stlsoft.conversion.truncation_test.bc56.exe:	.\test.performance.stlsoft.conversion.truncation_test.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.performance.stlsoft.conversion.truncation_test.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.performance.stlsoft.conversion.truncation_test.obj:	..\..\test\performance\stlsoft\conversion\test.performance.stlsoft.conversion.truncation_test\test.performance.stlsoft.conversion.truncation_test.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\performance\stlsoft\conversion\test.performance.stlsoft.conversion.truncation_test\test.performance.stlsoft.conversion.truncation_test.cpp

..\..\bin\test.scratch.stlsoft.error.error_desc.bc56.exe:	.\test.scratch.stlsoft.error.error_desc.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.scratch.stlsoft.error.error_desc.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.scratch.stlsoft.error.error_desc.obj:	..\..\test\scratch\stlsoft\error\test.scratch.stlsoft.error.error_desc\test.scratch.stlsoft.error.error_desc.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\stlsoft\error\test.scratch.stlsoft.error.error_desc\test.scratch.stlsoft.error.error_desc.cpp

..\..\bin\test.scratch.stlsoft.smartptr.scoped_handle.bc56.exe:	.\test.scratch.stlsoft.smartptr.scoped_handle.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.scratch.stlsoft.smartptr.scoped_handle.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.scratch.stlsoft.smartptr.scoped_handle.obj:	..\..\test\scratch\stlsoft\smartptr\test.scratch.stlsoft.smartptr.scoped_handle\test.scratch.stlsoft.smartptr.scoped_handle.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\stlsoft\smartptr\test.scratch.stlsoft.smartptr.scoped_handle\test.scratch.stlsoft.smartptr.scoped_handle.cpp

..\..\bin\test.scratch.stlsoft.util.rand.bc56.exe:	.\test.scratch.stlsoft.util.rand.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.scratch.stlsoft.util.rand.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.scratch.stlsoft.util.rand.obj:	..\..\test\scratch\stlsoft\util\test.scratch.stlsoft.util.rand\test.scratch.stlsoft.util.rand.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\stlsoft\util\test.scratch.stlsoft.util.rand\test.scratch.stlsoft.util.rand.cpp

..\..\bin\test.unit.stlsoft.algorithm.literal_copy.bc56.exe:	.\test.unit.stlsoft.algorithm.literal_copy.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.algorithm.literal_copy.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.algorithm.literal_copy.obj:	..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.literal_copy\test.unit.stlsoft.algorithm.literal_copy.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.literal_copy\test.unit.stlsoft.algorithm.literal_copy.cpp

..\..\bin\test.unit.stlsoft.algorithm.pod.bc56.exe:	.\test.unit.stlsoft.algorithm.pod.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.algorithm.pod.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.algorithm.pod.obj:	..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.pod\test.unit.stlsoft.algorithm.pod.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.pod\test.unit.stlsoft.algorithm.pod.cpp

..\..\bin\test.unit.stlsoft.collection.edge_case_index_sequence.bc56.exe:	.\test.unit.stlsoft.collection.edge_case_index_sequence.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.collection.edge_case_index_sequence.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.collection.edge_case_index_sequence.obj:	..\..\test\unit\stlsoft\collection\test.unit.stlsoft.collection.edge_case_index_sequence\test.unit.stlsoft.collection.edge_case_index_sequence.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\collection\test.unit.stlsoft.collection.edge_case_index_sequence\test.unit.stlsoft.collection.edge_case_index_sequence.cpp

..\..\bin\test.unit.stlsoft.container.fixed_arrays.bc56.exe:	.\test.unit.stlsoft.container.fixed_arrays.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.container.fixed_arrays.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.container.fixed_arrays.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.fixed_arrays\test.unit.stlsoft.container.fixed_arrays.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.fixed_arrays\test.unit.stlsoft.container.fixed_arrays.cpp

..\..\bin\test.unit.stlsoft.container.frequency_map.bc56.exe:	.\test.unit.stlsoft.container.frequency_map.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.container.frequency_map.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.container.frequency_map.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.frequency_map\test.unit.stlsoft.container.frequency_map.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.frequency_map\test.unit.stlsoft.container.frequency_map.cpp

..\..\bin\test.unit.stlsoft.container.initialised_array.bc56.exe:	.\test.unit.stlsoft.container.initialised_array.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.container.initialised_array.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.container.initialised_array.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.initialised_array\test.unit.stlsoft.container.initialised_array.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.initialised_array\test.unit.stlsoft.container.initialised_array.cpp

..\..\bin\test.unit.stlsoft.container.layered_map.bc56.exe:	.\test.unit.stlsoft.container.layered_map.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.container.layered_map.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.container.layered_map.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.layered_map\test.unit.stlsoft.container.layered_map.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.layered_map\test.unit.stlsoft.container.layered_map.cpp

..\..\bin\test.unit.stlsoft.container.partially_initialised_array.bc56.exe:	.\test.unit.stlsoft.container.partially_initialised_array.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.container.partially_initialised_array.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.container.partially_initialised_array.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.partially_initialised_array\test.unit.stlsoft.container.partially_initialised_array.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.partially_initialised_array\test.unit.stlsoft.container.partially_initialised_array.cpp

..\..\bin\test.unit.stlsoft.container.pod_vector.bc56.exe:	.\test.unit.stlsoft.container.pod_vector.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.container.pod_vector.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.container.pod_vector.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.pod_vector\test.unit.stlsoft.container.pod_vector.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.pod_vector\test.unit.stlsoft.container.pod_vector.cpp

..\..\bin\test.unit.stlsoft.conversion.integer_to_array.bc56.exe:	.\test.unit.stlsoft.conversion.integer_to_array.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.conversion.integer_to_array.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.conversion.integer_to_array.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_array\test.unit.stlsoft.conversion.integer_to_array.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_array\test.unit.stlsoft.conversion.integer_to_array.cpp

..\..\bin\test.unit.stlsoft.conversion.integer_to_hex_string.bc56.exe:	.\test.unit.stlsoft.conversion.integer_to_hex_string.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.conversion.integer_to_hex_string.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.conversion.integer_to_hex_string.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_hex_string\test.unit.stlsoft.conversion.integer_to_hex_string.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_hex_string\test.unit.stlsoft.conversion.integer_to_hex_string.cpp

..\..\bin\test.unit.stlsoft.conversion.string_to_integer.bc56.exe:	.\test.unit.stlsoft.conversion.string_to_integer.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.conversion.string_to_integer.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.conversion.string_to_integer.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.string_to_integer\test.unit.stlsoft.conversion.string_to_integer.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.string_to_integer\test.unit.stlsoft.conversion.string_to_integer.cpp

..\..\bin\test.unit.stlsoft.conversion.truncation_test.bc56.exe:	.\test.unit.stlsoft.conversion.truncation_test.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.conversion.truncation_test.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.conversion.truncation_test.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.truncation_test\test.unit.stlsoft.conversion.truncation_test.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.truncation_test\test.unit.stlsoft.conversion.truncation_test.cpp

..\..\bin\test.unit.stlsoft.conversion.union_cast.bc56.exe:	.\test.unit.stlsoft.conversion.union_cast.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.conversion.union_cast.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.conversion.union_cast.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.union_cast\test.unit.stlsoft.conversion.union_cast.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.union_cast\test.unit.stlsoft.conversion.union_cast.cpp

..\..\bin\test.unit.stlsoft.error.error_desc.bc56.exe:	.\test.unit.stlsoft.error.error_desc.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.error.error_desc.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.error.error_desc.obj:	..\..\test\unit\stlsoft\error\test.unit.stlsoft.error.error_desc\test.unit.stlsoft.error.error_desc.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\error\test.unit.stlsoft.error.error_desc\test.unit.stlsoft.error.error_desc.cpp

..\..\bin\test.unit.stlsoft.exception.exception_string.bc56.exe:	.\test.unit.stlsoft.exception.exception_string.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.exception.exception_string.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.exception.exception_string.obj:	..\..\test\unit\stlsoft\exception\test.unit.stlsoft.exception.exception_string\test.unit.stlsoft.exception.exception_string.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\exception\test.unit.stlsoft.exception.exception_string\test.unit.stlsoft.exception.exception_string.cpp

..\..\bin\test.unit.stlsoft.filesystem.read_line.bc56.exe:	.\test.unit.stlsoft.filesystem.read_line.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.filesystem.read_line.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.filesystem.read_line.obj:	..\..\test\unit\stlsoft\filesystem\test.unit.stlsoft.filesystem.read_line\test.unit.stlsoft.filesystem.read_line.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\filesystem\test.unit.stlsoft.filesystem.read_line\test.unit.stlsoft.filesystem.read_line.cpp

..\..\bin\test.unit.stlsoft.functional.bit_operations.bc56.exe:	.\test.unit.stlsoft.functional.bit_operations.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.functional.bit_operations.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.functional.bit_operations.obj:	..\..\test\unit\stlsoft\functional\test.unit.stlsoft.functional.bit_operations\test.unit.stlsoft.functional.bit_operations.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\functional\test.unit.stlsoft.functional.bit_operations\test.unit.stlsoft.functional.bit_operations.cpp

..\..\bin\test.unit.stlsoft.iterator.associative_eraser_iterator.bc56.exe:	.\test.unit.stlsoft.iterator.associative_eraser_iterator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.iterator.associative_eraser_iterator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.iterator.associative_eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.associative_eraser_iterator\test.unit.stlsoft.iterator.associative_eraser_iterator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.associative_eraser_iterator\test.unit.stlsoft.iterator.associative_eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.eraser_iterator.bc56.exe:	.\test.unit.stlsoft.iterator.eraser_iterator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.iterator.eraser_iterator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.iterator.eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.eraser_iterator\test.unit.stlsoft.iterator.eraser_iterator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.eraser_iterator\test.unit.stlsoft.iterator.eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.sorted_eraser_iterator.bc56.exe:	.\test.unit.stlsoft.iterator.sorted_eraser_iterator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.iterator.sorted_eraser_iterator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.iterator.sorted_eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.string_concatenator_iterator.bc56.exe:	.\test.unit.stlsoft.iterator.string_concatenator_iterator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.iterator.string_concatenator_iterator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.iterator.string_concatenator_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.string_concatenator_iterator\test.unit.stlsoft.iterator.string_concatenator_iterator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.string_concatenator_iterator\test.unit.stlsoft.iterator.string_concatenator_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.transform_iterator.bc56.exe:	.\test.unit.stlsoft.iterator.transform_iterator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.iterator.transform_iterator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.iterator.transform_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.transform_iterator\test.unit.stlsoft.iterator.transform_iterator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.transform_iterator\test.unit.stlsoft.iterator.transform_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.unsorted_eraser_iterator.bc56.exe:	.\test.unit.stlsoft.iterator.unsorted_eraser_iterator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.iterator.unsorted_eraser_iterator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.iterator.unsorted_eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.memory.auto_buffer.bc56.exe:	.\test.unit.stlsoft.memory.auto_buffer.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.memory.auto_buffer.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.memory.auto_buffer.obj:	..\..\test\unit\stlsoft\memory\test.unit.stlsoft.memory.auto_buffer\test.unit.stlsoft.memory.auto_buffer.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\memory\test.unit.stlsoft.memory.auto_buffer\test.unit.stlsoft.memory.auto_buffer.cpp

..\..\bin\test.unit.stlsoft.meta.is_printf_type.bc56.exe:	.\test.unit.stlsoft.meta.is_printf_type.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.meta.is_printf_type.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.meta.is_printf_type.obj:	..\..\test\unit\stlsoft\meta\test.unit.stlsoft.meta.is_printf_type\test.unit.stlsoft.meta.is_printf_type.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\meta\test.unit.stlsoft.meta.is_printf_type\test.unit.stlsoft.meta.is_printf_type.cpp

..\..\bin\test.unit.stlsoft.shims.access.string.std.time.bc56.exe:	.\test.unit.stlsoft.shims.access.string.std.time.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.shims.access.string.std.time.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.shims.access.string.std.time.obj:	..\..\test\unit\stlsoft\shims\access\string\test.unit.stlsoft.shims.access.string.std.time\test.unit.stlsoft.shims.access.string.std.time.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\shims\access\string\test.unit.stlsoft.shims.access.string.std.time\test.unit.stlsoft.shims.access.string.std.time.cpp

..\..\bin\test.unit.stlsoft.smartptr.scoped_handle.bc56.exe:	.\test.unit.stlsoft.smartptr.scoped_handle.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.smartptr.scoped_handle.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.smartptr.scoped_handle.obj:	..\..\test\unit\stlsoft\smartptr\scoped_handle\test.unit.stlsoft.smartptr.scoped_handle\test.unit.stlsoft.smartptr.scoped_handle.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\scoped_handle\test.unit.stlsoft.smartptr.scoped_handle\test.unit.stlsoft.smartptr.scoped_handle.cpp

..\..\bin\test.unit.stlsoft.smartptr.scoped_method.bc56.exe:	.\test.unit.stlsoft.smartptr.scoped_method.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.smartptr.scoped_method.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.smartptr.scoped_method.obj:	..\..\test\unit\stlsoft\smartptr\scoped_method\test.unit.stlsoft.smartptr.scoped_method\test.unit.stlsoft.smartptr.scoped_method.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\scoped_method\test.unit.stlsoft.smartptr.scoped_method\test.unit.stlsoft.smartptr.scoped_method.cpp

..\..\bin\test.unit.stlsoft.smartptr.scoped_ptr.bc56.exe:	.\test.unit.stlsoft.smartptr.scoped_ptr.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.smartptr.scoped_ptr.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.smartptr.scoped_ptr.obj:	..\..\test\unit\stlsoft\smartptr\scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr.cpp

..\..\bin\test.unit.stlsoft.smartptr.shared_ptr.bc56.exe:	.\test.unit.stlsoft.smartptr.shared_ptr.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.smartptr.shared_ptr.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.smartptr.shared_ptr.obj:	..\..\test\unit\stlsoft\smartptr\shared_ptr\test.unit.stlsoft.smartptr.shared_ptr\test.unit.stlsoft.smartptr.shared_ptr.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\shared_ptr\test.unit.stlsoft.smartptr.shared_ptr\test.unit.stlsoft.smartptr.shared_ptr.cpp

..\..\bin\test.unit.stlsoft.string.replace_functions.bc56.exe:	.\test.unit.stlsoft.string.replace_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.replace_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.replace_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.replace_functions\test.unit.stlsoft.string.replace_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.replace_functions\test.unit.stlsoft.string.replace_functions.cpp

..\..\bin\test.unit.stlsoft.string.shim_string.bc56.exe:	.\test.unit.stlsoft.string.shim_string.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.shim_string.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.shim_string.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.shim_string\test.unit.stlsoft.string.shim_string.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.shim_string\test.unit.stlsoft.string.shim_string.cpp

..\..\bin\test.unit.stlsoft.string.simple_string.bc56.exe:	.\test.unit.stlsoft.string.simple_string.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.simple_string.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.simple_string.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.simple_string\test.unit.stlsoft.string.simple_string.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.simple_string\test.unit.stlsoft.string.simple_string.cpp

..\..\bin\test.unit.stlsoft.string.slice_functions.bc56.exe:	.\test.unit.stlsoft.string.slice_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.slice_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.slice_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.slice_functions\test.unit.stlsoft.string.slice_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.slice_functions\test.unit.stlsoft.string.slice_functions.cpp

..\..\bin\test.unit.stlsoft.string.split_functions.bc56.exe:	.\test.unit.stlsoft.string.split_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.split_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.split_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.split_functions\test.unit.stlsoft.string.split_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.split_functions\test.unit.stlsoft.string.split_functions.cpp

..\..\bin\test.unit.stlsoft.string.static_string.bc56.exe:	.\test.unit.stlsoft.string.static_string.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.static_string.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.static_string.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.static_string\test.unit.stlsoft.string.static_string.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.static_string\test.unit.stlsoft.string.static_string.cpp

..\..\bin\test.unit.stlsoft.string.string_registry.bc56.exe:	.\test.unit.stlsoft.string.string_registry.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.string_registry.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.string_registry.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_registry\test.unit.stlsoft.string.string_registry.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_registry\test.unit.stlsoft.string.string_registry.cpp

..\..\bin\test.unit.stlsoft.string.string_slice.bc56.exe:	.\test.unit.stlsoft.string.string_slice.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.string_slice.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.string_slice.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_slice\test.unit.stlsoft.string.string_slice.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_slice\test.unit.stlsoft.string.string_slice.cpp

..\..\bin\test.unit.stlsoft.string.string_tokeniser.bc56.exe:	.\test.unit.stlsoft.string.string_tokeniser.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.string_tokeniser.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.string_tokeniser.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_tokeniser\test.unit.stlsoft.string.string_tokeniser.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_tokeniser\test.unit.stlsoft.string.string_tokeniser.cpp

..\..\bin\test.unit.stlsoft.string.string_view.bc56.exe:	.\test.unit.stlsoft.string.string_view.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.string_view.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.string_view.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_view\test.unit.stlsoft.string.string_view.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_view\test.unit.stlsoft.string.string_view.cpp

..\..\bin\test.unit.stlsoft.string.tokeniser_functions.bc56.exe:	.\test.unit.stlsoft.string.tokeniser_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.string.tokeniser_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.string.tokeniser_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.tokeniser_functions\test.unit.stlsoft.string.tokeniser_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.tokeniser_functions\test.unit.stlsoft.string.tokeniser_functions.cpp

..\..\bin\test.unit.stlsoft.tr1.smartptr.scoped_ptr.bc56.exe:	.\test.unit.stlsoft.tr1.smartptr.scoped_ptr.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.tr1.smartptr.scoped_ptr.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.tr1.smartptr.scoped_ptr.obj:	..\..\test\unit\stlsoft\tr1\smartptr\scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\tr1\smartptr\scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr.cpp

..\..\bin\test.unit.stlsoft.util.bit_functions.bc56.exe:	.\test.unit.stlsoft.util.bit_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.util.bit_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.util.bit_functions.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.bit_functions\test.unit.stlsoft.util.bit_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.bit_functions\test.unit.stlsoft.util.bit_functions.cpp

..\..\bin\test.unit.stlsoft.util.exception_string_creator.bc56.exe:	.\test.unit.stlsoft.util.exception_string_creator.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.util.exception_string_creator.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.util.exception_string_creator.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.exception_string_creator\test.unit.stlsoft.util.exception_string_creator.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.exception_string_creator\test.unit.stlsoft.util.exception_string_creator.cpp

..\..\bin\test.unit.stlsoft.util.has_bom.bc56.exe:	.\test.unit.stlsoft.util.has_bom.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.util.has_bom.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.util.has_bom.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.has_bom\test.unit.stlsoft.util.has_bom.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.has_bom\test.unit.stlsoft.util.has_bom.cpp

..\..\bin\test.unit.stlsoft.util.minmax.bc56.exe:	.\test.unit.stlsoft.util.minmax.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.util.minmax.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.util.minmax.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.minmax\test.unit.stlsoft.util.minmax.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.minmax\test.unit.stlsoft.util.minmax.cpp

..\..\bin\test.unit.stlsoft.util.must_init.bc56.exe:	.\test.unit.stlsoft.util.must_init.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.util.must_init.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.util.must_init.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.must_init\test.unit.stlsoft.util.must_init.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.must_init\test.unit.stlsoft.util.must_init.cpp

..\..\bin\test.unit.stlsoft.util.rand.bc56.exe:	.\test.unit.stlsoft.util.rand.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.util.rand.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.util.rand.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.rand\test.unit.stlsoft.util.rand.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.rand\test.unit.stlsoft.util.rand.cpp

..\..\bin\test.unit.stlsoft.util.string_switch.bc56.exe:	.\test.unit.stlsoft.util.string_switch.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.stlsoft.util.string_switch.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib 
.\test.unit.stlsoft.util.string_switch.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.string_switch\test.unit.stlsoft.util.string_switch.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.string_switch\test.unit.stlsoft.util.string_switch.cpp


############################################################################
# Internal Targets

########################################
# winstl:

..\..\bin\test.component.winstl.filesystem.findfile_sequence.bc56.exe:	.\test.component.winstl.filesystem.findfile_sequence.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.filesystem.findfile_sequence.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.filesystem.findfile_sequence.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.findfile_sequence\test.component.winstl.filesystem.findfile_sequence.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.findfile_sequence\test.component.winstl.filesystem.findfile_sequence.cpp

..\..\bin\test.component.winstl.filesystem.hrw_file_lines.bc56.exe:	.\test.component.winstl.filesystem.hrw_file_lines.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.filesystem.hrw_file_lines.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.filesystem.hrw_file_lines.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.hrw_file_lines\test.component.winstl.filesystem.hrw_file_lines.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.hrw_file_lines\test.component.winstl.filesystem.hrw_file_lines.cpp

..\..\bin\test.component.winstl.filesystem.memory_map_functions.C.bc56.exe:	.\test.component.winstl.filesystem.memory_map_functions.C.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.filesystem.memory_map_functions.C.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.filesystem.memory_map_functions.C.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions.C\test.component.winstl.filesystem.memory_map_functions.C.c
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions.C\test.component.winstl.filesystem.memory_map_functions.C.c

..\..\bin\test.component.winstl.filesystem.memory_map_functions.bc56.exe:	.\test.component.winstl.filesystem.memory_map_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.filesystem.memory_map_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.filesystem.memory_map_functions.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions\test.component.winstl.filesystem.memory_map_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions\test.component.winstl.filesystem.memory_map_functions.cpp

..\..\bin\test.component.winstl.filesystem.memory_mapped_file_view_handle.bc56.exe:	.\test.component.winstl.filesystem.memory_mapped_file_view_handle.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.filesystem.memory_mapped_file_view_handle.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.filesystem.memory_mapped_file_view_handle.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_mapped_file_view_handle\test.component.winstl.filesystem.memory_mapped_file_view_handle.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_mapped_file_view_handle\test.component.winstl.filesystem.memory_mapped_file_view_handle.cpp

..\..\bin\test.component.winstl.filesystem.readonly_memory_mapped_file.bc56.exe:	.\test.component.winstl.filesystem.readonly_memory_mapped_file.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.filesystem.readonly_memory_mapped_file.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.filesystem.readonly_memory_mapped_file.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.readonly_memory_mapped_file\test.component.winstl.filesystem.readonly_memory_mapped_file.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.readonly_memory_mapped_file\test.component.winstl.filesystem.readonly_memory_mapped_file.cpp

..\..\bin\test.component.winstl.synch.semaphore.bc56.exe:	.\test.component.winstl.synch.semaphore.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.synch.semaphore.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.synch.semaphore.obj:	..\..\test\component\winstl\synch\test.component.winstl.synch.semaphore\test.component.winstl.synch.semaphore.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\synch\test.component.winstl.synch.semaphore\test.component.winstl.synch.semaphore.cpp

..\..\bin\test.component.winstl.system.console_functions.bc56.exe:	.\test.component.winstl.system.console_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.system.console_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.system.console_functions.obj:	..\..\test\component\winstl\system\test.component.winstl.system.console_functions\test.component.winstl.system.console_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.console_functions\test.component.winstl.system.console_functions.cpp

..\..\bin\test.component.winstl.system.environment_variable.bc56.exe:	.\test.component.winstl.system.environment_variable.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.system.environment_variable.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.system.environment_variable.obj:	..\..\test\component\winstl\system\test.component.winstl.system.environment_variable\test.component.winstl.system.environment_variable.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.environment_variable\test.component.winstl.system.environment_variable.cpp

..\..\bin\test.component.winstl.system.system_directory.bc56.exe:	.\test.component.winstl.system.system_directory.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.system.system_directory.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.system.system_directory.obj:	..\..\test\component\winstl\system\test.component.winstl.system.system_directory\test.component.winstl.system.system_directory.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.system_directory\test.component.winstl.system.system_directory.cpp

..\..\bin\test.component.winstl.system.temporary_directory.bc56.exe:	.\test.component.winstl.system.temporary_directory.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.system.temporary_directory.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.system.temporary_directory.obj:	..\..\test\component\winstl\system\test.component.winstl.system.temporary_directory\test.component.winstl.system.temporary_directory.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.temporary_directory\test.component.winstl.system.temporary_directory.cpp

..\..\bin\test.component.winstl.system.windows_directory.bc56.exe:	.\test.component.winstl.system.windows_directory.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.component.winstl.system.windows_directory.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.component.winstl.system.windows_directory.obj:	..\..\test\component\winstl\system\test.component.winstl.system.windows_directory\test.component.winstl.system.windows_directory.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.windows_directory\test.component.winstl.system.windows_directory.cpp

..\..\bin\mmap.bc56.exe:	.\mmap.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\mmap.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\mmap.obj:	..\..\test\scratch\winstl\filesystem\mmap\mmap.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\winstl\filesystem\mmap\mmap.cpp

..\..\bin\test.scratch.winstl.performance.threadtimes_counter.bc56.exe:	.\test.scratch.winstl.performance.threadtimes_counter.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.scratch.winstl.performance.threadtimes_counter.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.scratch.winstl.performance.threadtimes_counter.obj:	..\..\test\scratch\winstl\performance\test.scratch.winstl.performance.threadtimes_counter\test.scratch.winstl.performance.threadtimes_counter.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\winstl\performance\test.scratch.winstl.performance.threadtimes_counter\test.scratch.winstl.performance.threadtimes_counter.cpp

..\..\bin\test.unit.winstl.filesystem.filesystem_traits.1.bc56.exe:	.\test.unit.winstl.filesystem.filesystem_traits.1.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.filesystem.filesystem_traits.1.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.filesystem.filesystem_traits.1.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.1\test.unit.winstl.filesystem.filesystem_traits.1.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.1\test.unit.winstl.filesystem.filesystem_traits.1.cpp

..\..\bin\test.unit.winstl.filesystem.filesystem_traits.2.bc56.exe:	.\test.unit.winstl.filesystem.filesystem_traits.2.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.filesystem.filesystem_traits.2.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.filesystem.filesystem_traits.2.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.2\test.unit.winstl.filesystem.filesystem_traits.2.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.2\test.unit.winstl.filesystem.filesystem_traits.2.cpp

..\..\bin\test.unit.winstl.filesystem.findvolume_sequence.bc56.exe:	.\test.unit.winstl.filesystem.findvolume_sequence.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.filesystem.findvolume_sequence.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.filesystem.findvolume_sequence.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.findvolume_sequence\test.unit.winstl.filesystem.findvolume_sequence.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.findvolume_sequence\test.unit.winstl.filesystem.findvolume_sequence.cpp

..\..\bin\test.unit.winstl.filesystem.memory_mapped_file.bc56.exe:	.\test.unit.winstl.filesystem.memory_mapped_file.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.filesystem.memory_mapped_file.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.filesystem.memory_mapped_file.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.memory_mapped_file\test.unit.winstl.filesystem.memory_mapped_file.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.memory_mapped_file\test.unit.winstl.filesystem.memory_mapped_file.cpp

..\..\bin\test.unit.winstl.filesystem.path.bc56.exe:	.\test.unit.winstl.filesystem.path.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.filesystem.path.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.filesystem.path.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path\test.unit.winstl.filesystem.path.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path\test.unit.winstl.filesystem.path.cpp

..\..\bin\test.unit.winstl.filesystem.path_functions.bc56.exe:	.\test.unit.winstl.filesystem.path_functions.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.filesystem.path_functions.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.filesystem.path_functions.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path_functions\test.unit.winstl.filesystem.path_functions.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path_functions\test.unit.winstl.filesystem.path_functions.cpp

..\..\bin\test.unit.winstl.registry.reg_delete_tree.bc56.exe:	.\test.unit.winstl.registry.reg_delete_tree.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.registry.reg_delete_tree.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.registry.reg_delete_tree.obj:	..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_delete_tree\test.unit.winstl.registry.reg_delete_tree.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_delete_tree\test.unit.winstl.registry.reg_delete_tree.cpp

..\..\bin\test.unit.winstl.registry.reg_value.bc56.exe:	.\test.unit.winstl.registry.reg_value.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.registry.reg_value.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.registry.reg_value.obj:	..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_value\test.unit.winstl.registry.reg_value.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_value\test.unit.winstl.registry.reg_value.cpp

..\..\bin\test.unit.winstl.synch.w4mo.bc56.exe:	.\test.unit.winstl.synch.w4mo.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.synch.w4mo.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.synch.w4mo.obj:	..\..\test\unit\winstl\synch\test.unit.winstl.synch.w4mo\test.unit.winstl.synch.w4mo.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\synch\test.unit.winstl.synch.w4mo\test.unit.winstl.synch.w4mo.cpp

..\..\bin\test.unit.winstl.system.commandline_parser.bc56.exe:	.\test.unit.winstl.system.commandline_parser.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.system.commandline_parser.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.system.commandline_parser.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.commandline_parser\test.unit.winstl.system.commandline_parser.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.commandline_parser\test.unit.winstl.system.commandline_parser.cpp

..\..\bin\test.unit.winstl.system.searchpath_sequence.bc56.exe:	.\test.unit.winstl.system.searchpath_sequence.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.system.searchpath_sequence.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.system.searchpath_sequence.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.searchpath_sequence\test.unit.winstl.system.searchpath_sequence.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.searchpath_sequence\test.unit.winstl.system.searchpath_sequence.cpp

..\..\bin\test.unit.winstl.system.system_traits.1.bc56.exe:	.\test.unit.winstl.system.system_traits.1.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.system.system_traits.1.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.system.system_traits.1.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.1\test.unit.winstl.system.system_traits.1.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.1\test.unit.winstl.system.system_traits.1.cpp

..\..\bin\test.unit.winstl.system.system_traits.2.bc56.exe:	.\test.unit.winstl.system.system_traits.2.obj
	bcc32 -q -L$(LIB_XTESTS)    -e$@ -WC .\test.unit.winstl.system.system_traits.2.obj   xtests.0.core.bc56.lib   advapi32.lib kernel32.lib user32.lib  ole32.lib oleaut32.lib shlwapi.lib uuid.lib
.\test.unit.winstl.system.system_traits.2.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.2\test.unit.winstl.system.system_traits.2.cpp
	bcc32 -c -q  -DWIN32    -x -RT -w -w!  $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.2\test.unit.winstl.system.system_traits.2.cpp

############################################################################
