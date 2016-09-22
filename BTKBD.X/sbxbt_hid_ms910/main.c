#include <stdlib.h>
#define USE_AND_OR /* To enable AND_OR mask setting */
#include<ports.h>
#include<pps.h>
#include<timer.h>
#include<outcompare.h>
//#include "global.h"
#include "btstack/debug.h"
#include "btstack/btstack.h"
#include <btstack/hci_cmds.h>
#include <btstack/run_loop.h>
#include <btstack/sdp_util.h>

#include "btstack/hci.h"
#include "btstack/l2cap.h"
#include "btstack/btstack_memory.h"
#include "btstack/remote_device_db.h"
#include "btstack/rfcomm.h"
#include "btstack/sdp.h"
//#include "btstack/config.h"

#define	CREDITS					 10

#define INQUIRY_INTERVAL		 15
static uint8_t		mode_pairing=0;				//1:ペアリングモード
static uint8_t		foundReader=0;
static uint8_t		activeconnect=0;
bd_addr_t	reader_bdaddr;

#define	led1_on_mac()			{led1_on(); led1_on_count=timer_counter; led1_on_state=1;}
static uint16_t		reader_interrupt_channel_id;
static uint16_t		reader_control_channel_id;
static unsigned		timer_counter=0;
static unsigned		led1_on_count=0;
static uint8_t		led1_on_state=0;
char				lineBuffer[32];
static uint8_t		startup_state=0;
#if USE_RSSI
static unsigned		rssi_blink_rate_ms;
#endif

#define KEYCODE_RETURN     '\n'
#define KEYCODE_ESCAPE      27
#define KEYCODE_TAB			'\t'
#define KEYCODE_BACKSPACE   0x7f
#define KEYCODE_ILLEGAL     0xffff
#define KEYCODE_CAPSLOCK    KEYCODE_ILLEGAL

#define MOD_SHIFT 0x22

/**
 * English (US)
 */
static const uint16_t keytable_us_none [] = {
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 0-3 */
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', /*  4 - 13 */
	'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', /* 14 - 23 */
	'u', 'v', 'w', 'x', 'y', 'z',                     /* 24 - 29 */
	'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', /* 30 - 39 */
	KEYCODE_RETURN, KEYCODE_ESCAPE, KEYCODE_BACKSPACE, KEYCODE_TAB, ' ', /* 40 - 44 */
	'-', '=', '[', ']', '\\', KEYCODE_ILLEGAL, ';', '\'', 0x60, ',',      /* 45 - 54 */
	'.', '/', KEYCODE_CAPSLOCK, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL,  /* 55 - 60 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 61-64 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 65-68 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 69-72 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 73-76 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 77-80 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 81-84 */
	'*', '-', '+', '\n', '1', '2', '3', '4', '5',   /* 85-97 */
	'6', '7', '8', '9', '0', '.', 0xa7,             /* 97-100 */
}; 

static const uint16_t keytable_us_shift[] = {
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 0-3 */
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', /*  4 - 13 */
	'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', /* 14 - 23 */
	'U', 'V', 'W', 'X', 'Y', 'Z',                     /* 24 - 29 */
	'!', '@', '#', '$', '%', '^', '&', '*', '(', ')',  /* 30 - 39 */
    KEYCODE_RETURN, KEYCODE_ESCAPE, KEYCODE_BACKSPACE, KEYCODE_TAB, ' ',  /* 40 - 44 */
    '_', '+', '{', '}', '|', KEYCODE_ILLEGAL, ':', '"', 0x7E, '<',         /* 45 - 54 */
    '>', '?', KEYCODE_CAPSLOCK, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL,  /* 55 - 60 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 61-64 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 65-68 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 69-72 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 73-76 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 77-80 */
	KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, KEYCODE_ILLEGAL, /* 81-84 */
	'*', '-', '+', '\n', '1', '2', '3', '4', '5',   /* 85-97 */
	'6', '7', '8', '9', '0', '.', 0xb1,             /* 97-100 */
}; 

// decode hid packet into buffer - return number of valid keys events
#define NUM_KEYS 6
uint8_t last_keyboard_state[NUM_KEYS];
uint16_t input[NUM_KEYS];
static char last_state_init = 0;
uint16_t last_key;
uint16_t last_mod;
uint16_t last_char;
uint8_t  last_key_new;

hci_transport_t * hci_transport_picusb_instance();

#if defined(__PIC24FJ64GB004__)
	_CONFIG1(WDTPS_PS2048 & FWPSA_PR128 & WINDIS_OFF & FWDTENDEF & ICSDEF & GWRP_OFF & GCP_OFF & JTAGEN_OFF)
	_CONFIG2(POSCMOD_NONE & I2C1SEL_PRI & IOL1WAY_OFF & OSCIOFNC_ON & FCKSM_CSDCMD & FNOSC_FRCPLL & PLL96MHZ_ON & PLLDIV_DIV2 & IESO_OFF)
	_CONFIG3(WPFP_WPFP0 & SOSCSEL_IO & WUTSEL_LEG & WPDIS_WPDIS & WPCFG_WPCFGDIS & WPEND_WPENDMEM)
	_CONFIG4(DSWDTPS_DSWDTPS3 & DSWDTOSC_LPRC & RTCOSC_SOSC & DSBOREN_OFF & DSWDTEN_OFF)
#else

    #error Cannot define configuration bits.

#endif

BYTE        deviceAddress;  // Address of the device on the USB
bd_addr_t addr_global;

extern linked_list_t db_mem_link_keys;
void save_link_keys(linked_list_t list);
void print_link_keys(linked_list_t list);


BOOL InitializeSystem ( void )
{
   #if defined(__PIC24FJ64GB004__)
	    {
	        unsigned int pll_startup_counter = 600;
	        CLKDIVbits.PLLEN = 1;
	        while(pll_startup_counter--);
	    }

		AD1PCFG = 0xffff;
	    CLKDIV = 0;    // Set PLL prescaler (1:1)
    #endif

	on_setup();
	led1_setup();
	led1_on();
	led2_setup();
	led2_on();
	u1rx_setup();
	u1tx_setup();
	u1cts_setup();
	u1rts_setup();
	sto_setup();
	assoc_setup();
	pairen_setup();

    // Init UART
    UART1Init(BAUDRATE1);
#if	STO_SERIAL
    UART2Init();
#endif

    return TRUE;
} // InitializeSystem

BOOL USB_ApplicationEventHandler ( BYTE address, USB_EVENT event, void *data, DWORD size )
{
    #ifdef USB_BLUETOOTH_SUPPORT_SERIAL_NUMBERS
        BYTE i;
    #endif

    // Handle specific events.
    switch (event)
    {
        case EVENT_BLUETOOTH_ATTACH:
            if (size == sizeof(BLUETOOTH_DEVICE_ID))
            {
                deviceAddress   = ((BLUETOOTH_DEVICE_ID *)data)->deviceAddress;
                log_info( "Bluetooth device attached - event, deviceAddress=%d\r\n",deviceAddress );
                #ifdef USB_BLUETOOTH_SUPPORT_SERIAL_NUMBERS
                    for (i=1; i<((BLUETOOTH_DEVICE_ID *)data)->serialNumberLength; i++)
                    {
                        log_info("%c", ((BLUETOOTH_DEVICE_ID *)data)->serialNumber[i] );
                    }
	                log_info( "\r\n" );
                #endif
                return TRUE;
            }
            break;

        case EVENT_BLUETOOTH_DETACH:
            deviceAddress   = 0;
            log_info( "Bluetooth device detached - event\r\n" );
            return TRUE;

        case EVENT_BLUETOOTH_TX_CMD_DONE:           // The main state machine will poll the driver.
            return TRUE;

        case EVENT_BLUETOOTH_TX_ACL_DONE:           // The main state machine will poll the driver.
            return TRUE;

        case EVENT_BLUETOOTH_RX_EVENT_DONE:
			if(*(DWORD*)data){
				event_bluetooth_rxEvent_done((WORD)(*(DWORD*)data));
			}
            return TRUE;

        case EVENT_BLUETOOTH_RX_ACL_DONE:
			if(*(DWORD*)data){
				event_bluetooth_rxAcl_done((WORD)(*(DWORD*)data));
			}
            return TRUE;

        case EVENT_VBUS_REQUEST_POWER:
            // We'll let anything attach.
            return TRUE;

        case EVENT_VBUS_RELEASE_POWER:
            // We aren't keeping track of power.
            return TRUE;

        case EVENT_HUB_ATTACH:
            log_info( "\r\n***** USB Error - hubs are not supported *****\r\n" );
            return TRUE;
            break;

        case EVENT_UNSUPPORTED_DEVICE:
            log_info( "\r\n***** USB Error - device is not supported *****\r\n" );
            return TRUE;
            break;

        case EVENT_CANNOT_ENUMERATE:
            log_info( "\r\n***** USB Error - cannot enumerate device *****\r\n" );
            return TRUE;
            break;

        case EVENT_CLIENT_INIT_ERROR:
            log_info( "\r\n***** USB Error - client driver initialization error *****\r\n" );
            return TRUE;
            break;

        case EVENT_OUT_OF_MEMORY:
            log_info( "\r\n***** USB Error - out of heap memory *****\r\n" );
            return TRUE;
            break;

        case EVENT_UNSPECIFIED_ERROR:   // This should never be generated.
            log_info( "\r\n***** USB Error - unspecified *****\r\n" );
            return TRUE;
            break;

        case EVENT_SUSPEND:
        case EVENT_DETACH:
        case EVENT_RESUME:
        case EVENT_BUS_ERROR:
            return TRUE;
            break;

        default:
            break;
    }

    return FALSE;

} // USB_ApplicationEventHandler

typedef unsigned char u_char;
unsigned char hid_process_packet(unsigned char *hid_report, uint16_t *buffer, uint8_t max_keys){
	
	// check for key report
	if (hid_report[0] != 0xa1 || hid_report[1] != 0x01) {
		return 0;
	}
	
	u_char modifier = hid_report[2];
	u_char result = 0;
	u_char i;
	u_char j;
	
	if (!last_state_init)
	{
		for (i=0;i<NUM_KEYS;i++){
			last_keyboard_state[i] = 0;
		}
		last_state_init = 1;
	}
	
	for (i=0; i< NUM_KEYS && result < max_keys; i++){
		// find key in last state
		uint8_t new_event = hid_report[4+i];
		if (new_event){
			for (j=0; j<NUM_KEYS; j++){
				if (new_event == last_keyboard_state[j]){
					new_event = 0;
					break;
				}
			}
			if (!new_event) continue;
			buffer[result++] = new_event;
			last_key  = new_event;
			last_mod  = modifier;
		}
	}
	
	// store keyboard state
	for (i=0;i<NUM_KEYS;i++){
		last_keyboard_state[i] = hid_report[4+i];
	}
	return result;
}

static void l2cap_interrupt_packet_handler(uint8_t packet_type, uint16_t channel, uint8_t *packet, uint16_t size);

static void l2cap_control_packet_handler(uint8_t packet_type, uint16_t channel, uint8_t *packet, uint16_t size)
{
	static int hid_control_init_state=0;

	if (packet_type == HCI_EVENT_PACKET){
		switch(packet[0]){
		case L2CAP_EVENT_INCOMING_CONNECTION:
			log_info("L2CAP_EVENT_INCOMING_CONNECTION\n");
			l2cap_accept_connection_internal(channel);
			activeconnect=0;
			break;
		case L2CAP_EVENT_CHANNEL_OPENED:
	        if (packet[2]) {
	            log_info("control Connection failed\n\r");
	            return;
		    }
			log_info("control Connected\n\r");
			reader_control_channel_id=channel;
			break;
		case L2CAP_EVENT_CHANNEL_CLOSED:
			log_info("L2CAP_CHANNEL_CLOSED\n");
			reader_control_channel_id=0;
			hid_control_init_state=0;
			//init_button_state();
			break;
		case L2CAP_EVENT_CREDITS:
			switch(hid_control_init_state){
			case	0:
				hid_control_init_state++;
				if(activeconnect){
					l2cap_create_channel_internal(NULL, l2cap_interrupt_packet_handler, reader_bdaddr, PSM_HID_INTERRUPT, 150);
				}
				break;
			default:
				break;
			}
			break;
		default:
			log_info("l2cap:unknown(%02x)\n",packet[0]);
			break;
		}	
	}
}

static void l2cap_interrupt_packet_handler(uint8_t packet_type, uint16_t channel, uint8_t *packet, uint16_t size)
{
	static int hid_interrupt_init_state=0;

	if (packet_type == HCI_EVENT_PACKET){
		switch(packet[0]){
		case L2CAP_EVENT_INCOMING_CONNECTION:
			log_info("L2CAP_EVENT_INCOMING_CONNECTION\n");
			l2cap_accept_connection_internal(channel);
			break;
		case L2CAP_EVENT_CHANNEL_OPENED:
	        if (packet[2]) {
	            log_info("interrupt Connection failed\n\r");
	            return;
		    }
			log_info("interrupt Connected\n\r");
			reader_interrupt_channel_id=channel;
			break;
		case L2CAP_EVENT_CHANNEL_CLOSED:
			log_info("L2CAP_CHANNEL_CLOSED\n");
			reader_interrupt_channel_id=0;
			hid_interrupt_init_state=0;
			//init_button_state();
			break;
		case L2CAP_EVENT_CREDITS:
			log_info("L2CAP_EVENT_CREDITS\n\r");
			switch(hid_interrupt_init_state){
			case	0:
				hid_interrupt_init_state++;
				//enable_hid(reader_interrupt_channel_id);
				//l2cap_create_channel_internal(NULL, l2cap_control_packet_handler, reader_bdaddr, PSM_HID_CONTROL, 150);
				break;
			default:
				break;
			}
			break;
		default:
			log_info("l2cap:unknown(%02x)\n",packet[0]);
			break;
		}	
	}
	if (packet_type == L2CAP_DATA_PACKET && size){
		uint8_t count = hid_process_packet(packet, (uint16_t *) &input[0], NUM_KEYS);
		if (!count) return;

		led1_on_mac();
        uint8_t new_char;
        // handle shift
        if (last_mod & MOD_SHIFT) {
            new_char = keytable_us_shift[input[0]];
        } else {
            new_char = keytable_us_none[input[0]];
        }
		if(new_char=='\n'){				//sibu CR追加
			UART1PutChar('\r');
		}
		UART1PutChar(new_char);
	}
}


// Bluetooth logic
static void packet_handler (void * connection, uint8_t packet_type, uint16_t channel, uint8_t *packet, uint16_t size)
{
//int i,j;
	bd_addr_t	event_addr;
	static	uint16_t handle=0;
	static	uint8_t	encryption_mode_set=0;
    
	switch (packet_type) {
		case HCI_EVENT_PACKET:
			switch (packet[0]) {
				case BTSTACK_EVENT_STATE:
					// bt stack activated, get started - set local name
					if (packet[2] == HCI_STATE_WORKING) {
						if(
							!addr_global[0]
						&&	!addr_global[1]
						&&	!addr_global[2]
						&&	!addr_global[3]
						&&	!addr_global[4]
						&&	!addr_global[5]
						){
							//bd address failed -> reset
							Reset();
						}
//hci_send_cmd(&hci_read_local_supprted_commands);
						xsprintf(lineBuffer,LOCAL_NAME "-%02x%02x%02x%02x%02x%02x",
							addr_global[0],
							addr_global[1],
							addr_global[2],
							addr_global[3],
							addr_global[4],
							addr_global[5]
						);
						log_info("local name:%s\r\n",lineBuffer);
#if	!__DEBUG
						DelayMs(100);
#endif
						//hci_send_cmd(&hci_write_authentication_enable, 1);
						hci_send_cmd(&hci_set_event_filter,0);
					}
					break;
				
				case HCI_EVENT_COMMAND_COMPLETE:
					if (COMMAND_COMPLETE_EVENT(packet, hci_read_bd_addr)){
                        bt_flip_addr(event_addr, &packet[6]);
                        log_info("BD-ADDR: %s\n\r", bd_addr_to_str(event_addr));
                        break;
                    }
					if (COMMAND_COMPLETE_EVENT(packet, hci_set_event_filter)){
						hci_send_cmd(&hci_set_event_mask,0xfffbffffLU,0x1dbff807LU);
					}else
					if (COMMAND_COMPLETE_EVENT(packet, hci_set_event_mask)){
						hci_send_cmd(&hci_write_default_link_policy_settings,0x000f);
					}else
					if (COMMAND_COMPLETE_EVENT(packet, hci_write_default_link_policy_settings)){
						hci_send_cmd(&hci_write_simple_pairing_mode,1);
					}else
					if (COMMAND_COMPLETE_EVENT(packet, hci_write_simple_pairing_mode/*hci_write_authentication_enable*/)){
						startup_state=1;
reconnect:
						if(mode_pairing){		//ペアリングモード
							log_info("Inquiry\n");
							hci_send_cmd(&hci_inquiry, HCI_INQUIRY_LAP, INQUIRY_INTERVAL, 0);
						}
                        break;
					}
					if (COMMAND_COMPLETE_EVENT(packet, hci_inquiry_cancel) ) {
						log_info("Inquiry Cancel Complete\n");
						//l2cap_create_channel_internal(NULL, l2cap_control_packet_handler, reader_bdaddr, PSM_HID_CONTROL, 150);
						//l2cap_create_channel_internal(NULL, l2cap_interrupt_packet_handler, reader_bdaddr, PSM_HID_INTERRUPT, 150);
						//hci_send_cmd(hci_authentication_requested,0x26);
		                hci_send_cmd(&hci_create_connection, reader_bdaddr, hci_usable_acl_packet_types(), 1, 0, 0, 1); 
						break;
					}

#if	USE_RSSI
					if(COMMAND_COMPLETE_EVENT(packet,hci_read_rssi)){
						signed char rssi_value;
						unsigned blink_rate;
						if(packet[5]==0){		//status=0
							rssi_value=(signed char)(packet[8]);
							log_info("hci_read_rssi status=%d RSSI=%d\n",packet[5],rssi_value);

							//blink rate
							if(rssi_value>=0){
								blink_rate=30;
							}else
							if(rssi_value<=-30){
								blink_rate=0;
							}else{
								blink_rate=(unsigned)rssi_value+30;
							}
							rssi_blink_rate_ms=blink_rate*60+200;
						}else{
							rssi_blink_rate_ms=1000;
						}
					}
#endif
                    break;

				case HCI_EVENT_INQUIRY_RESULT:
					
					// ignore further results
					if (foundReader){
						break;
					}

#if	1
					// ignore not MS910
					if(
//						!(packet[12]==0x00 && packet[13]==0x1F && packet[14]==0x00)	//SPP MODE
//						!(packet[12]==0x40 && packet[13]==0x05 && packet[14]==0x00)	//HID MODE
						!(packet[12]==0x80 && packet[13]==0x05 && packet[14]==0x00)	//windows no PIN CODE MODE
					){
						break;
					}

					// flip addr
					bt_flip_addr(reader_bdaddr, &packet[3]);
					
					// show
					log_info("found Reader:%s\n",bd_addr_to_str(reader_bdaddr));

					foundReader = 1;
					hci_send_cmd(&hci_inquiry_cancel);
#else
					bt_flip_addr(reader_bdaddr, &packet[3]);
					log_info("found:%s\n",bd_addr_to_str(reader_bdaddr));
#endif
					break;
					
				case HCI_EVENT_INQUIRY_COMPLETE:
					log_info("can't find Reader\n");
					goto reconnect;
					break;

				case HCI_EVENT_LINK_KEY_REQUEST:
					// deny link key request
                    log_info("Link key request\n\r");
                    bt_flip_addr(event_addr, &packet[2]);
					hci_send_cmd(&hci_link_key_request_negative_reply, &event_addr);
					break;
					
				case HCI_EVENT_PIN_CODE_REQUEST:
					// inform about pin code request
                    bt_flip_addr(event_addr, &packet[2]);
                    log_info("Pin code request - using '" PIN_CODE_DEFAULT "'\n\r");
					hci_send_cmd(&hci_pin_code_request_reply, &event_addr, 4, PIN_CODE_DEFAULT);
					break;

		        case HCI_EVENT_CONNECTION_COMPLETE:			//sibu
					if(mode_pairing){
						handle=READ_BT_16(packet, 3);
						log_info("HCI_EVENT_CONNECTION_COMPLETE!! handle=%x\n\r",handle);
						hci_send_cmd(&hci_authentication_requested,handle);
					}else
					if(!encryption_mode_set){
						hci_send_cmd(&hci_set_connection_encryption,handle,1);
					}
					break;

				case HCI_EVENT_IO_CAPABILITY_REQUEST:		//sibu
					log_info("HCI_IO_CAPABILITY_REQUEST!!\n\r");
					hci_send_cmd(&hci_io_capability_request_reply,&reader_bdaddr,1,0,0);
					break;

				case HCI_EVENT_USER_CONFIRMATION_REQUEST:	//sibu
					log_info("HCI_EVENT_USER_CONFIRMATION_REQUEST!!\n\r");
					hci_send_cmd(&hci_user_confirmation_request_reply,&reader_bdaddr);
					break;

				case HCI_EVENT_SIMPLE_PAIRING_COMPLETE:		//sibu
					log_info("HCI_EVENT_SIMPLE_PAIRING_COMPLETE!!\n\r");
					break;

		        case HCI_EVENT_LINK_KEY_NOTIFICATION:		//sibu
#if	USE_WRITE_STORED_LINK_KEY
					hci_send_cmd(&hci_write_stored_link_key,1,addr,(link_key_t*)(&packet[8]));
#else
					//sibu save link keys
					save_link_keys(db_mem_link_keys);
					print_link_keys(db_mem_link_keys);
#endif
					hci_send_cmd(&hci_set_connection_encryption,handle,1);
					break;

				case HCI_EVENT_ENCRYPTION_CHANGE:				//sibu
					if(mode_pairing){
						mode_pairing=0;
						led1_off();

						encryption_mode_set=1;
						activeconnect=1;
						l2cap_create_channel_internal(NULL, l2cap_control_packet_handler, reader_bdaddr, PSM_HID_CONTROL, 150);
					}
					break;

                default:
                    break;
			}
            break;

        default:
            break;
	}
}

int main ( void )
{
	RestartWatchdog();
	xdev_out(UART2PutChar);

    // Initialize the processor and peripherals.
    if ( InitializeSystem() != TRUE )
    {
        log_info( "\r\n\r\nCould not initialize " LOCAL_NAME " - system.  Halting.\r\n\r\n" );
        while (1);
    }
    if ( USBHostInit(0) == TRUE )
    {
        log_info( "\r\n\r\n***** " LOCAL_NAME " Initialized *****\r\n\r\n" );
    }
    else
    {
        log_info( "\r\n\r\nCould not initialize " LOCAL_NAME " - USB.  Halting.\r\n\r\n" );
        while (1);
    }

    // Main Processing Loop
    while(!deviceAddress)
    {
        // This demo does not check for overcurrent conditions.  See the
        // USB Host - Data Logger for an example of overcurrent detection
        // with the PIC24F and the USB PICtail Plus.

        // Maintain USB Host State
        USBHostTasks();

        //if (CheckForNewAttach()){
		//	break;
        //}
    }
	if(!get_pairen()){
		mode_pairing=1;
	}

	DelayMs(1000);

	led2_off();

	/// GET STARTED with BTstack ///
	btstack_memory_init();
    run_loop_init(RUN_LOOP_EMBEDDED);
	
    // init HCI
	hci_transport_t    * transport = hci_transport_picusb_instance();
	bt_control_t       * control   = NULL;
    hci_uart_config_t  * config    = NULL;
    remote_device_db_t * remote_db = (remote_device_db_t *) &remote_device_db_memory;
	hci_init(transport, config, control, remote_db);

    // use eHCILL
//    bt_control_cc256x_enable_ehcill(1);
    
    // init L2CAP
    l2cap_init();
    l2cap_register_packet_handler(packet_handler);

	l2cap_register_service_internal(NULL, l2cap_control_packet_handler, PSM_HID_CONTROL, 160);
	l2cap_register_service_internal(NULL, l2cap_interrupt_packet_handler, PSM_HID_INTERRUPT, 160);

 	// turn on!
	hci_power_control(HCI_POWER_ON);

#if	!USE_WRITE_STORED_LINK_KEY
extern linked_list_t db_mem_link_keys;
int load_link_keys(remote_device_db_t * lpremote_device_db);
void print_link_keys(linked_list_t list);
	if(!mode_pairing && !load_link_keys(remote_db)){
		mode_pairing=1;
	}
	print_link_keys(db_mem_link_keys);
#endif

    led1_off();

    // go!
    run_loop_execute();	

    return 0;

} // main


void hal_tick_init(void)
{
	usb_tick_handler=NULL;
}

void hal_tick_set_handler(void (*tick_handler)(void))
{
	usb_tick_handler=tick_handler;
}

void hal_tick_event(void)
{
	timer_counter++;

	RestartWatchdog();

	if(!startup_state && timer_counter>5000){
		Reset();
	}

    if (mode_pairing){
        if(timer_counter&0x100){
            led1_off();
        }else{
            led1_on();
        }
    }
	if(reader_interrupt_channel_id){
        if(timer_counter&0x100){
            led2_off();
        }else{
            led2_on();
        }
    }else{
		led2_on();
	}

	if(led1_on_state && (timer_counter-led1_on_count)>LED1_ON_COUNT){
		led1_off();
		led1_on_state=0;
	}

	// call tick handler
	if(usb_tick_handler){
		usb_tick_handler();
	}
}

/*************************************************************************
 * EOF main.c
 */

