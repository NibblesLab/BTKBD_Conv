#include "Compiler.h"
#include "HardwareProfile.h"
#include "uart1.h"
#include "global.h"

//******************************************************************************
// Constants
//******************************************************************************

#define	USE_RX_HW_FLOWCTL	UART1_HW_FLOW
#define	USE_TX_HW_FLOWCTL	UART1_HW_FLOW
#define	TX_POLARITY			UART1_TX_POLARITY
#define	RX_POLARITY			UART1_RX_POLARITY

//U1BRG register value and baudrate mistake calculation

#if defined (__C30__)
    #if defined (__dsPIC33E__) || defined (__PIC24E__)
    #define BAUDRATEREG1        (((GetPeripheralClock())/(BRG_DIV1 * BAUDRATE1)) - 1)
    #else
    #define BAUDRATEREG1        (((GetSystemClock()/2)+(BRG_DIV1/2*BAUDRATE1))/BRG_DIV1/BAUDRATE1-1)
    #endif
#elif defined (__PIC32MX__)
    #define BAUDRATEREG1        ((GetPeripheralClock()+(BRG_DIV1/2*BAUDRATE1))/BRG_DIV1/BAUDRATE1-1)
#else
    #error Cannot calculate BRG value
#endif    

#if defined (__C30__)
    #if defined (__dsPIC33E__)|| defined (__PIC24E__)
    #define BAUD_ACTUAL         ((GetPeripheralClock())/(BRG_DIV1 * (BAUDRATEREG1+1)))
    #else
    #define BAUD_ACTUAL         ((GetSystemClock()/2)/BRG_DIV1/(BAUDRATEREG1+1))
    #endif
#elif defined (__PIC32MX__)
    #define BAUD_ACTUAL         (GetPeripheralClock()/BRG_DIV1/(BAUDRATEREG1+1))
#else
    #error Cannot calculate actual baud rate
#endif 

	#define BAUD_ERROR              ((BAUD_ACTUAL > BAUDRATE1) ? BAUD_ACTUAL-BAUDRATE1 : BAUDRATE1-BAUD_ACTUAL)
	#define BAUD_ERROR_PERCENT      ((BAUD_ERROR*100+BAUDRATE1/2)/BAUDRATE1)
	
#if defined (__C30__)

	#if (BAUD_ERROR_PERCENT > 3)
	    #error UART frequency error is worse than 3%
	#elif (BAUD_ERROR_PERCENT > 2)
	    #warning UART frequency error is worse than 2%
	#endif

#endif // #if defined (__C30__)

#define	RXBUFSIZ			1024
#define	TXBUFSIZ			128
static volatile char		rxbuf[RXBUFSIZ];
static volatile WORD		rxbufrp,rxbufwp,rxbufcnt;
static volatile char		txbuf[TXBUFSIZ];
static volatile WORD		txbufrp,txbufwp,txbufcnt;
#if	USE_RX_HW_FLOWCTL
#define	FLOWSTOP_RXBUF_SIZ		1000
#define	FLOWRESTART_RXBUF_SIZ	800
#define	rts_on()			u1rts_on()	//ON:rx ready
#define	rts_off()			u1rts_off()	//OFF:rx not ready
static volatile char		rxflowstop;
#endif

#define	BAUDRATEREG			BAUDRATEREG1
#define	BRGHREG				BRGH1
#define	UARTPARAM			UARTPARAM1

#define	isRXINT()			(IFS0bits.U1RXIF)
#define	isTXINT()			(IFS0bits.U1TXIF)
#define	RXINT_Clear()		(IFS0bits.U1RXIF=0)
#define	TXINT_Clear()		(IFS0bits.U1TXIF=0)
#define	isEnableRXINT()		(IEC0bits.U1RXIE)
#define	isEnableTXINT()		(IEC0bits.U1TXIE)
#define	EnableRXINT()		(IEC0bits.U1RXIE=1)
#define	EnableTXINT()		(IEC0bits.U1TXIE=1)
#define	DisableRXINT()		(IEC0bits.U1RXIE=0)
#define	DisableTXINT()		(IEC0bits.U1TXIE=0)

#define	UBRG				U1BRG
#define	UMODE				U1MODE
#define	UMODEbits			U1MODEbits
#define	USTA				U1STA
#define	USTAbits			U1STAbits
#define	URXREG				U1RXREG
#define	UTXREG				U1TXREG
#define	_RXInterrupt		_U1RXInterrupt
#define	_TXInterrupt		_U1TXInterrupt
#define	_ErrInterrupt		_U1ErrInterrupt

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

#ifdef	BAUDRATE1
#undef	BAUDRATE1
#endif
#define	BAUDRATE1	baudrate
void UART1Init(unsigned long baudrate)
{
	DisableRXINT();
	DisableTXINT();

    UBRG = BAUDRATEREG;
    UMODE = 0;
    UMODEbits.BRGH = BRGHREG;
	UMODEbits.PDSEL = (UARTPARAM&UARTPARAM_PDSEL_MASK)>>UARTPARAM_PDSEL_SHIFT;
	UMODEbits.STSEL = (UARTPARAM&UARTPARAM_STSEL_MASK)>>UARTPARAM_STSEL_SHIFT;
#if	USE_TX_HW_FLOWCTL
	UMODEbits.UEN = 2;
#endif
#if	RX_POLARITY
	UMODEbits.RXINV = 1;
#endif
	//UMODEbits.WAKE=1;
    UMODEbits.UARTEN = 1;
    USTA = 0;
#if	TX_POLARITY
	USTAbits.UTXINV = 1;
#endif
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

#if	UARTPARAM&(UARTPARAM_PARGEN_EVEN|UARTPARAM_PARGEN_ODD)
static int getparity_even(int ch)
{
	unsigned	i,mask,bitcount;

	mask=1;
	bitcount=0;
	for(i=0;i<7;i++,mask<<=1){
		if(ch&mask){
			bitcount++;
		}
	}
	return bitcount&1;
}
#endif

void UART1PutChar( char ch )
{
	while(txbufcnt>=TXBUFSIZ);

#if	UARTPARAM&UARTPARAM_PARGEN_EVEN
	txbuf[txbufwp]=(char)(((int)ch&0x7f) + (getparity_even(ch)?0x80:0x00));
#elif	UARTPARAM&UARTPARAM_PARGEN_ODD
	txbuf[txbufwp]=(char)(((int)ch&0x7f) + (getparity_even(ch)?0x00:0x80));
#else
	txbuf[txbufwp]=ch;
#endif
	txbufwp=(txbufwp+1)&(TXBUFSIZ-1);

	DisableTXINT();
	txbufcnt++;
	EnableTXINT();
}

int UART1GetChar()
{
	int	ret=-1;

	if(USTAbits.OERR){
		USTAbits.OERR=0;
	}

	if(rxbufcnt){
		ret=((BYTE)rxbuf[rxbufrp]);
#if	UARTPARAM&(UARTPARAM_PARGEN_EVEN|UARTPARAM_PARGEN_ODD)
		ret&=0x7f;
#endif
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
//UART1PutChar(ret);
	}

	return ret;
}
