#include "btstack/debug.h"
#include "btstack/linked_list.h"
#include "btstack/remote_device_db.h"

#if	!USE_WRITE_STORED_LINK_KEY
#define SECTOR_START 0x00a400
#define	ROW_SIZE	128
#define	REC_MAX		7

extern linked_list_t db_mem_link_keys;

void    erase_flashmem(unsigned long progAddr)
{
    unsigned int offset;

    TBLPAG = progAddr>>16;
    offset = progAddr & 0xFFFF;
    __builtin_tblwtl(offset, 0);
    NVMCON = 0x4042;
    asm volatile("DISI #5");
    __builtin_write_NVM();
    while(NVMCONbits.WR);
}

void prog_flashmem_row2(unsigned long progAddr,BYTE* progData1,size_t len1,BYTE* progData2,size_t len2)
{
    unsigned int offset;
    WORD    i,w;
    NVMCON = 0x4001;
    TBLPAG = progAddr>>16;
    offset = progAddr & 0xFFFF;

	for(i=0;i<len1;i+=2)
	{
		w=(progData1[i+1]<<8) | (progData1[i]);
		__builtin_tblwtl(offset,w);
		__builtin_tblwth(offset,0);
		offset = offset + 2;
	}
	for(i=0;i<len2;i+=2)
	{
		w=(progData2[i+1]<<8) | (progData2[i]);
		__builtin_tblwtl(offset,w);
		__builtin_tblwth(offset,0);
		offset = offset + 2;
	}
	w=ROW_SIZE-(len1+len2);
	for(i=0;i<w;i+=2){
		__builtin_tblwtl(offset,0);
		__builtin_tblwth(offset,0);
		offset = offset + 2;
	}
	asm volatile("DISI #5");
	__builtin_write_NVM();
	while(NVMCONbits.WR);
}

void read_flashmem(unsigned long progAddr,BYTE* progData,size_t len)
{
    unsigned int offset;
    unsigned int i;
    WORD    w;
    TBLPAG = progAddr>>16;
    offset = progAddr & 0xFFFF;
    for(i=0;i<len;i+=2){
        w = __builtin_tblrdl(offset);
        progData[i]=w&0xff;
        progData[i+1]=w>>8;
		offset+=2;
    }
}

void save_link_keys(linked_list_t list)
{
	WORD	num=0;
    unsigned long sec=SECTOR_START;

    erase_flashmem(sec);
    sec+=ROW_SIZE;

	linked_item_t *it;
    for (it = (linked_item_t *) list; it && num<REC_MAX ; it = it->next){
        db_mem_device_link_key_t * item = (db_mem_device_link_key_t *) it;
		prog_flashmem_row2(sec,((BYTE *)&item->device.bd_addr),BD_ADDR_LEN,((BYTE *)item->link_key),LINK_KEY_LEN);
		sec+=ROW_SIZE;
		num++;
    }
	prog_flashmem_row2(SECTOR_START,(BYTE*)&num,sizeof(num),NULL,0);
	log_info("save_link_keys: %u keys\r\n",num);
}

extern bd_addr_t	reader_bdaddr;

int load_link_keys(remote_device_db_t * lpremote_device_db)
{
	int	num;
	unsigned int	num_max;
    unsigned long sec=SECTOR_START;
	db_mem_device_link_key_t item;

    read_flashmem(sec,(BYTE*)&num_max,sizeof(num_max));
    if(num_max>REC_MAX){
        //error
		log_info("load_link_keys: invalid num_max:%u\r\n",num_max);
        return 0;
    }
	sec+=ROW_SIZE;
	for(num=0;num<num_max;num++){
        read_flashmem(sec+0,((BYTE *)&item.device.bd_addr),BD_ADDR_LEN);
        read_flashmem(sec+BD_ADDR_LEN,((BYTE *)item.link_key),LINK_KEY_LEN);
memcpy(reader_bdaddr,&item.device.bd_addr,BD_ADDR_LEN);
		lpremote_device_db->put_link_key(&item.device.bd_addr, &item.link_key);
		sec+=ROW_SIZE;
	}
	log_info("load_link_keys: %u keys\r\n",num);
	return num;
}

void print_link_keys(linked_list_t list)
{
#if	__DEBUG
    linked_item_t *it;
    for (it = (linked_item_t *) list; it ; it = it->next){
        db_mem_device_link_key_t * item = (db_mem_device_link_key_t *) it;

		log_info("bd-addr:%s  key:%02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x\n"
			,bd_addr_to_str(item->device.bd_addr)
			,item->link_key[0]
			,item->link_key[1]
			,item->link_key[2]
			,item->link_key[3]
			,item->link_key[4]
			,item->link_key[5]
			,item->link_key[6]
			,item->link_key[7]
			,item->link_key[8]
			,item->link_key[9]
			,item->link_key[10]
			,item->link_key[11]
			,item->link_key[12]
			,item->link_key[13]
			,item->link_key[14]
			,item->link_key[15]
		);
	}
#endif
}
#endif
