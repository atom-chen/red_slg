CPP_SRCS += \
	${SRC_DIR}/src/time/date_time.cpp \
	${SRC_DIR}/src/time/interval_timer.cpp \
	${SRC_DIR}/src/time/timespan.cpp

OBJS += \
	${OBJ_DIR}/src/time/date_time.o \
	${OBJ_DIR}/src/time/interval_timer.o \
	${OBJ_DIR}/src/time/timespan.o

CPP_DEPS += \
	${DEP_DIR}/src/time/date_time.d \
	${DEP_DIR}/src/time/interval_timer.d \
	${DEP_DIR}/src/time/timespan.d

src_time: ${OBJS}
	
# Each subdirectory must supply rules for building sources it contributes
${OBJ_DIR}/src/time/%.o: ${SRC_DIR}/src/time/%.cpp
	@echo 'Building file: $<'
	${CC} ${CC_DEF} ${CC_INC} ${CC_OPT} ${CC_FLAG} -MF"$(@:${OBJ_DIR}/src/time/%.o=${DEP_DIR}/src/time/%.d)" \
		-MT"$(@:${OBJ_DIR}/src/time/%.o=${DEP_DIR}/src/time/%.d)" -o "$@" "$<" ${CC_IGO}
	@echo 'Finished building: $<'
	@echo ' '
