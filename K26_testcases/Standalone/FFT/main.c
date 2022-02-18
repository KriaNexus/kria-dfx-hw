/******************************************************************************
* Copyright (C) 2010 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include "xil_io.h"
#include "xil_exception.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_types.h"

#include "isolation.h"
#include "utils.h"
#include "map.h"
#include "platform.h"
#include "dmDriver.h"

u64 INDATAADDRESS[2]  = {0x02000000, 0x04000000};
u64 OUTDATAADDRESS[2]  = {0x08000000, 0x0A000000};
u64 CONFIGADDRESS[2] = {0x0E000000, 0x10000000};

u32 config[] = {0x0000000c,0x0000000c,0x0000000c,0x0000000c};

void configFFT(int slot,u64 addr){
	/*Configuring Data movers and Triggering them*/
	MM2SData(slot, addr, 0x10, 0x01);
	while(1){
		if(MM2SDone(slot)){
			break;
		}
	}
	MM2SData(slot, addr, 0x10, 0x02);
	while(1){
		if(MM2SDone(slot)){
			break;
		}
	}
	MM2SData(slot, addr, 0x10, 0x03);
	while(1){
		if(MM2SDone(slot)){
			break;
		}
	}
	MM2SData(slot, addr, 0x10, 0x04);
	while(1){
		if(MM2SDone(slot)){
			xil_printf("FFT Config Done !\n");
			break;
		}
	}
}

void trigger_DMA(int slot, u64 INDATAADDRESS,int insize, u64 OUTDATAADDRESS, int outsize){
	S2MMData(slot, OUTDATAADDRESS, outsize);
	MM2SData(slot, INDATAADDRESS, insize, 0x00);
}

void wait_DMA(int slot){
	while(1){
		if(S2MMDone(slot)){
			break;
		}
	}
}

uint64_t SLOT_MEM_ADDR[2] = {0x200000000, 0x280000000};


int main(void){
	int interRM_en=0;

	init_platform();
	Xil_ICacheDisable();
	Xil_DCacheDisable();

	configSihaBase(SHELLCONFIG_BASE);
	configDMSlots(DMA_HLS_0_BASE, DMA_HLS_1_BASE);

	enableSlot(0);
	enableSlot(1);

	printf("Slots enabled !!\n");

	writeBuff(config, 0x10, CONFIGADDRESS[0]);
	configFFT(0, CONFIGADDRESS[0]);
	configFFT(1, CONFIGADDRESS[0]);

	printf("Config done !!\n");
	trigger_DMA(0, INDATAADDRESS[0],0x200000,OUTDATAADDRESS[0],0x200000);
	wait_DMA(0);
	printf("slot 0 done !!\n");
	trigger_DMA(1, INDATAADDRESS[0],0x200000,OUTDATAADDRESS[1],0x200000);
	wait_DMA(1);
	printf("slot 1 done !!\n");


	printf("comparing slot 0 output with reference ...\n");
	compare(0x200000, OUTDATAADDRESS[0], INDATAADDRESS[1]);

	printf("comparing slot 1 output with reference ...\n");
	compare(0x200000, OUTDATAADDRESS[1], INDATAADDRESS[1]);

	//printBuff(0x100, OUTDATAADDRESS[0]);
	//printBuff(0x100, OUTDATAADDRESS[1]);

	printf("all done \n");
    cleanup_platform();
	return XST_SUCCESS;
}

