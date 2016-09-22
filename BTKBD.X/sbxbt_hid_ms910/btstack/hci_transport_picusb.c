#include "config.h"

#include "debug.h"
#include "hci.h"
#include "hci_transport.h"
#include "hci_dump.h"

// prototypes
static void dummy_handler(uint8_t packet_type, uint8_t *packet, uint16_t size); 
static int usb_close(void *transport_config);
    
enum {
    LIB_USB_CLOSED = 0,
    LIB_USB_OPENED,
    LIB_USB_DEVICE_OPENDED,
    LIB_USB_KERNEL_DETACHED,
    LIB_USB_INTERFACE_CLAIMED,
    LIB_USB_TRANSFERS_ALLOCATED
} libusb_state = LIB_USB_CLOSED;

// single instance
static hci_transport_t * hci_transport_usb = NULL;

static  void (*packet_handler)(uint8_t packet_type, uint8_t *packet, uint16_t size) = dummy_handler;

static uint8_t hci_event_in_buffer[ASYNC_BUFFERS][HCI_EVENT_BUFFER_SIZE]; // bigger than largest packet
static uint8_t hci_bulk_in_buffer[ASYNC_BUFFERS][HCI_ACL_BUFFER_SIZE];  // bigger than largest packet

extern BYTE        deviceAddress;  // Address of the device on the USB


void	event_bluetooth_rxEvent_done(WORD size)
{
	hci_dump_packet( HCI_EVENT_PACKET, 1, hci_event_in_buffer[0],size);
	packet_handler(HCI_EVENT_PACKET,hci_event_in_buffer[0],size);
}

void	event_bluetooth_rxAcl_done(WORD size)
{
	hci_dump_packet( HCI_ACL_DATA_PACKET, 1,hci_bulk_in_buffer[0],size);
	packet_handler(HCI_ACL_DATA_PACKET,hci_bulk_in_buffer[0],size);
}

static int usb_process_ds(struct data_source *ds)
{
	if (!USBHostBluetoothRxEventIsBusy(deviceAddress)){
		if(USBHostBluetoothReadEvent(deviceAddress, hci_event_in_buffer[0], HCI_EVENT_BUFFER_SIZE) == USB_SUCCESS ){
			//hci_dump_packet( HCI_EVENT_PACKET, 1, hci_event_in_buffer[0],ret);
			//packet_handler(HCI_EVENT_PACKET,hci_event_in_buffer[0],ret);
		}
	}
	if (!USBHostBluetoothRxAclIsBusy(deviceAddress)){
		if(USBHostBluetoothReadAcl(deviceAddress, hci_bulk_in_buffer[0], HCI_ACL_BUFFER_SIZE) == USB_SUCCESS ){
            //hci_dump_packet( HCI_ACL_DATA_PACKET, 1,hci_bulk_in_buffer[0],ret);
            //packet_handler(HCI_ACL_DATA_PACKET,hci_bulk_in_buffer[0],ret);
		}
    }
    return 0;
}

static data_source_t ds;
	
static int usb_open(void *transport_config)
{
	memset(&ds,0,sizeof(ds));
	ds.process=usb_process_ds;
	run_loop_add_data_source(&ds);

    return 0;
}
static int usb_close(void *transport_config){
    // @TODO: remove all run loops!

	run_loop_remove_data_source(&ds);
    return 0;
}

static int usb_send_cmd_packet(uint8_t *packet, int size)
{
    BYTE	r;

retry:
    hci_dump_packet( HCI_COMMAND_DATA_PACKET, 0, packet, size);
	r=USBHostBluetoothWriteCmd(deviceAddress,packet,size);
	if(r!=USB_SUCCESS){
        log_error("Error submitting control transfer 0x%02x\n", r);
		goto retry;
        //return r;
    }

    return 0;
}

static int usb_send_acl_packet(uint8_t *packet, int size)
{
	BYTE	r;

retry:
    hci_dump_packet( HCI_ACL_DATA_PACKET, 0, packet, size);
	r=USBHostBluetoothWriteAcl(deviceAddress,packet,size);
	if(r!=USB_SUCCESS){
        log_error("Error submitting data transfer %d\n",r);
		goto retry;
		//return r;
    }

    return 0;
}

static int usb_send_packet(uint8_t packet_type, uint8_t * packet, int size){
    switch (packet_type){
        case HCI_COMMAND_DATA_PACKET:
            return usb_send_cmd_packet(packet, size);
        case HCI_ACL_DATA_PACKET:
            return usb_send_acl_packet(packet, size);
        default:
            return -1;
    }
}

static void usb_register_packet_handler(void (*handler)(uint8_t packet_type, uint8_t *packet, uint16_t size)){
    log_info("registering packet handler\n");
    packet_handler = handler;
}

static const char * usb_get_transport_name(void){
    return "PICUSB";
}

static void dummy_handler(uint8_t packet_type, uint8_t *packet, uint16_t size){
}

// get usb singleton
hci_transport_t * hci_transport_picusb_instance() {
    if (!hci_transport_usb) {
        hci_transport_usb = malloc( sizeof(hci_transport_t));
        hci_transport_usb->open                          = usb_open;
        hci_transport_usb->close                         = usb_close;
        hci_transport_usb->send_packet                   = usb_send_packet;
        hci_transport_usb->register_packet_handler       = usb_register_packet_handler;
        hci_transport_usb->get_transport_name            = usb_get_transport_name;
        hci_transport_usb->set_baudrate                  = NULL;
        hci_transport_usb->can_send_packet_now           = NULL;
    }
    return hci_transport_usb;
}
