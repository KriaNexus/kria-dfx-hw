extern int writeBuff(u32* buff, int counts, UINTPTR address);
extern int readBuff(u32* buff, int counts, UINTPTR address);
extern int printBuff(int counts, UINTPTR address);
extern int zeroBuff(int counts, UINTPTR address);
//extern int compare(int counts, UINTPTR address0, u32* reference);
extern compare(int counts, UINTPTR address, UINTPTR refaddress);
