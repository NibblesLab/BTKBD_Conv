//******************************************************************************
// Function Prototypes
//******************************************************************************

/*******************************************************************************
Function: UART2GetBaudError()

Precondition:
    None.

Overview:
    This routine checks the UART baud rate error percentage and returns it.

Input: None.

Output: Returns the baud rate error in percent.

*******************************************************************************/
char UART2GetBaudError();

/*********************************************************************
Function: int UART2GetChar()

PreCondition: none

Input: none

Output: last character received / -1:no character received

Side Effects: none

Overview: returns last character received

Note: none

********************************************************************/
int UART2GetChar();

/*********************************************************************
Function: void UART2PutChar(char ch)

PreCondition: none

Input: none

Output: none

Side Effects: none

Overview: puts character

Note: none
********************************************************************/
void UART2PutChar( char ch );

/*********************************************************************
Function: void UART2Init(void)

PreCondition: none

Input: none

Output: none

Side Effects: none

Overview: initializes UART 

Note: none
********************************************************************/
void UART2Init();
