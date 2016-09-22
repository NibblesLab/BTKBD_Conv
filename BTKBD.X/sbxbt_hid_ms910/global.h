#include <stdlib.h>
#include "GenericTypeDefs.h"
#include "HardwareProfile.h"
#include "usb_config.h"
#include "USB/usb.h"
#include "USB/usb_host_bluetooth.h"
#include "user.h"
#include "timer.h"
#include "xprintf.h"

#define PIN_CODE_DEFAULT	"1234"
#define BOARD_SBDBT         1
#define BOARD_SBXBT         0
#define	BOARD_SBRBT			0
#define	BOARD_SBGRBT		0

// Define the baud rate constants UART1
#define	UARTPARAM1			UARTPARAM_N81			//data=8bit parity=none stopbit=1bit

#define BAUDRATE1       	9600
#define	USE_RFCOMM_BAUDRATE	0						//0:baud rate as fixed 1:baud rate as RFCOMM parameter from Master
#define BRG_DIV1        	4
#define BRGH1           	1
// Define Hardware Flow Control UART1 (0:off 1:on)
#define	UART1_HW_FLOW		0
#define	UART1_TX_POLARITY	0						//送信信号極性 0:通常 1:反転
#define	UART1_RX_POLARITY	0						//受信信号極性 0:通常 1:反転

// Define the baud rate constants UART2 (Debug)
#define BAUDRATE2       	115200
#define BRG_DIV2        	4
#define BRGH2           	1

// Define LED1 communication indicator on time(ms)
#define	LED1_ON_COUNT		10
#define	USE_RSSI			1						//0:blink rate as fixed 1:blink rate as RSSI (fast:lowRSSI slow:highRSSI)
#define	USE_WRITE_STORED_LINK_KEY	 0				//SPP接続のリンクキーを 0:PICのFLASHに保存 1:Bluetoothアダプタに保存



#if BOARD_SBDBT
#define LOCAL_NAME			"SBDBT"
#define	ICSDEF				ICS_PGx1
#endif

#if BOARD_SBXBT
#define LOCAL_NAME			"SBXBT"
//#define	ICSDEF				ICS_PGx1
#define	ICSDEF				ICS_PGx3
#endif

#if BOARD_SBRBT
#define LOCAL_NAME			"SBRBT"
#define	ICSDEF				ICS_PGx1
#endif

#if BOARD_SBGRBT
#define LOCAL_NAME			"SBGRBT"
#define	ICSDEF				ICS_PGx1
#endif

#if	__DEBUG
//disable watchdog timer
#define	FWDTENDEF			FWDTEN_OFF
#define	RestartWatchdog()
#define STO_SERIAL			1   //0:STO as I/O  1:STO as serial output
#else
//enable watchdog timer
#define	FWDTENDEF			FWDTEN_ON
#define	RestartWatchdog()	ClrWdt()
#define STO_SERIAL			0   //0:STO as I/O  1:STO as serial output
#endif

#if BOARD_SBXBT
//
// for SBXBT board
//
// Configure LED1 - put on pin 14 (RB14)
#define	led1_setup()		(TRISBbits.TRISB15=0)
#define	led1_on()			(LATBbits.LATB15=0)	//ON
#define	led1_off()			(LATBbits.LATB15=1)	//OFF

// Configure LED2 - put on pin 15 (RB15)
#define	led2_setup()		(TRISBbits.TRISB14=0)
#define	led2_on()			(LATBbits.LATB14=0)	//ON
#define	led2_off()			(LATBbits.LATB14=1)	//OFF

// Configure U1RX - put on pin 3 (RP23)
#define	u1rx_setup()		(RPINR18bits.U1RXR = 23)
// Configure U1TX - put on pin 2 (RP22)
#define u1tx_setup()		(RPOR11bits.RP22R = 3)
// Configure U1CTS - put on pin 4 (RP24)
#define	u1cts_setup()		(RPINR18bits.U1CTSR = 24)
// Configure U1RTS - put on pin 5 (RC9)
// U1RTS has software control
#define	u1rts_setup()		(TRISCbits.TRISC9=0)
#define	u1rts_on()			(LATCbits.LATC9=0)	//ON:rx ready
#define	u1rts_off()			(LATCbits.LATC9=1)	//OFF:rx not ready

#if	STO_SERIAL
// Configure console OUT(U2TX) - put on pin 37 (RP20)
#define	sto_setup()			(RPOR10bits.RP20R = 5)
#define	sto_l()
#define	sto_h()
#else
// Configure RSSI(status) OUT - put on pin 37 (RC4)
#define	sto_setup()			(TRISCbits.TRISC4=0)
#define	sto_l()				(LATCbits.LATC4=0)
#define	sto_h()				(LATCbits.LATC4=1)
#endif

// Configure Association OUT - put on pin 20 (RA1)
#define	assoc_setup()		(TRISAbits.TRISA1=0)
#define	assoc_l()			(LATAbits.LATA1=0)
#define	assoc_h()			(LATAbits.LATA1=1)

// Configure ON OUT - put on pin 44 (RB8)
#define	on_setup()			{TRISBbits.TRISB8=0; LATBbits.LATB8=1;}

#define	pairen_setup()
#define	get_pairen()		(1)

#elif BOARD_SBDBT

//
//for SBDBT board
//
// Configure LED1 - put on pin 14 (RB14)
#define	led1_setup()		(TRISBbits.TRISB14=0)
#define	led1_on()			(LATBbits.LATB14=0)	//ON
#define	led1_off()			(LATBbits.LATB14=1)	//OFF

// Configure LED2 - put on pin 15 (RB15)
#define	led2_setup()		(TRISBbits.TRISB15=0)
#define	led2_on()			(LATBbits.LATB15=0)	//ON
#define	led2_off()			(LATBbits.LATB15=1)	//OFF

// Configure U1RX - put on pin 3 (RP23)
#define	u1rx_setup()		(RPINR18bits.U1RXR = 23)
// Configure U1TX - put on pin 2 (RP22)
#define u1tx_setup()		(RPOR11bits.RP22R = 3)
// Configure U1CTS - put on pin 4 (RP24)
#define	u1cts_setup()		(RPINR18bits.U1CTSR = 24)
// Configure U1RTS - put on pin 5 (RC9)
// U1RTS has software control
#define	u1rts_setup()		(TRISCbits.TRISC9=0)
#define	u1rts_on()			(LATCbits.LATC9=0)	//ON:rx ready
#define	u1rts_off()			(LATCbits.LATC9=1)	//OFF:rx not ready

#if	STO_SERIAL
// Configure console OUT(U2TX) - put on pin 1 (RP9)
#define	sto_setup()			(RPOR4bits.RP9R = 5)
#define	sto_l()
#define	sto_h()
#else
// Configure Status OUT - put on pin 1 (RB9)
#define	sto_setup()		(TRISBbits.TRISB9=0)
#define	sto_l()			(LATBbits.LATB9=0)
#define	sto_h()			(LATBbits.LATB9=1)
#endif

// no association out on this board
#define	assoc_setup()
#define	assoc_l()
#define	assoc_h()

// no on out on this board
#define	on_setup()

#define	pairen_setup()		{CNPU2bits.CN20PUE=1;}
#define	get_pairen()		(PORTCbits.RC8)

#elif BOARD_SBRBT

//
//for SBRBT board
//
// Configure LED1 - put on pin 14 (RB14)
#define	led1_setup()		(TRISBbits.TRISB14=0)
#define	led1_on()			(LATBbits.LATB14=0)	//ON
#define	led1_off()			(LATBbits.LATB14=1)	//OFF

// Configure LED2 - put on pin 15 (RB15)
#define	led2_setup()		(TRISBbits.TRISB15=0)
#define	led2_on()			(LATBbits.LATB15=0)	//ON
#define	led2_off()			(LATBbits.LATB15=1)	//OFF

// Configure U1RX - put on pin 3 (RP23)
#define	u1rx_setup()		(RPINR18bits.U1RXR = 23)
// Configure U1TX - put on pin 2 (RP22)
#define u1tx_setup()		(RPOR11bits.RP22R = 3)


// Configure U1CTS - put on pin 4 (RP24)
#define	u1cts_setup()		(RPINR18bits.U1CTSR = 24)
// Configure U1RTS - put on pin 5 (RC9)
// U1RTS has software control
#define	u1rts_setup()		(TRISCbits.TRISC9=0)
#define	u1rts_on()			(LATCbits.LATC9=0)	//ON:rx ready
#define	u1rts_off()			(LATCbits.LATC9=1)	//OFF:rx not ready

// Configure Pairing enable in - put on pin 1 (RB9)
#define	sto_setup()
#define	sto_l()
#define	sto_h()

// no association out on this board
#define	assoc_setup()
#define	assoc_l()
#define	assoc_h()

// no on out on this board
#define	on_setup()

// Configure Pairing Enable Jumper - on pin 1 (RB9, CN21)
#define	pairen_setup()		{CNPU2bits.CN21PUE=1;}
#define	get_pairen()		(PORTBbits.RB9)

#elif BOARD_SBGRBT
//
//for SBRBT board
//
// Configure LED1 - put on pin 14 (RB14)
#define	led1_setup()		(TRISBbits.TRISB14=0)
#define	led1_on()			(LATBbits.LATB14=0)	//ON
#define	led1_off()			(LATBbits.LATB14=1)	//OFF

// Configure LED2 - put on pin 15 (RB15)
#define	led2_setup()		(TRISBbits.TRISB15=0)
#define	led2_on()			(LATBbits.LATB15=0)	//ON
#define	led2_off()			(LATBbits.LATB15=1)	//OFF

// Configure U1RX - put on pin 3 (RP23)
#define	u1rx_setup()		(RPINR18bits.U1RXR = 23)
// Configure U1TX - put on pin 2 (RP22)
#define u1tx_setup()		(RPOR11bits.RP22R = 3)


// Configure U1CTS - put on pin 4 (RP24)
#define	u1cts_setup()		(RPINR18bits.U1CTSR = 24)
// Configure U1RTS - put on pin 5 (RC9)
// U1RTS has software control
#define	u1rts_setup()		(TRISCbits.TRISC9=0)
#define	u1rts_on()			(LATCbits.LATC9=0)	//ON:rx ready
#define	u1rts_off()			(LATCbits.LATC9=1)	//OFF:rx not ready

// Configure Pairing enable in - put on pin 1 (RB9)
#define	sto_setup()
#define	sto_l()
#define	sto_h()

// no association out on this board
#define	assoc_setup()
#define	assoc_l()
#define	assoc_h()

// no on out on this board
#define	on_setup()

// Configure Pairing Enable Jumper - on pin 1 (RB9, CN21)
#define	pairen_setup()		{CNPU2bits.CN21PUE=1;}
#define	get_pairen()		(!PORTBbits.RB9)

#endif


#define Nop()    __builtin_nop()
#define ClrWdt() {__asm__ volatile ("clrwdt");}
#define Sleep()  {__asm__ volatile ("pwrsav #0");}
#define Idle()   {__asm__ volatile ("pwrsav #1");}

extern void (*usb_tick_handler)(void);
void	event_bluetooth_rxEvent_done(WORD size);
void	event_bluetooth_rxAcl_done(WORD size);
