#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Sudoku-Final.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Sudoku-Final.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=config.asm KeyPad.asm GLCD.asm Write_Cells.asm Main.asm Draw_Grid.asm Sudoku_Logic.asm Board_Validation.asm Write_Message.asm Sudoku_Setup.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/config.o ${OBJECTDIR}/KeyPad.o ${OBJECTDIR}/GLCD.o ${OBJECTDIR}/Write_Cells.o ${OBJECTDIR}/Main.o ${OBJECTDIR}/Draw_Grid.o ${OBJECTDIR}/Sudoku_Logic.o ${OBJECTDIR}/Board_Validation.o ${OBJECTDIR}/Write_Message.o ${OBJECTDIR}/Sudoku_Setup.o
POSSIBLE_DEPFILES=${OBJECTDIR}/config.o.d ${OBJECTDIR}/KeyPad.o.d ${OBJECTDIR}/GLCD.o.d ${OBJECTDIR}/Write_Cells.o.d ${OBJECTDIR}/Main.o.d ${OBJECTDIR}/Draw_Grid.o.d ${OBJECTDIR}/Sudoku_Logic.o.d ${OBJECTDIR}/Board_Validation.o.d ${OBJECTDIR}/Write_Message.o.d ${OBJECTDIR}/Sudoku_Setup.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/config.o ${OBJECTDIR}/KeyPad.o ${OBJECTDIR}/GLCD.o ${OBJECTDIR}/Write_Cells.o ${OBJECTDIR}/Main.o ${OBJECTDIR}/Draw_Grid.o ${OBJECTDIR}/Sudoku_Logic.o ${OBJECTDIR}/Board_Validation.o ${OBJECTDIR}/Write_Message.o ${OBJECTDIR}/Sudoku_Setup.o

# Source Files
SOURCEFILES=config.asm KeyPad.asm GLCD.asm Write_Cells.asm Main.asm Draw_Grid.asm Sudoku_Logic.asm Board_Validation.asm Write_Message.asm Sudoku_Setup.asm



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/Sudoku-Final.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18f87k22
MP_LINKER_DEBUG_OPTION= 
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/config.o: config.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/config.o.d 
	@${RM} ${OBJECTDIR}/config.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/config.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/config.lst\" -e\"${OBJECTDIR}/config.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/config.o\" \"config.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/config.o"
	@${FIXDEPS} "${OBJECTDIR}/config.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/KeyPad.o: KeyPad.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/KeyPad.o.d 
	@${RM} ${OBJECTDIR}/KeyPad.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/KeyPad.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/KeyPad.lst\" -e\"${OBJECTDIR}/KeyPad.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/KeyPad.o\" \"KeyPad.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/KeyPad.o"
	@${FIXDEPS} "${OBJECTDIR}/KeyPad.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/GLCD.o: GLCD.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/GLCD.o.d 
	@${RM} ${OBJECTDIR}/GLCD.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/GLCD.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/GLCD.lst\" -e\"${OBJECTDIR}/GLCD.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/GLCD.o\" \"GLCD.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/GLCD.o"
	@${FIXDEPS} "${OBJECTDIR}/GLCD.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Write_Cells.o: Write_Cells.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Write_Cells.o.d 
	@${RM} ${OBJECTDIR}/Write_Cells.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Write_Cells.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Write_Cells.lst\" -e\"${OBJECTDIR}/Write_Cells.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Write_Cells.o\" \"Write_Cells.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Write_Cells.o"
	@${FIXDEPS} "${OBJECTDIR}/Write_Cells.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Main.o: Main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Main.o.d 
	@${RM} ${OBJECTDIR}/Main.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Main.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Main.lst\" -e\"${OBJECTDIR}/Main.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Main.o\" \"Main.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Main.o"
	@${FIXDEPS} "${OBJECTDIR}/Main.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Draw_Grid.o: Draw_Grid.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Draw_Grid.o.d 
	@${RM} ${OBJECTDIR}/Draw_Grid.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Draw_Grid.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Draw_Grid.lst\" -e\"${OBJECTDIR}/Draw_Grid.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Draw_Grid.o\" \"Draw_Grid.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Draw_Grid.o"
	@${FIXDEPS} "${OBJECTDIR}/Draw_Grid.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Sudoku_Logic.o: Sudoku_Logic.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Sudoku_Logic.o.d 
	@${RM} ${OBJECTDIR}/Sudoku_Logic.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Sudoku_Logic.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Sudoku_Logic.lst\" -e\"${OBJECTDIR}/Sudoku_Logic.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Sudoku_Logic.o\" \"Sudoku_Logic.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Sudoku_Logic.o"
	@${FIXDEPS} "${OBJECTDIR}/Sudoku_Logic.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Board_Validation.o: Board_Validation.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Board_Validation.o.d 
	@${RM} ${OBJECTDIR}/Board_Validation.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Board_Validation.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Board_Validation.lst\" -e\"${OBJECTDIR}/Board_Validation.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Board_Validation.o\" \"Board_Validation.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Board_Validation.o"
	@${FIXDEPS} "${OBJECTDIR}/Board_Validation.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Write_Message.o: Write_Message.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Write_Message.o.d 
	@${RM} ${OBJECTDIR}/Write_Message.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Write_Message.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Write_Message.lst\" -e\"${OBJECTDIR}/Write_Message.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Write_Message.o\" \"Write_Message.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Write_Message.o"
	@${FIXDEPS} "${OBJECTDIR}/Write_Message.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Sudoku_Setup.o: Sudoku_Setup.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Sudoku_Setup.o.d 
	@${RM} ${OBJECTDIR}/Sudoku_Setup.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Sudoku_Setup.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_ICD3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Sudoku_Setup.lst\" -e\"${OBJECTDIR}/Sudoku_Setup.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Sudoku_Setup.o\" \"Sudoku_Setup.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Sudoku_Setup.o"
	@${FIXDEPS} "${OBJECTDIR}/Sudoku_Setup.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/config.o: config.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/config.o.d 
	@${RM} ${OBJECTDIR}/config.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/config.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/config.lst\" -e\"${OBJECTDIR}/config.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/config.o\" \"config.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/config.o"
	@${FIXDEPS} "${OBJECTDIR}/config.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/KeyPad.o: KeyPad.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/KeyPad.o.d 
	@${RM} ${OBJECTDIR}/KeyPad.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/KeyPad.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/KeyPad.lst\" -e\"${OBJECTDIR}/KeyPad.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/KeyPad.o\" \"KeyPad.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/KeyPad.o"
	@${FIXDEPS} "${OBJECTDIR}/KeyPad.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/GLCD.o: GLCD.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/GLCD.o.d 
	@${RM} ${OBJECTDIR}/GLCD.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/GLCD.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/GLCD.lst\" -e\"${OBJECTDIR}/GLCD.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/GLCD.o\" \"GLCD.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/GLCD.o"
	@${FIXDEPS} "${OBJECTDIR}/GLCD.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Write_Cells.o: Write_Cells.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Write_Cells.o.d 
	@${RM} ${OBJECTDIR}/Write_Cells.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Write_Cells.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Write_Cells.lst\" -e\"${OBJECTDIR}/Write_Cells.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Write_Cells.o\" \"Write_Cells.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Write_Cells.o"
	@${FIXDEPS} "${OBJECTDIR}/Write_Cells.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Main.o: Main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Main.o.d 
	@${RM} ${OBJECTDIR}/Main.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Main.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Main.lst\" -e\"${OBJECTDIR}/Main.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Main.o\" \"Main.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Main.o"
	@${FIXDEPS} "${OBJECTDIR}/Main.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Draw_Grid.o: Draw_Grid.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Draw_Grid.o.d 
	@${RM} ${OBJECTDIR}/Draw_Grid.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Draw_Grid.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Draw_Grid.lst\" -e\"${OBJECTDIR}/Draw_Grid.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Draw_Grid.o\" \"Draw_Grid.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Draw_Grid.o"
	@${FIXDEPS} "${OBJECTDIR}/Draw_Grid.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Sudoku_Logic.o: Sudoku_Logic.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Sudoku_Logic.o.d 
	@${RM} ${OBJECTDIR}/Sudoku_Logic.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Sudoku_Logic.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Sudoku_Logic.lst\" -e\"${OBJECTDIR}/Sudoku_Logic.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Sudoku_Logic.o\" \"Sudoku_Logic.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Sudoku_Logic.o"
	@${FIXDEPS} "${OBJECTDIR}/Sudoku_Logic.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Board_Validation.o: Board_Validation.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Board_Validation.o.d 
	@${RM} ${OBJECTDIR}/Board_Validation.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Board_Validation.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Board_Validation.lst\" -e\"${OBJECTDIR}/Board_Validation.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Board_Validation.o\" \"Board_Validation.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Board_Validation.o"
	@${FIXDEPS} "${OBJECTDIR}/Board_Validation.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Write_Message.o: Write_Message.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Write_Message.o.d 
	@${RM} ${OBJECTDIR}/Write_Message.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Write_Message.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Write_Message.lst\" -e\"${OBJECTDIR}/Write_Message.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Write_Message.o\" \"Write_Message.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Write_Message.o"
	@${FIXDEPS} "${OBJECTDIR}/Write_Message.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/Sudoku_Setup.o: Sudoku_Setup.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Sudoku_Setup.o.d 
	@${RM} ${OBJECTDIR}/Sudoku_Setup.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Sudoku_Setup.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Sudoku_Setup.lst\" -e\"${OBJECTDIR}/Sudoku_Setup.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Sudoku_Setup.o\" \"Sudoku_Setup.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Sudoku_Setup.o"
	@${FIXDEPS} "${OBJECTDIR}/Sudoku_Setup.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/Sudoku-Final.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_ICD3=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/Sudoku-Final.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/Sudoku-Final.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w  -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/Sudoku-Final.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default
