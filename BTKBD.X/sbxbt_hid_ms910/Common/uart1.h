//******************************************************************************
// Function Prototypes
//******************************************************************************

#define	UARTPARAM_PDSEL_MASK	0x000f
#define	UARTPARAM_PDSEL_SHIFT	0
#define	UARTPARAM_STSEL_MASK	0x00f0
#define	UARTPARAM_STSEL_SHIFT	4
#define	UARTPARAM_PARGEN_EVEN	0x0100
#define	UARTPARAM_PARGEN_ODD	0x0200

#define	UARTPARAM_N81			0x0000	//data=8bit parity=none stopbit=1bit
#define	UARTPARAM_E81			0x0001	//data=8bit parity=even stopbit=1
#define	UARTPARAM_O81			0x0002	//data=8bit parity=odd stopbit=1
#define	UARTPARAM_N82			0x0010	//data=8bit parity=none stopbit=1bit
#define	UARTPARAM_E82			0x0011	//data=8bit parity=even stopbit=2
#define	UARTPARAM_O82			0x0012	//data=8bit parity=odd stopbit=2
#define	UARTPARAM_E71			0x0100	//data=7bit parity=even stopbit=1
#define	UARTPARAM_O71			0x0200	//data=7bit parity=odd stopbit=1
#define	UARTPARAM_E72			0x0120	//data=7bit parity=even stopbit=2
#define	UARTPARAM_O72			0x0220	//data=7bit parity=odd stopbit=2
#define	UARTPARAM_N91			0x0003	//data=9bit parity=none stopbit=1
#define	UARTPARAM_N92			0x0013	//data=9bit parity=none stopbit=2

/*******************************************************************************
Function: UART2GetBaudError()

Precondition:
    None.

Overview:
    This routine checks the UART baud rate error percentage and returns it.

Input: None.

Output: Returns the baud rate error in percent.

*******************************************************************************/
char UART1GetBaudError();

/*********************************************************************
Function: int UART2GetChar()

PreCondition: none

Input: none

Output: last character received / -1:no character received

Side Effects: none

Overview: returns last character received

Note: none

********************************************************************/
int UART1GetChar();

/*********************************************************************
Function: void UART2PutChar(char ch)

PreCondition: none

Input: none

Output: none

Side Effects: none

Overview: puts character

Note: none
********************************************************************/
void UART1PutChar( char ch );

/*********************************************************************
Function: void UART2Init(void)

PreCondition: none

Input: none

Output: none

Side Effects: none

Overview: initializes UART 

Note: none
********************************************************************/
void UART1Init(unsigned long baudrate);
