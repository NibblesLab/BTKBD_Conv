#include "Compiler.h"
#include "HardwareProfile.h"
#include "uart2.h"
#include "global.h"

//******************************************************************************
// Constants
//******************************************************************************

#define	USE_RX_HW_FLOWCTL	0
#define	USE_TX_HW_FLOWCTL	0


//U2BRG register value and baudrate mistake calculation

#if defined (__C30__)
    #if defined (__dsPIC33E__) || defined (__PIC24E__)
    #define BAUDRATEREG2        (((GetPeripheralClock())/(BRG_DIV2 * BAUDRATE2)) - 1)
    #else
    #define BAUDRATEREG2        (((GetSystemClock()/2)+(BRG_DIV2/2*BAUDRATE2))/BRG_DIV2/BAUDRATE2-1)
    #endif
#elif defined (__PIC32MX__)
    #define BAUDRATEREG2        ((GetPeripheralClock()+(BRG_DIV2/2*BAUDRATE2))/BRG_DIV2/BAUDRATE2-1)
#else
    #error Cannot calculate BRG value
#endif    

#if defined (__C30__)
    #if defined (__dsPIC33E__)|| defined (__PIC24E__)
    #define BAUD_ACTUAL         ((GetPeripheralClock())/(BRG_DIV2 * (BAUDRATEREG2+1)))
    #else
    #define BAUD_ACTUAL         ((GetSystemClock()/2)/BRG_DIV2/(BAUDRATEREG2+1))
    #endif
#elif defined (__PIC32MX__)
    #define BAUD_ACTUAL         (GetPeripheralClock()/BRG_DIV2/(BAUDRATEREG2+1))
#else
    #error Cannot calculate actual baud rate
#endif 

	#define BAUD_ERROR              ((BAUD_ACTUAL > BAUDRATE2) ? BAUD_ACTUAL-BAUDRATE2 : BAUDRATE2-BAUD_ACTUAL)
	#define BAUD_ERROR_PERCENT      ((BAUD_ERROR*100+BAUDRATE2/2)/BAUDRATE2)
	
#if defined (__C30__)

	#if (BAUD_ERROR_PERCENT > 3)
	    #error UART frequency error is worse than 3%
	#elif (BAUD_ERROR_PERCENT > 2)
	    #warning UART frequency error is worse than 2%
	#endif

#endif // #if defined (__C30__)

/*******************************************************************************
Function: UART2GetBaudError()

Precondition:
    None.

Overview:
    This routine checks the UART baud rate error percentage and returns it.

Input: None.

Output: Returns the baud rate error in percent.

*******************************************************************************/
char UART2GetBaudError()
{
    unsigned int errorPercent = 0;

	errorPercent = ((BAUD_ERROR*100+BAUDRATE2/2)/BAUDRATE2);
    return (char)errorPercent;
}

#define	RXBUFSIZ			8
#define	TXBUFSIZ			128
static volatile char		rxbuf[RXBUFSIZ];
static volatile BYTE		rxbufrp,rxbufwp,rxbufcnt;
static volatile char		txbuf[TXBUFSIZ];
static volatile BYTE		txbufrp,txbufwp,txbufcnt;
#if	USE_RX_HW_FLOWCTL
#define	FLOWSTOP_RXBUF_SIZ		6
#define	FLOWRESTART_RXBUF_SIZ	4
#define	rts_on()			()	//ON:rx ready
#define	rts_off()			()	//OFF:rx not ready
static volatile char		rxflowstop;
#endif

#define	BAUDRATEREG			BAUDRATEREG2
#define	BRGHREG				BRGH2

#define	isRXINT()			(IFS1bits.U2RXIF)
#define	isTXINT()			(IFS1bits.U2TXIF)
#define	RXINT_Clear()		(IFS1bits.U2RXIF=0)
#define	TXINT_Clear()		(IFS1bits.U2TXIF=0)
#define	isEnableRXINT()		(IEC1bits.U2RXIE)
#define	isEnableTXINT()		(IEC1bits.U2TXIE)
#define	EnableRXINT()		(IEC1bits.U2RXIE=1)
#define	EnableTXINT()		(IEC1bits.U2TXIE=1)
#define	DisableRXINT()		(IEC1bits.U2RXIE=0)
#define	DisableTXINT()		(IEC1bits.U2TXIE=0)

#define	UBRG				U2BRG
#define	UMODE				U2MODE
#define	UMODEbits			U2MODEbits
#define	USTA				U2STA
#define	USTAbits			U2STAbits
#define	URXREG				U2RXREG
#define	UTXREG				U2TXREG
#define	_RXInterrupt		_U2RXInterrupt
#define	_TXInterrupt		_U2TXInterrupt
#define	_ErrInterrupt		_U2ErrInterrupt

void __attribute__((__interrupt__, no_auto_psv)) _RXInterrupt ( void )
{
	while(USTAbits.URXDA){
#if	USE_RX_HW_FLOWCTL
		if(!rxflowstop){
			if(rxbufcnt>=FLOWSTOP_RXBUF_SIZ){
				rxflowstop=1;
				rts_off();
			}
		}
#endif
		if(rxbufcnt<RXBUFSIZ){
			rxbuf[rxbufwp]=URXREG;
			rxbufwp=(rxbufwp+1)&(RXBUFSIZ-1);
			rxbufcnt++;
		}else{
			break;
		}
	}
	RXINT_Clear();
}

void __attribute__((__interrupt__, no_auto_psv)) _TXInterrupt ( void )
{
	while(!USTAbits.UTXBF){		//FIFO‚É‹ó‚«‚ª‚ ‚é
		if(txbufcnt){
			UTXREG=txbuf[txbufrp];
			txbufrp=(txbufrp+1)&(TXBUFSIZ-1);
			txbufcnt--;
		}else{
			DisableTXINT();
			return;
		}
	}
	TXINT_Clear();
}

void UART2Init()
{
    UBRG = BAUDRATEREG;
    UMODE = 0;
    UMODEbits.BRGH = BRGHREG;
#if	USE_TX_HW_FLOWCTL
	UMODEbits.UEN = 2;
#endif
	//UMODEbits.WAKE=1;
    UMODEbits.UARTEN = 1;
    USTA = 0;
	USTAbits.UTXEN = 1;
    RXINT_Clear();
    
    #if defined (__PIC32MX__)
        USTAbits.URXEN = 1;
    #endif

	rxbufrp=rxbufwp=rxbufcnt=0;
	txbufrp=txbufwp=txbufcnt=0;
#if	USE_RX_HW_FLOWCTL
	rxflowstop=0;
	rts_on();
#endif

	EnableRXINT();
}

void UART2PutChar( char ch )
{
	while(txbufcnt>=TXBUFSIZ);

	txbuf[txbufwp]=ch;
	txbufwp=(txbufwp+1)&(TXBUFSIZ-1);

	DisableTXINT();
	txbufcnt++;
	EnableTXINT();
}

int UART2GetChar()
{
	int	ret=-1;

	if(USTAbits.OERR){
		USTAbits.OERR=0;
	}

	if(rxbufcnt){
		ret=((BYTE)rxbuf[rxbufrp]);
		rxbufrp=(rxbufrp+1)&(RXBUFSIZ-1);
		DisableRXINT();
		rxbufcnt--;
#if	USE_RX_HW_FLOWCTL
		if(rxflowstop){
			if(rxbufcnt<FLOWRESTART_RXBUF_SIZ){
				rxflowstop=0;
				rts_on();
			}
		}
#endif
		EnableRXINT();
	}
//UART2PutChar(ret);

	return ret;
}
