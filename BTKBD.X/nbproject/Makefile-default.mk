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
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=sbxbt_hid_ms910/btstack/btstack_memory.c sbxbt_hid_ms910/btstack/hci.c sbxbt_hid_ms910/btstack/hci_cmds.c sbxbt_hid_ms910/btstack/hci_dump.c sbxbt_hid_ms910/btstack/hci_transport_picusb.c sbxbt_hid_ms910/btstack/l2cap.c sbxbt_hid_ms910/btstack/l2cap_signaling.c sbxbt_hid_ms910/btstack/linked_list.c sbxbt_hid_ms910/btstack/memory_pool.c sbxbt_hid_ms910/btstack/remote_device_db_memory.c sbxbt_hid_ms910/btstack/rfcomm.c sbxbt_hid_ms910/btstack/run_loop.c sbxbt_hid_ms910/btstack/run_loop_embedded.c sbxbt_hid_ms910/btstack/sdp.c sbxbt_hid_ms910/btstack/sdp_util.c sbxbt_hid_ms910/btstack/utils.c sbxbt_hid_ms910/Common/uart2.c sbxbt_hid_ms910/Common/uart1.c sbxbt_hid_ms910/USB/usb_host.c sbxbt_hid_ms910/USB/usb_host_bluetooth.c sbxbt_hid_ms910/main.c sbxbt_hid_ms910/usb_config.c sbxbt_hid_ms910/xprintf.c sbxbt_hid_ms910/flash.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o ${OBJECTDIR}/sbxbt_hid_ms910/main.o ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o ${OBJECTDIR}/sbxbt_hid_ms910/flash.o
POSSIBLE_DEPFILES=${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o.d ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o.d ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o.d ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o.d ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o.d ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o.d ${OBJECTDIR}/sbxbt_hid_ms910/main.o.d ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o.d ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o.d ${OBJECTDIR}/sbxbt_hid_ms910/flash.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o ${OBJECTDIR}/sbxbt_hid_ms910/main.o ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o ${OBJECTDIR}/sbxbt_hid_ms910/flash.o

# Source Files
SOURCEFILES=sbxbt_hid_ms910/btstack/btstack_memory.c sbxbt_hid_ms910/btstack/hci.c sbxbt_hid_ms910/btstack/hci_cmds.c sbxbt_hid_ms910/btstack/hci_dump.c sbxbt_hid_ms910/btstack/hci_transport_picusb.c sbxbt_hid_ms910/btstack/l2cap.c sbxbt_hid_ms910/btstack/l2cap_signaling.c sbxbt_hid_ms910/btstack/linked_list.c sbxbt_hid_ms910/btstack/memory_pool.c sbxbt_hid_ms910/btstack/remote_device_db_memory.c sbxbt_hid_ms910/btstack/rfcomm.c sbxbt_hid_ms910/btstack/run_loop.c sbxbt_hid_ms910/btstack/run_loop_embedded.c sbxbt_hid_ms910/btstack/sdp.c sbxbt_hid_ms910/btstack/sdp_util.c sbxbt_hid_ms910/btstack/utils.c sbxbt_hid_ms910/Common/uart2.c sbxbt_hid_ms910/Common/uart1.c sbxbt_hid_ms910/USB/usb_host.c sbxbt_hid_ms910/USB/usb_host_bluetooth.c sbxbt_hid_ms910/main.c sbxbt_hid_ms910/usb_config.c sbxbt_hid_ms910/xprintf.c sbxbt_hid_ms910/flash.c


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
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=24FJ64GB004
MP_LINKER_FILE_OPTION=,--script=p24FJ64GB004.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o: sbxbt_hid_ms910/btstack/btstack_memory.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/btstack_memory.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o: sbxbt_hid_ms910/btstack/hci.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o: sbxbt_hid_ms910/btstack/hci_cmds.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci_cmds.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o: sbxbt_hid_ms910/btstack/hci_dump.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci_dump.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o: sbxbt_hid_ms910/btstack/hci_transport_picusb.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci_transport_picusb.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o: sbxbt_hid_ms910/btstack/l2cap.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/l2cap.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o: sbxbt_hid_ms910/btstack/l2cap_signaling.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/l2cap_signaling.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o: sbxbt_hid_ms910/btstack/linked_list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/linked_list.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o: sbxbt_hid_ms910/btstack/memory_pool.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/memory_pool.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o: sbxbt_hid_ms910/btstack/remote_device_db_memory.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/remote_device_db_memory.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o: sbxbt_hid_ms910/btstack/rfcomm.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/rfcomm.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o: sbxbt_hid_ms910/btstack/run_loop.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/run_loop.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o: sbxbt_hid_ms910/btstack/run_loop_embedded.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/run_loop_embedded.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o: sbxbt_hid_ms910/btstack/sdp.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/sdp.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o: sbxbt_hid_ms910/btstack/sdp_util.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/sdp_util.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o: sbxbt_hid_ms910/btstack/utils.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/utils.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o: sbxbt_hid_ms910/Common/uart2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/Common" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/Common/uart2.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o: sbxbt_hid_ms910/Common/uart1.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/Common" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/Common/uart1.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o: sbxbt_hid_ms910/USB/usb_host.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/USB" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/USB/usb_host.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o: sbxbt_hid_ms910/USB/usb_host_bluetooth.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/USB" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/USB/usb_host_bluetooth.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/main.o: sbxbt_hid_ms910/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/main.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/main.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/main.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O0 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/main.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o: sbxbt_hid_ms910/usb_config.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/usb_config.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o: sbxbt_hid_ms910/xprintf.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/xprintf.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/flash.o: sbxbt_hid_ms910/flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/flash.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/flash.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/flash.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1    -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/flash.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o: sbxbt_hid_ms910/btstack/btstack_memory.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/btstack_memory.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/btstack_memory.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o: sbxbt_hid_ms910/btstack/hci.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o: sbxbt_hid_ms910/btstack/hci_cmds.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci_cmds.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_cmds.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o: sbxbt_hid_ms910/btstack/hci_dump.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci_dump.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_dump.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o: sbxbt_hid_ms910/btstack/hci_transport_picusb.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/hci_transport_picusb.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/hci_transport_picusb.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o: sbxbt_hid_ms910/btstack/l2cap.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/l2cap.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o: sbxbt_hid_ms910/btstack/l2cap_signaling.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/l2cap_signaling.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/l2cap_signaling.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o: sbxbt_hid_ms910/btstack/linked_list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/linked_list.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/linked_list.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o: sbxbt_hid_ms910/btstack/memory_pool.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/memory_pool.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/memory_pool.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o: sbxbt_hid_ms910/btstack/remote_device_db_memory.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/remote_device_db_memory.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/remote_device_db_memory.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o: sbxbt_hid_ms910/btstack/rfcomm.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/rfcomm.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/rfcomm.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o: sbxbt_hid_ms910/btstack/run_loop.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/run_loop.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o: sbxbt_hid_ms910/btstack/run_loop_embedded.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/run_loop_embedded.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/run_loop_embedded.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o: sbxbt_hid_ms910/btstack/sdp.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/sdp.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o: sbxbt_hid_ms910/btstack/sdp_util.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/sdp_util.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/sdp_util.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o: sbxbt_hid_ms910/btstack/utils.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/btstack" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/btstack/utils.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/btstack/utils.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o: sbxbt_hid_ms910/Common/uart2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/Common" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/Common/uart2.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart2.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o: sbxbt_hid_ms910/Common/uart1.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/Common" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/Common/uart1.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/Common/uart1.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o: sbxbt_hid_ms910/USB/usb_host.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/USB" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/USB/usb_host.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o: sbxbt_hid_ms910/USB/usb_host_bluetooth.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910/USB" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/USB/usb_host_bluetooth.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/USB/usb_host_bluetooth.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/main.o: sbxbt_hid_ms910/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/main.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/main.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/main.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O0 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/main.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o: sbxbt_hid_ms910/usb_config.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/usb_config.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/usb_config.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o: sbxbt_hid_ms910/xprintf.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/xprintf.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/xprintf.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/sbxbt_hid_ms910/flash.o: sbxbt_hid_ms910/flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/sbxbt_hid_ms910" 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/flash.o.d 
	@${RM} ${OBJECTDIR}/sbxbt_hid_ms910/flash.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  sbxbt_hid_ms910/flash.c  -o ${OBJECTDIR}/sbxbt_hid_ms910/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/sbxbt_hid_ms910/flash.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -O1 -I"sbxbt_hid_ms910" -I"sbxbt_hid_ms910/Common" -I"sbxbt_hid_ms910/USB" -I"sbxbt_hid_ms910/btstack" -I"sbxbt_hid_ms910/fatfs" -I"." -msmart-io=1 -Wall -msfr-warn=off  
	@${FIXDEPS} "${OBJECTDIR}/sbxbt_hid_ms910/flash.o.d" $(SILENT)  -rsi ${MP_CC_DIR}../ 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)   -mreserve=data@0x800:0x81F -mreserve=data@0x820:0x821 -mreserve=data@0x822:0x823 -mreserve=data@0x824:0x825 -mreserve=data@0x826:0x84F   -Wl,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--heap=2048,--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--gc-sections,--fill-upper=0,--stackguard=16,--library-path="sbxbt_hid_ms910",--library-path=".",--no-force-link,--smart-io,-Map="${DISTDIR}/BTKBD.X.${IMAGE_TYPE}.map",--report-mem,--cref,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST) 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -Wl,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--heap=2048,--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--gc-sections,--fill-upper=0,--stackguard=16,--library-path="sbxbt_hid_ms910",--library-path=".",--no-force-link,--smart-io,-Map="${DISTDIR}/BTKBD.X.${IMAGE_TYPE}.map",--report-mem,--cref,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST) 
	${MP_CC_DIR}/xc16-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/BTKBD.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf  
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
