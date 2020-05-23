############################################################################
# File:     build/cw8.win32/makefile
#
# Purpose:  Makefile for STLSoft 1.10 for Metrowerks CodeWarrior 8 (Windows, 32-bit)
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
 ..\..\bin\test.component.comstl.collections.collection_sequence.cw8.exe\
 \

build.component.platformstl:	check.bin.dir \
 ..\..\bin\test.component.platformstl.filesystem.file_lines.cw8.exe\
 ..\..\bin\test.component.platformstl.f...stem.filesystem_traits.1.cw8.exe\
 ..\..\bin\test.component.platformstl.filesystem.properties_file.cw8.exe\
 ..\..\bin\test.component.platformstl.filesystem.readdir_sequence.cw8.exe\
 ..\..\bin\test.component.platformstl.p...ance.performance_counter.cw8.exe\
 \

build.component.stlsoft:	check.bin.dir \
 ..\..\bin\test.component.stlsoft.iterator.FILE_iterator.cw8.exe\
 \

build.component.winstl:	check.bin.dir \
 ..\..\bin\test.component.winstl.filesystem.findfile_sequence.cw8.exe\
 ..\..\bin\test.component.winstl.filesystem.hrw_file_lines.cw8.exe\
 ..\..\bin\test.component.winstl.filesystem.memory_map_functions.C.cw8.exe\
 ..\..\bin\test.component.winstl.filesystem.memory_map_functions.cw8.exe\
 ..\..\bin\test.component.winstl.filesy..._mapped_file_view_handle.cw8.exe\
 ..\..\bin\test.component.winstl.filesy...donly_memory_mapped_file.cw8.exe\
 ..\..\bin\test.component.winstl.synch.semaphore.cw8.exe\
 ..\..\bin\test.component.winstl.system.console_functions.cw8.exe\
 ..\..\bin\test.component.winstl.system.environment_variable.cw8.exe\
 ..\..\bin\test.component.winstl.system.system_directory.cw8.exe\
 ..\..\bin\test.component.winstl.system.temporary_directory.cw8.exe\
 ..\..\bin\test.component.winstl.system.windows_directory.cw8.exe\
 \

build.performance.comstl:	check.bin.dir \
 \

build.performance.platformstl:	check.bin.dir \
 ..\..\bin\test.component.platformstl.p...ance.performance_counter.cw8.exe\
 \

build.performance.stlsoft:	check.bin.dir \
 ..\..\bin\test.performance.stlsoft.conversion.truncation_test.cw8.exe\
 \

build.performance.winstl:	check.bin.dir \
 ..\..\bin\test.scratch.winstl.performance.threadtimes_counter.cw8.exe\
 \

build.scratch.comstl:	check.bin.dir \
 ..\..\bin\test.scratch.comstl.conversion.interface_cast.cw8.exe\
 ..\..\bin\test.scratch.comstl.conversion.method_cast.cw8.exe\
 \

build.scratch.platformstl:	check.bin.dir \
 \

build.scratch.stlsoft:	check.bin.dir \
 ..\..\bin\test.scratch.stlsoft.error.error_desc.cw8.exe\
 ..\..\bin\test.scratch.stlsoft.iterato...ociative_select_iterator.cw8.exe\
 ..\..\bin\test.scratch.stlsoft.smartptr.scoped_handle.cw8.exe\
 ..\..\bin\test.scratch.stlsoft.util.rand.cw8.exe\
 \

build.scratch.winstl:	check.bin.dir \
 ..\..\bin\test.scratch.winstl.performance.threadtimes_counter.cw8.exe\
 \

build.unit.comstl:	check.bin.dir \
 ..\..\bin\test.unit.comstl.shims.access.string.GUID.cw8.exe\
 ..\..\bin\test.unit.comstl.shims.access.string.VARIANT.cw8.exe\
 ..\..\bin\test.unit.comstl.string.BSTR_functions.C.cw8.exe\
 ..\..\bin\test.unit.comstl.string.BSTR_functions.cw8.exe\
 ..\..\bin\test.unit.comstl.util.GUID_functions.cw8.exe\
 ..\..\bin\test.unit.comstl.util.variant.cw8.exe\
 ..\..\bin\test.unit.comstl.util.VARIANT_functions.cw8.exe\
 \

build.unit.platformstl:	check.bin.dir \
 ..\..\bin\test.unit.platformstl.system.str_set.cw8.exe\
 \

build.unit.stlsoft:	check.bin.dir \
 ..\..\bin\test.unit.stlsoft.algorithm.literal_copy.cw8.exe\
 ..\..\bin\test.unit.stlsoft.algorithm.pod.cw8.exe\
 ..\..\bin\test.unit.stlsoft.collection.edge_case_index_sequence.cw8.exe\
 ..\..\bin\test.unit.stlsoft.container.fixed_arrays.cw8.exe\
 ..\..\bin\test.unit.stlsoft.container.frequency_map.cw8.exe\
 ..\..\bin\test.unit.stlsoft.container.initialised_array.cw8.exe\
 ..\..\bin\test.unit.stlsoft.container.layered_map.cw8.exe\
 ..\..\bin\test.unit.stlsoft.container.partially_initialised_array.cw8.exe\
 ..\..\bin\test.unit.stlsoft.container.pod_vector.cw8.exe\
 ..\..\bin\test.unit.stlsoft.conversion.integer_to_array.cw8.exe\
 ..\..\bin\test.unit.stlsoft.conversion.integer_to_hex_string.cw8.exe\
 ..\..\bin\test.unit.stlsoft.conversion.string_to_integer.cw8.exe\
 ..\..\bin\test.unit.stlsoft.conversion.truncation_test.cw8.exe\
 ..\..\bin\test.unit.stlsoft.conversion.union_cast.cw8.exe\
 ..\..\bin\test.unit.stlsoft.error.error_desc.cw8.exe\
 ..\..\bin\test.unit.stlsoft.exception.exception_string.cw8.exe\
 ..\..\bin\test.unit.stlsoft.filesystem.read_line.cw8.exe\
 ..\..\bin\test.unit.stlsoft.functional.bit_operations.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.associative_eraser_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.associative_select_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.eraser_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.filter_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.preferential_insert_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.sorted_eraser_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.string_concatenator_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.transform_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.iterator.unsorted_eraser_iterator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.memory.auto_buffer.cw8.exe\
 ..\..\bin\test.unit.stlsoft.meta.is_printf_type.cw8.exe\
 ..\..\bin\test.unit.stlsoft.shims.access.string.std.time.cw8.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.scoped_handle.cw8.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.scoped_method.cw8.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.scoped_ptr.cw8.exe\
 ..\..\bin\test.unit.stlsoft.smartptr.shared_ptr.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.replace_functions.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.shim_string.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.simple_string.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.slice_functions.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.split_functions.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.static_string.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.string_registry.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.string_slice.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.string_tokeniser.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.string_view.cw8.exe\
 ..\..\bin\test.unit.stlsoft.string.tokeniser_functions.cw8.exe\
 ..\..\bin\test.unit.stlsoft.tr1.smartptr.scoped_ptr.cw8.exe\
 ..\..\bin\test.unit.stlsoft.util.bit_functions.cw8.exe\
 ..\..\bin\test.unit.stlsoft.util.exception_string_creator.cw8.exe\
 ..\..\bin\test.unit.stlsoft.util.has_bom.cw8.exe\
 ..\..\bin\test.unit.stlsoft.util.minmax.cw8.exe\
 ..\..\bin\test.unit.stlsoft.util.must_init.cw8.exe\
 ..\..\bin\test.unit.stlsoft.util.rand.cw8.exe\
 ..\..\bin\test.unit.stlsoft.util.string_switch.cw8.exe\
 \

build.unit.winstl:	check.bin.dir \
 ..\..\bin\test.unit.winstl.filesystem.filesystem_traits.1.cw8.exe\
 ..\..\bin\test.unit.winstl.filesystem.filesystem_traits.2.cw8.exe\
 ..\..\bin\test.unit.winstl.filesystem.findvolume_sequence.cw8.exe\
 ..\..\bin\test.unit.winstl.filesystem.memory_mapped_file.cw8.exe\
 ..\..\bin\test.unit.winstl.filesystem.path.cw8.exe\
 ..\..\bin\test.unit.winstl.filesystem.path_functions.cw8.exe\
 ..\..\bin\test.unit.winstl.registry.reg_delete_tree.cw8.exe\
 ..\..\bin\test.unit.winstl.registry.reg_value.cw8.exe\
 ..\..\bin\test.unit.winstl.synch.w4mo.cw8.exe\
 ..\..\bin\test.unit.winstl.system.commandline_parser.cw8.exe\
 ..\..\bin\test.unit.winstl.system.searchpath_sequence.cw8.exe\
 ..\..\bin\test.unit.winstl.system.system_traits.1.cw8.exe\
 ..\..\bin\test.unit.winstl.system.system_traits.2.cw8.exe\
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
	..\..\bin\test.component.comstl.collections.collection_sequence.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.component.platformstl:	build.component.platformstl
	@echo Running component tests for platformstl
	..\..\bin\test.component.platformstl.filesystem.file_lines.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.f...stem.filesystem_traits.1.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.filesystem.properties_file.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.filesystem.readdir_sequence.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.platformstl.p...ance.performance_counter.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.component.stlsoft:	build.component.stlsoft
	@echo Running component tests for stlsoft
	..\..\bin\test.component.stlsoft.iterator.FILE_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.component.winstl:	build.component.winstl
	@echo Running component tests for winstl
	..\..\bin\test.component.winstl.filesystem.findfile_sequence.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.hrw_file_lines.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.memory_map_functions.C.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesystem.memory_map_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesy..._mapped_file_view_handle.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.filesy...donly_memory_mapped_file.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.synch.semaphore.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.console_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.environment_variable.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.system_directory.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.temporary_directory.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.component.winstl.system.windows_directory.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.performance.comstl:	build.performance.comstl
	@echo Running performance tests for comstl

test.performance.platformstl:	build.performance.platformstl
	@echo Running performance tests for platformstl
	..\..\bin\test.component.platformstl.p...ance.performance_counter.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.performance.stlsoft:	build.performance.stlsoft
	@echo Running performance tests for stlsoft
	..\..\bin\test.performance.stlsoft.conversion.truncation_test.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.performance.winstl:	build.performance.winstl
	@echo Running performance tests for winstl
	..\..\bin\test.scratch.winstl.performance.threadtimes_counter.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.scratch.comstl:	build.scratch.comstl
	@echo Running scratch tests for comstl
	..\..\bin\test.scratch.comstl.conversion.interface_cast.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.scratch.comstl.conversion.method_cast.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.scratch.platformstl:	build.scratch.platformstl
	@echo Running scratch tests for platformstl

test.scratch.stlsoft:	build.scratch.stlsoft
	@echo Running scratch tests for stlsoft
	..\..\bin\test.scratch.stlsoft.error.error_desc.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.scratch.stlsoft.iterato...ociative_select_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.scratch.stlsoft.smartptr.scoped_handle.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.scratch.stlsoft.util.rand.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.scratch.winstl:	build.scratch.winstl
	@echo Running scratch tests for winstl
	..\..\bin\test.scratch.winstl.performance.threadtimes_counter.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.unit.comstl:	build.unit.comstl
	@echo Running unit tests for comstl
	..\..\bin\test.unit.comstl.shims.access.string.GUID.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.shims.access.string.VARIANT.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.string.BSTR_functions.C.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.string.BSTR_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.util.GUID_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.util.variant.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.comstl.util.VARIANT_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.unit.platformstl:	build.unit.platformstl
	@echo Running unit tests for platformstl
	..\..\bin\test.unit.platformstl.system.str_set.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.unit.stlsoft:	build.unit.stlsoft
	@echo Running unit tests for stlsoft
	..\..\bin\test.unit.stlsoft.algorithm.literal_copy.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.algorithm.pod.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.collection.edge_case_index_sequence.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.fixed_arrays.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.frequency_map.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.initialised_array.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.layered_map.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.partially_initialised_array.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.container.pod_vector.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.integer_to_array.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.integer_to_hex_string.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.string_to_integer.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.truncation_test.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.conversion.union_cast.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.error.error_desc.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.exception.exception_string.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.filesystem.read_line.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.functional.bit_operations.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.associative_eraser_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.associative_select_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.eraser_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.filter_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.preferential_insert_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.sorted_eraser_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.string_concatenator_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.transform_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.iterator.unsorted_eraser_iterator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.memory.auto_buffer.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.meta.is_printf_type.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.shims.access.string.std.time.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.scoped_handle.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.scoped_method.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.scoped_ptr.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.smartptr.shared_ptr.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.replace_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.shim_string.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.simple_string.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.slice_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.split_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.static_string.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_registry.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_slice.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_tokeniser.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.string_view.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.string.tokeniser_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.tr1.smartptr.scoped_ptr.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.bit_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.exception_string_creator.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.has_bom.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.minmax.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.must_init.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.rand.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.stlsoft.util.string_switch.cw8.exe --verbosity=$(TEST_VERBOSITY)

test.unit.winstl:	build.unit.winstl
	@echo Running unit tests for winstl
	..\..\bin\test.unit.winstl.filesystem.filesystem_traits.1.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.filesystem_traits.2.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.findvolume_sequence.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.memory_mapped_file.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.path.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.filesystem.path_functions.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.registry.reg_delete_tree.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.registry.reg_value.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.synch.w4mo.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.commandline_parser.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.searchpath_sequence.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.system_traits.1.cw8.exe --verbosity=$(TEST_VERBOSITY)
	..\..\bin\test.unit.winstl.system.system_traits.2.cw8.exe --verbosity=$(TEST_VERBOSITY)

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

..\..\bin\test.component.comstl.collections.collection_sequence.cw8.exe:	.\test.component.comstl.collections.collection_sequence.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.comstl.collections.collection_sequence.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.component.comstl.collections.collection_sequence.obj:	..\..\test\component\comstl\collections\test.component.comstl.collections.collection_sequence\test.component.comstl.collections.collection_sequence.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\comstl\collections\test.component.comstl.collections.collection_sequence\test.component.comstl.collections.collection_sequence.cpp

..\..\bin\test.scratch.comstl.conversion.interface_cast.cw8.exe:	.\test.scratch.comstl.conversion.interface_cast.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.scratch.comstl.conversion.interface_cast.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.scratch.comstl.conversion.interface_cast.obj:	..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.interface_cast\test.scratch.comstl.conversion.interface_cast.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.interface_cast\test.scratch.comstl.conversion.interface_cast.cpp

..\..\bin\test.scratch.comstl.conversion.method_cast.cw8.exe:	.\test.scratch.comstl.conversion.method_cast.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.scratch.comstl.conversion.method_cast.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.scratch.comstl.conversion.method_cast.obj:	..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.method_cast\test.scratch.comstl.conversion.method_cast.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\comstl\conversion\test.scratch.comstl.conversion.method_cast\test.scratch.comstl.conversion.method_cast.cpp

..\..\bin\test.unit.comstl.shims.access.string.GUID.cw8.exe:	.\test.unit.comstl.shims.access.string.GUID.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.comstl.shims.access.string.GUID.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.unit.comstl.shims.access.string.GUID.obj:	..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.guid\test.unit.comstl.shims.access.string.GUID.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.guid\test.unit.comstl.shims.access.string.GUID.cpp

..\..\bin\test.unit.comstl.shims.access.string.VARIANT.cw8.exe:	.\test.unit.comstl.shims.access.string.VARIANT.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.comstl.shims.access.string.VARIANT.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.unit.comstl.shims.access.string.VARIANT.obj:	..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.variant\test.unit.comstl.shims.access.string.VARIANT.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\shims\access\string\test.unit.comstl.shims.access.string.variant\test.unit.comstl.shims.access.string.VARIANT.cpp

..\..\bin\test.unit.comstl.string.BSTR_functions.C.cw8.exe:	.\test.unit.comstl.string.BSTR_functions.C.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.comstl.string.BSTR_functions.C.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.unit.comstl.string.BSTR_functions.C.obj:	..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions.C\test.unit.comstl.string.BSTR_functions.C.c
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions.C\test.unit.comstl.string.BSTR_functions.C.c

..\..\bin\test.unit.comstl.string.BSTR_functions.cw8.exe:	.\test.unit.comstl.string.BSTR_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.comstl.string.BSTR_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.unit.comstl.string.BSTR_functions.obj:	..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions\test.unit.comstl.string.BSTR_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\string\test.unit.comstl.string.BSTR_functions\test.unit.comstl.string.BSTR_functions.cpp

..\..\bin\test.unit.comstl.util.GUID_functions.cw8.exe:	.\test.unit.comstl.util.GUID_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.comstl.util.GUID_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.unit.comstl.util.GUID_functions.obj:	..\..\test\unit\comstl\util\test.unit.comstl.util.GUID_functions\test.unit.comstl.util.GUID_functions.c
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\util\test.unit.comstl.util.GUID_functions\test.unit.comstl.util.GUID_functions.c

..\..\bin\test.unit.comstl.util.variant.cw8.exe:	.\test.unit.comstl.util.variant.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.comstl.util.variant.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.unit.comstl.util.variant.obj:	..\..\test\unit\comstl\util\test.unit.comstl.util.variant\test.unit.comstl.util.variant.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\util\test.unit.comstl.util.variant\test.unit.comstl.util.variant.cpp

..\..\bin\test.unit.comstl.util.VARIANT_functions.cw8.exe:	.\test.unit.comstl.util.VARIANT_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.comstl.util.VARIANT_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -luuid.lib
.\test.unit.comstl.util.VARIANT_functions.obj:	..\..\test\unit\comstl\util\test.unit.comstl.util.VARIANT_functions\test.unit.comstl.util.VARIANT_functions.c
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\comstl\util\test.unit.comstl.util.VARIANT_functions\test.unit.comstl.util.VARIANT_functions.c


############################################################################
# Internal Targets

########################################
# platformstl:

..\..\bin\test.component.platformstl.filesystem.file_lines.cw8.exe:	.\test.component.platformstl.filesystem.file_lines.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.platformstl.filesystem.file_lines.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.component.platformstl.filesystem.file_lines.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.file_lines\test.component.platformstl.filesystem.file_lines.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.file_lines\test.component.platformstl.filesystem.file_lines.cpp

..\..\bin\test.component.platformstl.f...stem.filesystem_traits.1.cw8.exe:	.\test.component.platformstl.filesystem.filesystem_traits.1.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.platformstl.filesystem.filesystem_traits.1.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.component.platformstl.filesystem.filesystem_traits.1.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.filesystem_traits.1\test.component.platformstl.filesystem.filesystem_traits.1.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.filesystem_traits.1\test.component.platformstl.filesystem.filesystem_traits.1.cpp

..\..\bin\test.component.platformstl.filesystem.properties_file.cw8.exe:	.\test.component.platformstl.filesystem.properties_file.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.platformstl.filesystem.properties_file.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.component.platformstl.filesystem.properties_file.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.properties_file\test.component.platformstl.filesystem.properties_file.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.properties_file\test.component.platformstl.filesystem.properties_file.cpp

..\..\bin\test.component.platformstl.filesystem.readdir_sequence.cw8.exe:	.\test.component.platformstl.filesystem.readdir_sequence.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.platformstl.filesystem.readdir_sequence.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.component.platformstl.filesystem.readdir_sequence.obj:	..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.readdir_sequence\test.component.platformstl.filesystem.readdir_sequence.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\filesystem\test.component.platformstl.filesystem.readdir_sequence\test.component.platformstl.filesystem.readdir_sequence.cpp

..\..\bin\test.component.platformstl.p...ance.performance_counter.cw8.exe:	.\test.component.platformstl.performance.performance_counter.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.platformstl.performance.performance_counter.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.component.platformstl.performance.performance_counter.obj:	..\..\test\component\platformstl\performance\test.component.platformstl.performance.performance_counter\test.component.platformstl.performance.performance_counter.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\platformstl\performance\test.component.platformstl.performance.performance_counter\test.component.platformstl.performance.performance_counter.cpp

..\..\bin\test.unit.platformstl.system.str_set.cw8.exe:	.\test.unit.platformstl.system.str_set.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.platformstl.system.str_set.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.platformstl.system.str_set.obj:	..\..\test\unit\platformstl\system\test.unit.platformstl.system.str_set\test.unit.platformstl.system.str_set.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\platformstl\system\test.unit.platformstl.system.str_set\test.unit.platformstl.system.str_set.cpp


############################################################################
# Internal Targets

########################################
# stlsoft:

..\..\bin\test.component.stlsoft.iterator.FILE_iterator.cw8.exe:	.\test.component.stlsoft.iterator.FILE_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.stlsoft.iterator.FILE_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.component.stlsoft.iterator.FILE_iterator.obj:	..\..\test\component\stlsoft\iterator\test.component.stlsoft.iterator.FILE_iterator\test.component.stlsoft.iterator.FILE_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\stlsoft\iterator\test.component.stlsoft.iterator.FILE_iterator\test.component.stlsoft.iterator.FILE_iterator.cpp

..\..\bin\test.performance.stlsoft.conversion.truncation_test.cw8.exe:	.\test.performance.stlsoft.conversion.truncation_test.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.performance.stlsoft.conversion.truncation_test.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.performance.stlsoft.conversion.truncation_test.obj:	..\..\test\performance\stlsoft\conversion\test.performance.stlsoft.conversion.truncation_test\test.performance.stlsoft.conversion.truncation_test.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\performance\stlsoft\conversion\test.performance.stlsoft.conversion.truncation_test\test.performance.stlsoft.conversion.truncation_test.cpp

..\..\bin\test.scratch.stlsoft.error.error_desc.cw8.exe:	.\test.scratch.stlsoft.error.error_desc.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.scratch.stlsoft.error.error_desc.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.scratch.stlsoft.error.error_desc.obj:	..\..\test\scratch\stlsoft\error\test.scratch.stlsoft.error.error_desc\test.scratch.stlsoft.error.error_desc.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\stlsoft\error\test.scratch.stlsoft.error.error_desc\test.scratch.stlsoft.error.error_desc.cpp

..\..\bin\test.scratch.stlsoft.iterato...ociative_select_iterator.cw8.exe:	.\test.scratch.stlsoft.iterator.associative_select_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.scratch.stlsoft.iterator.associative_select_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.scratch.stlsoft.iterator.associative_select_iterator.obj:	..\..\test\scratch\stlsoft\iterator\test.scratch.stlsoft.iterator.associative_select_iterator\test.scratch.stlsoft.iterator.associative_select_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\stlsoft\iterator\test.scratch.stlsoft.iterator.associative_select_iterator\test.scratch.stlsoft.iterator.associative_select_iterator.cpp

..\..\bin\test.scratch.stlsoft.smartptr.scoped_handle.cw8.exe:	.\test.scratch.stlsoft.smartptr.scoped_handle.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.scratch.stlsoft.smartptr.scoped_handle.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.scratch.stlsoft.smartptr.scoped_handle.obj:	..\..\test\scratch\stlsoft\smartptr\test.scratch.stlsoft.smartptr.scoped_handle\test.scratch.stlsoft.smartptr.scoped_handle.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\stlsoft\smartptr\test.scratch.stlsoft.smartptr.scoped_handle\test.scratch.stlsoft.smartptr.scoped_handle.cpp

..\..\bin\test.scratch.stlsoft.util.rand.cw8.exe:	.\test.scratch.stlsoft.util.rand.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.scratch.stlsoft.util.rand.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.scratch.stlsoft.util.rand.obj:	..\..\test\scratch\stlsoft\util\test.scratch.stlsoft.util.rand\test.scratch.stlsoft.util.rand.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\stlsoft\util\test.scratch.stlsoft.util.rand\test.scratch.stlsoft.util.rand.cpp

..\..\bin\test.unit.stlsoft.algorithm.literal_copy.cw8.exe:	.\test.unit.stlsoft.algorithm.literal_copy.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.algorithm.literal_copy.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.algorithm.literal_copy.obj:	..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.literal_copy\test.unit.stlsoft.algorithm.literal_copy.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.literal_copy\test.unit.stlsoft.algorithm.literal_copy.cpp

..\..\bin\test.unit.stlsoft.algorithm.pod.cw8.exe:	.\test.unit.stlsoft.algorithm.pod.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.algorithm.pod.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.algorithm.pod.obj:	..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.pod\test.unit.stlsoft.algorithm.pod.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\algorithm\test.unit.stlsoft.algorithm.pod\test.unit.stlsoft.algorithm.pod.cpp

..\..\bin\test.unit.stlsoft.collection.edge_case_index_sequence.cw8.exe:	.\test.unit.stlsoft.collection.edge_case_index_sequence.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.collection.edge_case_index_sequence.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.collection.edge_case_index_sequence.obj:	..\..\test\unit\stlsoft\collection\test.unit.stlsoft.collection.edge_case_index_sequence\test.unit.stlsoft.collection.edge_case_index_sequence.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\collection\test.unit.stlsoft.collection.edge_case_index_sequence\test.unit.stlsoft.collection.edge_case_index_sequence.cpp

..\..\bin\test.unit.stlsoft.container.fixed_arrays.cw8.exe:	.\test.unit.stlsoft.container.fixed_arrays.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.container.fixed_arrays.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.container.fixed_arrays.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.fixed_arrays\test.unit.stlsoft.container.fixed_arrays.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.fixed_arrays\test.unit.stlsoft.container.fixed_arrays.cpp

..\..\bin\test.unit.stlsoft.container.frequency_map.cw8.exe:	.\test.unit.stlsoft.container.frequency_map.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.container.frequency_map.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.container.frequency_map.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.frequency_map\test.unit.stlsoft.container.frequency_map.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.frequency_map\test.unit.stlsoft.container.frequency_map.cpp

..\..\bin\test.unit.stlsoft.container.initialised_array.cw8.exe:	.\test.unit.stlsoft.container.initialised_array.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.container.initialised_array.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.container.initialised_array.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.initialised_array\test.unit.stlsoft.container.initialised_array.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.initialised_array\test.unit.stlsoft.container.initialised_array.cpp

..\..\bin\test.unit.stlsoft.container.layered_map.cw8.exe:	.\test.unit.stlsoft.container.layered_map.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.container.layered_map.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.container.layered_map.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.layered_map\test.unit.stlsoft.container.layered_map.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.layered_map\test.unit.stlsoft.container.layered_map.cpp

..\..\bin\test.unit.stlsoft.container.partially_initialised_array.cw8.exe:	.\test.unit.stlsoft.container.partially_initialised_array.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.container.partially_initialised_array.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.container.partially_initialised_array.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.partially_initialised_array\test.unit.stlsoft.container.partially_initialised_array.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.partially_initialised_array\test.unit.stlsoft.container.partially_initialised_array.cpp

..\..\bin\test.unit.stlsoft.container.pod_vector.cw8.exe:	.\test.unit.stlsoft.container.pod_vector.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.container.pod_vector.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.container.pod_vector.obj:	..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.pod_vector\test.unit.stlsoft.container.pod_vector.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\container\test.unit.stlsoft.container.pod_vector\test.unit.stlsoft.container.pod_vector.cpp

..\..\bin\test.unit.stlsoft.conversion.integer_to_array.cw8.exe:	.\test.unit.stlsoft.conversion.integer_to_array.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.conversion.integer_to_array.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.conversion.integer_to_array.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_array\test.unit.stlsoft.conversion.integer_to_array.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_array\test.unit.stlsoft.conversion.integer_to_array.cpp

..\..\bin\test.unit.stlsoft.conversion.integer_to_hex_string.cw8.exe:	.\test.unit.stlsoft.conversion.integer_to_hex_string.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.conversion.integer_to_hex_string.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.conversion.integer_to_hex_string.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_hex_string\test.unit.stlsoft.conversion.integer_to_hex_string.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.integer_to_hex_string\test.unit.stlsoft.conversion.integer_to_hex_string.cpp

..\..\bin\test.unit.stlsoft.conversion.string_to_integer.cw8.exe:	.\test.unit.stlsoft.conversion.string_to_integer.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.conversion.string_to_integer.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.conversion.string_to_integer.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.string_to_integer\test.unit.stlsoft.conversion.string_to_integer.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.string_to_integer\test.unit.stlsoft.conversion.string_to_integer.cpp

..\..\bin\test.unit.stlsoft.conversion.truncation_test.cw8.exe:	.\test.unit.stlsoft.conversion.truncation_test.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.conversion.truncation_test.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.conversion.truncation_test.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.truncation_test\test.unit.stlsoft.conversion.truncation_test.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.truncation_test\test.unit.stlsoft.conversion.truncation_test.cpp

..\..\bin\test.unit.stlsoft.conversion.union_cast.cw8.exe:	.\test.unit.stlsoft.conversion.union_cast.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.conversion.union_cast.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.conversion.union_cast.obj:	..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.union_cast\test.unit.stlsoft.conversion.union_cast.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\conversion\test.unit.stlsoft.conversion.union_cast\test.unit.stlsoft.conversion.union_cast.cpp

..\..\bin\test.unit.stlsoft.error.error_desc.cw8.exe:	.\test.unit.stlsoft.error.error_desc.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.error.error_desc.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.error.error_desc.obj:	..\..\test\unit\stlsoft\error\test.unit.stlsoft.error.error_desc\test.unit.stlsoft.error.error_desc.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\error\test.unit.stlsoft.error.error_desc\test.unit.stlsoft.error.error_desc.cpp

..\..\bin\test.unit.stlsoft.exception.exception_string.cw8.exe:	.\test.unit.stlsoft.exception.exception_string.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.exception.exception_string.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.exception.exception_string.obj:	..\..\test\unit\stlsoft\exception\test.unit.stlsoft.exception.exception_string\test.unit.stlsoft.exception.exception_string.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\exception\test.unit.stlsoft.exception.exception_string\test.unit.stlsoft.exception.exception_string.cpp

..\..\bin\test.unit.stlsoft.filesystem.read_line.cw8.exe:	.\test.unit.stlsoft.filesystem.read_line.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.filesystem.read_line.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.filesystem.read_line.obj:	..\..\test\unit\stlsoft\filesystem\test.unit.stlsoft.filesystem.read_line\test.unit.stlsoft.filesystem.read_line.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\filesystem\test.unit.stlsoft.filesystem.read_line\test.unit.stlsoft.filesystem.read_line.cpp

..\..\bin\test.unit.stlsoft.functional.bit_operations.cw8.exe:	.\test.unit.stlsoft.functional.bit_operations.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.functional.bit_operations.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.functional.bit_operations.obj:	..\..\test\unit\stlsoft\functional\test.unit.stlsoft.functional.bit_operations\test.unit.stlsoft.functional.bit_operations.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\functional\test.unit.stlsoft.functional.bit_operations\test.unit.stlsoft.functional.bit_operations.cpp

..\..\bin\test.unit.stlsoft.iterator.associative_eraser_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.associative_eraser_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.associative_eraser_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.associative_eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.associative_eraser_iterator\test.unit.stlsoft.iterator.associative_eraser_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.associative_eraser_iterator\test.unit.stlsoft.iterator.associative_eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.associative_select_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.associative_select_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.associative_select_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.associative_select_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.associative_select_iterator\test.unit.stlsoft.iterator.associative_select_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.associative_select_iterator\test.unit.stlsoft.iterator.associative_select_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.eraser_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.eraser_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.eraser_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.eraser_iterator\test.unit.stlsoft.iterator.eraser_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.eraser_iterator\test.unit.stlsoft.iterator.eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.filter_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.filter_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.filter_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.filter_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.filter_iterator\test.unit.stlsoft.iterator.filter_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.filter_iterator\test.unit.stlsoft.iterator.filter_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.preferential_insert_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.preferential_insert_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.preferential_insert_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.preferential_insert_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.preferential_insert_iterator\test.unit.stlsoft.iterator.preferential_insert_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.preferential_insert_iterator\test.unit.stlsoft.iterator.preferential_insert_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.sorted_eraser_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.sorted_eraser_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.sorted_eraser_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.sorted_eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator\test.unit.stlsoft.iterator.sorted_eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.string_concatenator_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.string_concatenator_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.string_concatenator_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.string_concatenator_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.string_concatenator_iterator\test.unit.stlsoft.iterator.string_concatenator_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.string_concatenator_iterator\test.unit.stlsoft.iterator.string_concatenator_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.transform_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.transform_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.transform_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.transform_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.transform_iterator\test.unit.stlsoft.iterator.transform_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.transform_iterator\test.unit.stlsoft.iterator.transform_iterator.cpp

..\..\bin\test.unit.stlsoft.iterator.unsorted_eraser_iterator.cw8.exe:	.\test.unit.stlsoft.iterator.unsorted_eraser_iterator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.iterator.unsorted_eraser_iterator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.iterator.unsorted_eraser_iterator.obj:	..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator\test.unit.stlsoft.iterator.unsorted_eraser_iterator.cpp

..\..\bin\test.unit.stlsoft.memory.auto_buffer.cw8.exe:	.\test.unit.stlsoft.memory.auto_buffer.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.memory.auto_buffer.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.memory.auto_buffer.obj:	..\..\test\unit\stlsoft\memory\test.unit.stlsoft.memory.auto_buffer\test.unit.stlsoft.memory.auto_buffer.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\memory\test.unit.stlsoft.memory.auto_buffer\test.unit.stlsoft.memory.auto_buffer.cpp

..\..\bin\test.unit.stlsoft.meta.is_printf_type.cw8.exe:	.\test.unit.stlsoft.meta.is_printf_type.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.meta.is_printf_type.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.meta.is_printf_type.obj:	..\..\test\unit\stlsoft\meta\test.unit.stlsoft.meta.is_printf_type\test.unit.stlsoft.meta.is_printf_type.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\meta\test.unit.stlsoft.meta.is_printf_type\test.unit.stlsoft.meta.is_printf_type.cpp

..\..\bin\test.unit.stlsoft.shims.access.string.std.time.cw8.exe:	.\test.unit.stlsoft.shims.access.string.std.time.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.shims.access.string.std.time.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.shims.access.string.std.time.obj:	..\..\test\unit\stlsoft\shims\access\string\test.unit.stlsoft.shims.access.string.std.time\test.unit.stlsoft.shims.access.string.std.time.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\shims\access\string\test.unit.stlsoft.shims.access.string.std.time\test.unit.stlsoft.shims.access.string.std.time.cpp

..\..\bin\test.unit.stlsoft.smartptr.scoped_handle.cw8.exe:	.\test.unit.stlsoft.smartptr.scoped_handle.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.smartptr.scoped_handle.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.smartptr.scoped_handle.obj:	..\..\test\unit\stlsoft\smartptr\scoped_handle\test.unit.stlsoft.smartptr.scoped_handle\test.unit.stlsoft.smartptr.scoped_handle.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\scoped_handle\test.unit.stlsoft.smartptr.scoped_handle\test.unit.stlsoft.smartptr.scoped_handle.cpp

..\..\bin\test.unit.stlsoft.smartptr.scoped_method.cw8.exe:	.\test.unit.stlsoft.smartptr.scoped_method.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.smartptr.scoped_method.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.smartptr.scoped_method.obj:	..\..\test\unit\stlsoft\smartptr\scoped_method\test.unit.stlsoft.smartptr.scoped_method\test.unit.stlsoft.smartptr.scoped_method.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\scoped_method\test.unit.stlsoft.smartptr.scoped_method\test.unit.stlsoft.smartptr.scoped_method.cpp

..\..\bin\test.unit.stlsoft.smartptr.scoped_ptr.cw8.exe:	.\test.unit.stlsoft.smartptr.scoped_ptr.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.smartptr.scoped_ptr.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.smartptr.scoped_ptr.obj:	..\..\test\unit\stlsoft\smartptr\scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr\test.unit.stlsoft.smartptr.scoped_ptr.cpp

..\..\bin\test.unit.stlsoft.smartptr.shared_ptr.cw8.exe:	.\test.unit.stlsoft.smartptr.shared_ptr.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.smartptr.shared_ptr.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.smartptr.shared_ptr.obj:	..\..\test\unit\stlsoft\smartptr\shared_ptr\test.unit.stlsoft.smartptr.shared_ptr\test.unit.stlsoft.smartptr.shared_ptr.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\smartptr\shared_ptr\test.unit.stlsoft.smartptr.shared_ptr\test.unit.stlsoft.smartptr.shared_ptr.cpp

..\..\bin\test.unit.stlsoft.string.replace_functions.cw8.exe:	.\test.unit.stlsoft.string.replace_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.replace_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.replace_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.replace_functions\test.unit.stlsoft.string.replace_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.replace_functions\test.unit.stlsoft.string.replace_functions.cpp

..\..\bin\test.unit.stlsoft.string.shim_string.cw8.exe:	.\test.unit.stlsoft.string.shim_string.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.shim_string.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.shim_string.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.shim_string\test.unit.stlsoft.string.shim_string.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.shim_string\test.unit.stlsoft.string.shim_string.cpp

..\..\bin\test.unit.stlsoft.string.simple_string.cw8.exe:	.\test.unit.stlsoft.string.simple_string.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.simple_string.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.simple_string.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.simple_string\test.unit.stlsoft.string.simple_string.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.simple_string\test.unit.stlsoft.string.simple_string.cpp

..\..\bin\test.unit.stlsoft.string.slice_functions.cw8.exe:	.\test.unit.stlsoft.string.slice_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.slice_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.slice_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.slice_functions\test.unit.stlsoft.string.slice_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.slice_functions\test.unit.stlsoft.string.slice_functions.cpp

..\..\bin\test.unit.stlsoft.string.split_functions.cw8.exe:	.\test.unit.stlsoft.string.split_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.split_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.split_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.split_functions\test.unit.stlsoft.string.split_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.split_functions\test.unit.stlsoft.string.split_functions.cpp

..\..\bin\test.unit.stlsoft.string.static_string.cw8.exe:	.\test.unit.stlsoft.string.static_string.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.static_string.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.static_string.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.static_string\test.unit.stlsoft.string.static_string.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.static_string\test.unit.stlsoft.string.static_string.cpp

..\..\bin\test.unit.stlsoft.string.string_registry.cw8.exe:	.\test.unit.stlsoft.string.string_registry.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.string_registry.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.string_registry.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_registry\test.unit.stlsoft.string.string_registry.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_registry\test.unit.stlsoft.string.string_registry.cpp

..\..\bin\test.unit.stlsoft.string.string_slice.cw8.exe:	.\test.unit.stlsoft.string.string_slice.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.string_slice.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.string_slice.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_slice\test.unit.stlsoft.string.string_slice.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_slice\test.unit.stlsoft.string.string_slice.cpp

..\..\bin\test.unit.stlsoft.string.string_tokeniser.cw8.exe:	.\test.unit.stlsoft.string.string_tokeniser.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.string_tokeniser.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.string_tokeniser.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_tokeniser\test.unit.stlsoft.string.string_tokeniser.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_tokeniser\test.unit.stlsoft.string.string_tokeniser.cpp

..\..\bin\test.unit.stlsoft.string.string_view.cw8.exe:	.\test.unit.stlsoft.string.string_view.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.string_view.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.string_view.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_view\test.unit.stlsoft.string.string_view.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.string_view\test.unit.stlsoft.string.string_view.cpp

..\..\bin\test.unit.stlsoft.string.tokeniser_functions.cw8.exe:	.\test.unit.stlsoft.string.tokeniser_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.string.tokeniser_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.string.tokeniser_functions.obj:	..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.tokeniser_functions\test.unit.stlsoft.string.tokeniser_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\string\test.unit.stlsoft.string.tokeniser_functions\test.unit.stlsoft.string.tokeniser_functions.cpp

..\..\bin\test.unit.stlsoft.tr1.smartptr.scoped_ptr.cw8.exe:	.\test.unit.stlsoft.tr1.smartptr.scoped_ptr.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.tr1.smartptr.scoped_ptr.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.tr1.smartptr.scoped_ptr.obj:	..\..\test\unit\stlsoft\tr1\smartptr\scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\tr1\smartptr\scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr\test.unit.stlsoft.tr1.smartptr.scoped_ptr.cpp

..\..\bin\test.unit.stlsoft.util.bit_functions.cw8.exe:	.\test.unit.stlsoft.util.bit_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.util.bit_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.util.bit_functions.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.bit_functions\test.unit.stlsoft.util.bit_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.bit_functions\test.unit.stlsoft.util.bit_functions.cpp

..\..\bin\test.unit.stlsoft.util.exception_string_creator.cw8.exe:	.\test.unit.stlsoft.util.exception_string_creator.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.util.exception_string_creator.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.util.exception_string_creator.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.exception_string_creator\test.unit.stlsoft.util.exception_string_creator.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.exception_string_creator\test.unit.stlsoft.util.exception_string_creator.cpp

..\..\bin\test.unit.stlsoft.util.has_bom.cw8.exe:	.\test.unit.stlsoft.util.has_bom.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.util.has_bom.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.util.has_bom.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.has_bom\test.unit.stlsoft.util.has_bom.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.has_bom\test.unit.stlsoft.util.has_bom.cpp

..\..\bin\test.unit.stlsoft.util.minmax.cw8.exe:	.\test.unit.stlsoft.util.minmax.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.util.minmax.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.util.minmax.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.minmax\test.unit.stlsoft.util.minmax.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.minmax\test.unit.stlsoft.util.minmax.cpp

..\..\bin\test.unit.stlsoft.util.must_init.cw8.exe:	.\test.unit.stlsoft.util.must_init.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.util.must_init.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.util.must_init.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.must_init\test.unit.stlsoft.util.must_init.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.must_init\test.unit.stlsoft.util.must_init.cpp

..\..\bin\test.unit.stlsoft.util.rand.cw8.exe:	.\test.unit.stlsoft.util.rand.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.util.rand.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.util.rand.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.rand\test.unit.stlsoft.util.rand.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.rand\test.unit.stlsoft.util.rand.cpp

..\..\bin\test.unit.stlsoft.util.string_switch.cw8.exe:	.\test.unit.stlsoft.util.string_switch.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.stlsoft.util.string_switch.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib 
.\test.unit.stlsoft.util.string_switch.obj:	..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.string_switch\test.unit.stlsoft.util.string_switch.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\stlsoft\util\test.unit.stlsoft.util.string_switch\test.unit.stlsoft.util.string_switch.cpp


############################################################################
# Internal Targets

########################################
# winstl:

..\..\bin\test.component.winstl.filesystem.findfile_sequence.cw8.exe:	.\test.component.winstl.filesystem.findfile_sequence.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.filesystem.findfile_sequence.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.filesystem.findfile_sequence.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.findfile_sequence\test.component.winstl.filesystem.findfile_sequence.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.findfile_sequence\test.component.winstl.filesystem.findfile_sequence.cpp

..\..\bin\test.component.winstl.filesystem.hrw_file_lines.cw8.exe:	.\test.component.winstl.filesystem.hrw_file_lines.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.filesystem.hrw_file_lines.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.filesystem.hrw_file_lines.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.hrw_file_lines\test.component.winstl.filesystem.hrw_file_lines.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.hrw_file_lines\test.component.winstl.filesystem.hrw_file_lines.cpp

..\..\bin\test.component.winstl.filesystem.memory_map_functions.C.cw8.exe:	.\test.component.winstl.filesystem.memory_map_functions.C.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.filesystem.memory_map_functions.C.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.filesystem.memory_map_functions.C.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions.C\test.component.winstl.filesystem.memory_map_functions.C.c
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions.C\test.component.winstl.filesystem.memory_map_functions.C.c

..\..\bin\test.component.winstl.filesystem.memory_map_functions.cw8.exe:	.\test.component.winstl.filesystem.memory_map_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.filesystem.memory_map_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.filesystem.memory_map_functions.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions\test.component.winstl.filesystem.memory_map_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_map_functions\test.component.winstl.filesystem.memory_map_functions.cpp

..\..\bin\test.component.winstl.filesy..._mapped_file_view_handle.cw8.exe:	.\test.component.winstl.filesystem.memory_mapped_file_view_handle.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.filesystem.memory_mapped_file_view_handle.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.filesystem.memory_mapped_file_view_handle.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_mapped_file_view_handle\test.component.winstl.filesystem.memory_mapped_file_view_handle.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.memory_mapped_file_view_handle\test.component.winstl.filesystem.memory_mapped_file_view_handle.cpp

..\..\bin\test.component.winstl.filesy...donly_memory_mapped_file.cw8.exe:	.\test.component.winstl.filesystem.readonly_memory_mapped_file.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.filesystem.readonly_memory_mapped_file.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.filesystem.readonly_memory_mapped_file.obj:	..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.readonly_memory_mapped_file\test.component.winstl.filesystem.readonly_memory_mapped_file.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\filesystem\test.component.winstl.filesystem.readonly_memory_mapped_file\test.component.winstl.filesystem.readonly_memory_mapped_file.cpp

..\..\bin\test.component.winstl.synch.semaphore.cw8.exe:	.\test.component.winstl.synch.semaphore.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.synch.semaphore.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.synch.semaphore.obj:	..\..\test\component\winstl\synch\test.component.winstl.synch.semaphore\test.component.winstl.synch.semaphore.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\synch\test.component.winstl.synch.semaphore\test.component.winstl.synch.semaphore.cpp

..\..\bin\test.component.winstl.system.console_functions.cw8.exe:	.\test.component.winstl.system.console_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.system.console_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.system.console_functions.obj:	..\..\test\component\winstl\system\test.component.winstl.system.console_functions\test.component.winstl.system.console_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.console_functions\test.component.winstl.system.console_functions.cpp

..\..\bin\test.component.winstl.system.environment_variable.cw8.exe:	.\test.component.winstl.system.environment_variable.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.system.environment_variable.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.system.environment_variable.obj:	..\..\test\component\winstl\system\test.component.winstl.system.environment_variable\test.component.winstl.system.environment_variable.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.environment_variable\test.component.winstl.system.environment_variable.cpp

..\..\bin\test.component.winstl.system.system_directory.cw8.exe:	.\test.component.winstl.system.system_directory.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.system.system_directory.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.system.system_directory.obj:	..\..\test\component\winstl\system\test.component.winstl.system.system_directory\test.component.winstl.system.system_directory.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.system_directory\test.component.winstl.system.system_directory.cpp

..\..\bin\test.component.winstl.system.temporary_directory.cw8.exe:	.\test.component.winstl.system.temporary_directory.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.system.temporary_directory.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.system.temporary_directory.obj:	..\..\test\component\winstl\system\test.component.winstl.system.temporary_directory\test.component.winstl.system.temporary_directory.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.temporary_directory\test.component.winstl.system.temporary_directory.cpp

..\..\bin\test.component.winstl.system.windows_directory.cw8.exe:	.\test.component.winstl.system.windows_directory.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.component.winstl.system.windows_directory.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.component.winstl.system.windows_directory.obj:	..\..\test\component\winstl\system\test.component.winstl.system.windows_directory\test.component.winstl.system.windows_directory.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\component\winstl\system\test.component.winstl.system.windows_directory\test.component.winstl.system.windows_directory.cpp

..\..\bin\mmap.cw8.exe:	.\mmap.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\mmap.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\mmap.obj:	..\..\test\scratch\winstl\filesystem\mmap\mmap.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\winstl\filesystem\mmap\mmap.cpp

..\..\bin\test.scratch.winstl.performance.threadtimes_counter.cw8.exe:	.\test.scratch.winstl.performance.threadtimes_counter.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.scratch.winstl.performance.threadtimes_counter.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.scratch.winstl.performance.threadtimes_counter.obj:	..\..\test\scratch\winstl\performance\test.scratch.winstl.performance.threadtimes_counter\test.scratch.winstl.performance.threadtimes_counter.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\scratch\winstl\performance\test.scratch.winstl.performance.threadtimes_counter\test.scratch.winstl.performance.threadtimes_counter.cpp

..\..\bin\test.unit.winstl.filesystem.filesystem_traits.1.cw8.exe:	.\test.unit.winstl.filesystem.filesystem_traits.1.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.filesystem.filesystem_traits.1.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.filesystem.filesystem_traits.1.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.1\test.unit.winstl.filesystem.filesystem_traits.1.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.1\test.unit.winstl.filesystem.filesystem_traits.1.cpp

..\..\bin\test.unit.winstl.filesystem.filesystem_traits.2.cw8.exe:	.\test.unit.winstl.filesystem.filesystem_traits.2.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.filesystem.filesystem_traits.2.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.filesystem.filesystem_traits.2.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.2\test.unit.winstl.filesystem.filesystem_traits.2.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.filesystem_traits.2\test.unit.winstl.filesystem.filesystem_traits.2.cpp

..\..\bin\test.unit.winstl.filesystem.findvolume_sequence.cw8.exe:	.\test.unit.winstl.filesystem.findvolume_sequence.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.filesystem.findvolume_sequence.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.filesystem.findvolume_sequence.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.findvolume_sequence\test.unit.winstl.filesystem.findvolume_sequence.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.findvolume_sequence\test.unit.winstl.filesystem.findvolume_sequence.cpp

..\..\bin\test.unit.winstl.filesystem.memory_mapped_file.cw8.exe:	.\test.unit.winstl.filesystem.memory_mapped_file.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.filesystem.memory_mapped_file.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.filesystem.memory_mapped_file.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.memory_mapped_file\test.unit.winstl.filesystem.memory_mapped_file.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.memory_mapped_file\test.unit.winstl.filesystem.memory_mapped_file.cpp

..\..\bin\test.unit.winstl.filesystem.path.cw8.exe:	.\test.unit.winstl.filesystem.path.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.filesystem.path.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.filesystem.path.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path\test.unit.winstl.filesystem.path.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path\test.unit.winstl.filesystem.path.cpp

..\..\bin\test.unit.winstl.filesystem.path_functions.cw8.exe:	.\test.unit.winstl.filesystem.path_functions.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.filesystem.path_functions.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.filesystem.path_functions.obj:	..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path_functions\test.unit.winstl.filesystem.path_functions.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\filesystem\test.unit.winstl.filesystem.path_functions\test.unit.winstl.filesystem.path_functions.cpp

..\..\bin\test.unit.winstl.registry.reg_delete_tree.cw8.exe:	.\test.unit.winstl.registry.reg_delete_tree.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.registry.reg_delete_tree.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.registry.reg_delete_tree.obj:	..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_delete_tree\test.unit.winstl.registry.reg_delete_tree.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_delete_tree\test.unit.winstl.registry.reg_delete_tree.cpp

..\..\bin\test.unit.winstl.registry.reg_value.cw8.exe:	.\test.unit.winstl.registry.reg_value.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.registry.reg_value.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.registry.reg_value.obj:	..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_value\test.unit.winstl.registry.reg_value.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\registry\test.unit.winstl.registry.reg_value\test.unit.winstl.registry.reg_value.cpp

..\..\bin\test.unit.winstl.synch.w4mo.cw8.exe:	.\test.unit.winstl.synch.w4mo.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.synch.w4mo.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.synch.w4mo.obj:	..\..\test\unit\winstl\synch\test.unit.winstl.synch.w4mo\test.unit.winstl.synch.w4mo.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\synch\test.unit.winstl.synch.w4mo\test.unit.winstl.synch.w4mo.cpp

..\..\bin\test.unit.winstl.system.commandline_parser.cw8.exe:	.\test.unit.winstl.system.commandline_parser.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.system.commandline_parser.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.system.commandline_parser.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.commandline_parser\test.unit.winstl.system.commandline_parser.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.commandline_parser\test.unit.winstl.system.commandline_parser.cpp

..\..\bin\test.unit.winstl.system.searchpath_sequence.cw8.exe:	.\test.unit.winstl.system.searchpath_sequence.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.system.searchpath_sequence.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.system.searchpath_sequence.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.searchpath_sequence\test.unit.winstl.system.searchpath_sequence.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.searchpath_sequence\test.unit.winstl.system.searchpath_sequence.cpp

..\..\bin\test.unit.winstl.system.system_traits.1.cw8.exe:	.\test.unit.winstl.system.system_traits.1.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.system.system_traits.1.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.system.system_traits.1.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.1\test.unit.winstl.system.system_traits.1.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.1\test.unit.winstl.system.system_traits.1.cpp

..\..\bin\test.unit.winstl.system.system_traits.2.cw8.exe:	.\test.unit.winstl.system.system_traits.2.obj
	mwld  -l $(LIB_XTESTS)    -o $@  .\test.unit.winstl.system.system_traits.2.obj   -lxtests.0.core.cw8.mt.lib   -ladvapi32.lib -lkernel32.lib -luser32.lib  -lole32.lib -loleaut32.lib -lshlwapi.lib -luuid.lib
.\test.unit.winstl.system.system_traits.2.obj:	..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.2\test.unit.winstl.system.system_traits.2.cpp
	mwcc -c  -runtime sm -DWIN32   -opt speed -Cpp_exceptions on -RTTI on -warn all -warn nopadding -warn nonotused -warn nonotinlined -warn nounusedexpr -warn noptrintconv -warn nopedantic -warn noimplicit  -warn error -gccinc $(STLSOFT_INCLUDES)  -I$(INCL_XTESTS)  -o $@ ..\..\test\unit\winstl\system\test.unit.winstl.system.system_traits.2\test.unit.winstl.system.system_traits.2.cpp

############################################################################
