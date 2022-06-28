// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xpp_pipeline_accel.h"

extern XPp_pipeline_accel_Config XPp_pipeline_accel_ConfigTable[];

XPp_pipeline_accel_Config *XPp_pipeline_accel_LookupConfig(u16 DeviceId) {
	XPp_pipeline_accel_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XPP_PIPELINE_ACCEL_NUM_INSTANCES; Index++) {
		if (XPp_pipeline_accel_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XPp_pipeline_accel_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XPp_pipeline_accel_Initialize(XPp_pipeline_accel *InstancePtr, u16 DeviceId) {
	XPp_pipeline_accel_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XPp_pipeline_accel_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XPp_pipeline_accel_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

