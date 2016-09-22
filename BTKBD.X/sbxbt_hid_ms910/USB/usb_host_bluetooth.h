#ifndef __USBHOSTBLUETOOTH_H__
#define __USBHOSTBLUETOOTH_H__
//DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Constants
// *****************************************************************************
// *****************************************************************************

// This is the default Bluetooth Client Driver endpoint number.
#ifndef USB_BLUETOOTH_EP1
    #define USB_BLUETOOTH_EP1       1
#endif
#ifndef USB_BLUETOOTH_EP2
    #define USB_BLUETOOTH_EP2       2
#endif
	
// *****************************************************************************
// *****************************************************************************
// Section: USB Bluetooth Client Events
// *****************************************************************************
// *****************************************************************************

        // This is an optional offset for the values of the generated events.
        // If necessary, the application can use a non-zero offset for the
        // bluetooth events to resolve conflicts in event number.
#ifndef EVENT_BLUETOOTH_OFFSET
#define EVENT_BLUETOOTH_OFFSET 0
#endif
#ifndef	EVENT_BLUETOOTH_BASE
#define	EVENT_BLUETOOTH_BASE	EVENT_GENERIC_BASE
#endif

        // This event indicates that a Bluetooth device has been attached.
        // When USB_HOST_APP_EVENT_HANDLER is called with this event, *data
        // points to a BLUETOOTH_DEVICE_ID structure, and size is the size of the
        // BLUETOOTH_DEVICE_ID structure.
#define EVENT_BLUETOOTH_ATTACH  (EVENT_BLUETOOTH_BASE+EVENT_BLUETOOTH_OFFSET+0)

        // This event indicates that the specified device has been detached
        // from the USB.  When USB_HOST_APP_EVENT_HANDLER is called with this
        // event, *data points to a BYTE that contains the device address, and
        // size is the size of a BYTE.
#define EVENT_BLUETOOTH_DETACH  (EVENT_BLUETOOTH_BASE+EVENT_BLUETOOTH_OFFSET+1)

        // This event indicates that a previous write request has completed.
        // These events are enabled if USB Embedded Host transfer events are
        // enabled (USB_ENABLE_TRANSFER_EVENT is defined).  When
        // USB_HOST_APP_EVENT_HANDLER is called with this event, *data points
        // to the buffer that completed transmission, and size is the actual
        // number of bytes that were written to the device.
#define EVENT_BLUETOOTH_TX_CMD_DONE (EVENT_BLUETOOTH_BASE+EVENT_BLUETOOTH_OFFSET+2)

        // This event indicates that a previous write request has completed.
        // These events are enabled if USB Embedded Host transfer events are
        // enabled (USB_ENABLE_TRANSFER_EVENT is defined).  When
        // USB_HOST_APP_EVENT_HANDLER is called with this event, *data points
        // to the buffer that completed transmission, and size is the actual
        // number of bytes that were written to the device.
#define EVENT_BLUETOOTH_TX_ACL_DONE (EVENT_BLUETOOTH_BASE+EVENT_BLUETOOTH_OFFSET+3)

        // This event indicates that a previous read request has completed.
        // These events are enabled if USB Embedded Host transfer events are
        // enabled (USB_ENABLE_TRANSFER_EVENT is defined).  When
        // USB_HOST_APP_EVENT_HANDLER is called with this event, *data points
        // to the receive buffer, and size is the actual number of bytes read
        // from the device.
#define EVENT_BLUETOOTH_RX_EVENT_DONE (EVENT_BLUETOOTH_BASE+EVENT_BLUETOOTH_OFFSET+4)

        // This event indicates that a previous read request has completed.
        // These events are enabled if USB Embedded Host transfer events are
        // enabled (USB_ENABLE_TRANSFER_EVENT is defined).  When
        // USB_HOST_APP_EVENT_HANDLER is called with this event, *data points
        // to the receive buffer, and size is the actual number of bytes read
        // from the device.
#define EVENT_BLUETOOTH_RX_ACL_DONE (EVENT_BLUETOOTH_BASE+EVENT_BLUETOOTH_OFFSET+5)

// *****************************************************************************
// *****************************************************************************
// Section: USB Data Structures
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Bluetooth Device ID Information

This structure contains identification information about an attached device.
*/
typedef struct _BLUETOOTH_DEVICE_ID
{
    WORD        vid;                    // Vendor ID of the device
    WORD        pid;                    // Product ID of the device
    #ifdef USB_BLUETOOTH_SUPPORT_SERIAL_NUMBERS
        WORD   *serialNumber;           // Pointer to the Unicode serial number string
        BYTE    serialNumberLength;     // Length of the serial number string (in Unicode characters)
    #endif
    BYTE        deviceAddress;          // Address of the device on the USB
} BLUETOOTH_DEVICE_ID;


// *****************************************************************************
/* Bluetooth Device Information

This structure contains information about an attached device, including
status flags and device identification.
*/
typedef struct _BLUETOOTH_DEVICE
{
    BLUETOOTH_DEVICE_ID   ID;             // Identification information about the device
    DWORD               rxAclLength;       // Number of bytes received in the last IN transfer
    DWORD               rxEventLength;       // Number of bytes received in the last IN transfer
    BYTE                clientDriverID; // ID to send when issuing a Device Request
    
    #ifndef USB_ENABLE_TRANSFER_EVENT
        BYTE            tx2ErrorCode;    // Error code of last OUT transfer
        BYTE            rxAclErrorCode;    // Error code of last IN transfer
        BYTE            rxEventErrorCode;    // Error code of last IN transfer
    #endif

    union
    {
        BYTE val;                       // BYTE representation of device status flags
        struct
        {
            BYTE initialized    : 1;    // Driver has been initialized
            BYTE txBusy         : 1;    // Driver busy transmitting data
            BYTE rxAclBusy         : 1;    // Driver busy receiving data
            BYTE rxEventBusy         : 1;    // Driver busy receiving data
            #ifdef USB_BLUETOOTH_SUPPORT_SERIAL_NUMBERS
                BYTE serialNumberValid    : 1;    // Serial number is valid
            #endif
        };
    } flags;                            // Bluetooth client driver status flags

} BLUETOOTH_DEVICE;


// *****************************************************************************
// *****************************************************************************
// Section: Global Variables
// *****************************************************************************
// *****************************************************************************

extern BLUETOOTH_DEVICE   gc_DevData; // Information about the attached device.

// *****************************************************************************
// *****************************************************************************
// Section: Host Stack Interface Functions
// *****************************************************************************
// *****************************************************************************

/****************************************************************************
  Function:
    BOOL USBHostBluetoothInit ( BYTE address, DWORD flags, BYTE clientDriverID )

  Summary:
    This function is called by the USB Embedded Host layer when a "bluetooth"
    device attaches.

  Description:
    This routine is a call out from the USB Embedded Host layer to the USB
    bluetooth client driver.  It is called when a "bluetooth" device has been
    connected to the host.  Its purpose is to initialize and activate the USB
    Bluetooth client driver.

  Preconditions:
    The device has been configured.

  Parameters:
    BYTE address    - Device's address on the bus
    DWORD flags     - Initialization flags
    BYTE clientDriverID - ID to send when issuing a Device Request via
                            USBHostIssueDeviceRequest(), USBHostSetDeviceConfiguration(),
                            or USBHostSetDeviceInterface().  

  Return Values:
    TRUE    - Initialization was successful
    FALSE   - Initialization failed

  Remarks:
    Multiple client drivers may be used in a single application.  The USB
    Embedded Host layer will call the initialize routine required for the
    attached device.
  ***************************************************************************/

BOOL USBHostBluetoothInit ( BYTE address, DWORD flags, BYTE clientDriverID );


/****************************************************************************
  Function:
    BOOL USBHostBluetoothEventHandler ( BYTE address, USB_EVENT event,
                            void *data, DWORD size )

  Summary:
    This routine is called by the Host layer to notify the general client of
    events that occur.

  Description:
    This routine is called by the Host layer to notify the general client of
    events that occur.  If the event is recognized, it is handled and the
    routine returns TRUE.  Otherwise, it is ignored and the routine returns
    FALSE.

  Preconditions:
    None

  Parameters:
    BYTE address    - Address of device with the event
    USB_EVENT event - The bus event that occured
    void *data      - Pointer to event-specific data
    DWORD size      - Size of the event-specific data
  Return Values:
    TRUE    - The event was handled
    FALSE   - The event was not handled

  Remarks:
    None
  ***************************************************************************/

BOOL USBHostBluetoothEventHandler ( BYTE address, USB_EVENT event, void *data, DWORD size );


// *****************************************************************************
// *****************************************************************************
// Section: Function Prototypes and Macro Functions
// *****************************************************************************
// *****************************************************************************

/****************************************************************************
  Function:
    BOOL API_VALID( BYTE address )

  Description:
    This function is used internally to ensure that the requested device is
    attached and initialized before performing an operation.

  Preconditions:
    None

  Parameters:
    BYTE address    - USB address of the device

  Returns:
    TRUE    - A device with the requested address is attached and initialized.
    FALSE   - A device with the requested address is not available, or it
                has not been initialized.

  Remarks:
    None
  ***************************************************************************/

#define API_VALID(a) ( (((a)==gc_DevData.ID.deviceAddress) && gc_DevData.flags.initialized == 1) ? TRUE : FALSE )


/****************************************************************************
  Function:
    BOOL USBHostBluetoothDeviceDetached( BYTE deviceAddress )

  Description:
    This interface is used to check if the devich has been detached from the
    bus.

  Preconditions:
    None

  Parameters:
    deviceAddress     - USB Address of the device.

  Return Values:
    TRUE    - The device has been detached, or an invalid deviceAddress is given.
    FALSE   - The device is attached

  Example:
    <code>
    if (USBHostBluetoothDeviceDetached( deviceAddress ))
    {
        // Handle detach
    }
    </code>

  Remarks:
    None
  ***************************************************************************/

#define USBHostBluetoothDeviceDetached(a) ( (((a)==gc_DevData.ID.deviceAddress) && gc_DevData.flags.initialized == 1) ? FALSE : TRUE )
//BOOL USBHostBluetoothDeviceDetached( BYTE deviceAddress );


/****************************************************************************
  Function:
    BOOL USBHostBluetoothGetDeviceAddress(BLUETOOTH_DEVICE_ID *pDevID)

  Description:
    This interface is used get the address of a specific bluetooth device on
    the USB.

  Preconditions:
    The device must be connected and enumerated.

  Parameters:
    pDevID  - Pointer to a structure containing the Device ID Info (VID,
                    PID, serial number, and device address).

  Return Values:
    TRUE    - The device is connected
    FALSE   - The device is not connected.

  Example:
    <code>
    BLUETOOTH_DEVICE_ID   deviceID;
    WORD                serialNumber[] = { '1', '2', '3', '4', '5', '6' };
    BYTE                deviceAddress;

    deviceID.vid          = 0x1234;
    deviceID.pid          = 0x5678;
    deviceID.serialNumber = &serialNumber;

    if (USBHostBluetoothGetDeviceAddress(&deviceID))
    {
        deviceAddress = deviceID.deviceAddress;
    }
    </code>

  Remarks:
    None
  ***************************************************************************/

BOOL USBHostBluetoothGetDeviceAddress(BLUETOOTH_DEVICE_ID *pDevID);


/****************************************************************************
  Function:
    DWORD USBHostBluetoothGetRxAclLength( BYTE deviceAddress )

  Description:
    This function retrieves the number of bytes copied to user's buffer by
    the most recent call to the USBHostBluetoothRead() function.

  Preconditions:
    The device must be connected and enumerated.

  Parameters:
    deviceAddress     - USB Address of the device

  Returns:
    Returns the number of bytes most recently received from the Bluetooth
    device with address deviceAddress.

  Remarks:
    This function can only be called once per transfer.  Subsequent calls will
    return zero until new data has been received.
  ***************************************************************************/

#define USBHostBluetoothGetRxAclLength(a) ( (API_VALID(a)) ? gc_DevData.rxAclLength : 0 )
//DWORD USBHostBluetoothGetRxAclLength( BYTE deviceAddress );

/****************************************************************************
  Function:
    DWORD USBHostBluetoothGetRxEventLength( BYTE deviceAddress )

  Description:
    This function retrieves the number of bytes copied to user's buffer by
    the most recent call to the USBHostBluetoothRead() function.

  Preconditions:
    The device must be connected and enumerated.

  Parameters:
    deviceAddress     - USB Address of the device

  Returns:
    Returns the number of bytes most recently received from the Bluetooth
    device with address deviceAddress.

  Remarks:
    This function can only be called once per transfer.  Subsequent calls will
    return zero until new data has been received.
  ***************************************************************************/

#define USBHostBluetoothGetRxEventLength(a) ( (API_VALID(a)) ? gc_DevData.rxEventLength : 0 )
//DWORD USBHostBluetoothGetRxEventLength( BYTE deviceAddress );


/****************************************************************************
  Function:
    void USBHostBluetoothReadAcl( BYTE deviceAddress, BYTE *buffer, DWORD length )

  Description:
    Use this routine to receive from the device and store it into memory.

  Preconditions:
    The device must be connected and enumerated.

  Parameters:
    deviceAddress  - USB Address of the device.
    buffer         - Pointer to the data buffer
    length         - Number of bytes to be transferred

  Return Values:
    USB_SUCCESS         - The Read was started successfully
    (USB error code)    - The Read was not started.  See USBHostRead() for
                            a list of errors.

  Example:
    <code>
    if (!USBHostBluetoothRxAclIsBusy( deviceAddress ))
    {
        USBHostBluetoothReadAcl( deviceAddress, &buffer, sizeof(buffer) );
    }
    </code>

  Remarks:
    None
  ***************************************************************************/

BYTE USBHostBluetoothReadAcl( BYTE deviceAddress, void *buffer, DWORD length);

/****************************************************************************
  Function:
    void USBHostBluetoothReadEvent( BYTE deviceAddress, BYTE *buffer, DWORD length )

  Description:
    Use this routine to receive from the device and store it into memory.

  Preconditions:
    The device must be connected and enumerated.

  Parameters:
    deviceAddress  - USB Address of the device.
    buffer         - Pointer to the data buffer
    length         - Number of bytes to be transferred

  Return Values:
    USB_SUCCESS         - The Read was started successfully
    (USB error code)    - The Read was not started.  See USBHostRead() for
                            a list of errors.

  Example:
    <code>
    if (!USBHostBluetoothRxEventIsBusy( deviceAddress ))
    {
        USBHostBluetoothReadEvent( deviceAddress, &buffer, sizeof(buffer) );
    }
    </code>

  Remarks:
    None
  ***************************************************************************/

BYTE USBHostBluetoothReadEvent( BYTE deviceAddress, void *buffer, DWORD length);

/****************************************************************************
  Function:
    BOOL USBHostBluetoothRxAclIsBusy( BYTE deviceAddress )

  Summary:
    This interface is used to check if the client driver is currently busy
    receiving data from the device.

  Description:
    This interface is used to check if the client driver is currently busy
    receiving data from the device.  This function is intended for use with
    transfer events.  With polling, the function USBHostBluetoothRxIsComplete()
    should be used.

  Preconditions:
    The device must be connected and enumerated.

  Parameters:
    deviceAddress     - USB Address of the device

  Return Values:
    TRUE    - The device is receiving data or an invalid deviceAddress is
                given.
    FALSE   - The device is not receiving data

  Example:
    <code>
    if (!USBHostBluetoothRxAclIsBusy( deviceAddress ))
    {
        USBHostBluetoothRead2( deviceAddress, &buffer, sizeof( buffer ) );
    }
    </code>

  Remarks:
    None
  ***************************************************************************/

#define USBHostBluetoothRxAclIsBusy(a) ( (API_VALID(a)) ? ((gc_DevData.flags.rxAclBusy == 1) ? TRUE : FALSE) : TRUE )
//BOOL USBHostBluetoothRxAclIsBusy( BYTE deviceAddress );

/****************************************************************************
  Function:
    BOOL USBHostBluetoothRxEventIsBusy( BYTE deviceAddress )

  Summary:
    This interface is used to check if the client driver is currently busy
    receiving data from the device.

  Description:
    This interface is used to check if the client driver is currently busy
    receiving data from the device.  This function is intended for use with
    transfer events.  With polling, the function USBHostBluetoothRxIsComplete()
    should be used.

  Preconditions:
    The device must be connected and enumerated.

  Parameters:
    deviceAddress     - USB Address of the device

  Return Values:
    TRUE    - The device is receiving data or an invalid deviceAddress is
                given.
    FALSE   - The device is not receiving data

  Example:
    <code>
    if (!USBHostBluetoothRxEventIsBusy( deviceAddress ))
    {
        USBHostBluetoothRead1( deviceAddress, &buffer, sizeof( buffer ) );
    }
    </code>

  Remarks:
    None
  ***************************************************************************/

#define USBHostBluetoothRxEventIsBusy(a) ( (API_VALID(a)) ? ((gc_DevData.flags.rxEventBusy == 1) ? TRUE : FALSE) : TRUE )
//BOOL USBHostBluetoothRxEventIsBusy( BYTE deviceAddress );

/****************************************************************************
  Function:
    BOOL USBHostBluetoothRxAclIsComplete( BYTE deviceAddress, BYTE *errorCode,
                DWORD *byteCount )

  Summary:
    This routine indicates whether or not the last IN transfer is complete.

  Description:
    This routine indicates whether or not the last IN transfer is complete.
    If it is, then the returned errorCode and byteCount are valid, and
    reflect the error code and the number of bytes received.

    This function is intended for use with polling.  With transfer events,
    the function USBHostBluetoothRxIsBusy() should be used.

  Preconditions:
    None

  Parameters:
    BYTE deviceAddress  - Address of the attached peripheral
    BYTE *errorCode     - Error code of the last transfer, if complete
    DWORD *byteCount    - Bytes transferred during the last transfer, if
                            complete

  Return Values:
    TRUE    - The IN transfer is complete.  errorCode and byteCount are valid.
    FALSE   - The IN transfer is not complete.  errorCode and byteCount are
                invalid.

  Remarks:
    None
  ***************************************************************************/

BOOL USBHostBluetoothRxAclIsComplete( BYTE deviceAddress,
                                    BYTE *errorCode, DWORD *byteCount );

/****************************************************************************
  Function:
    BOOL USBHostBluetoothRxEventIsComplete( BYTE deviceAddress, BYTE *errorCode,
                DWORD *byteCount )

  Summary:
    This routine indicates whether or not the last IN transfer is complete.

  Description:
    This routine indicates whether or not the last IN transfer is complete.
    If it is, then the returned errorCode and byteCount are valid, and
    reflect the error code and the number of bytes received.

    This function is intended for use with polling.  With transfer events,
    the function USBHostBluetoothRxIsBusy() should be used.

  Preconditions:
    None

  Parameters:
    BYTE deviceAddress  - Address of the attached peripheral
    BYTE *errorCode     - Error code of the last transfer, if complete
    DWORD *byteCount    - Bytes transferred during the last transfer, if
                            complete

  Return Values:
    TRUE    - The IN transfer is complete.  errorCode and byteCount are valid.
    FALSE   - The IN transfer is not complete.  errorCode and byteCount are
                invalid.

  Remarks:
    None
  ***************************************************************************/

BOOL USBHostBluetoothRxEventIsComplete( BYTE deviceAddress,
                                    BYTE *errorCode, DWORD *byteCount );


/****************************************************************************
  Function:
    void USBHostBluetoothTasks( void )

  Summary:
    This routine is used if transfer events are not utilized. It monitors the
    host status and updates the transmit and receive flags.

  Description:
    This routine is used if transfer events are not utilized. It monitors the
    host status and updates the transmit and receive flags.  If serial
    numbers are supported, then this routine handles the reception of the
    serial number.

  Preconditions:
    None

  Parameters:
    None

  Returns:
    None

  Remarks:
    This function is compiled only if USB_ENABLE_TRANSFER_EVENT is not
    defined.
  ***************************************************************************/

#ifndef USB_ENABLE_TRANSFER_EVENT
void USBHostBluetoothTasks( void );
#endif

#define USBHostBluetoothTx2IsBusy(a) ( (API_VALID(a)) ? ((gc_DevData.flags.tx2Busy == 1) ? TRUE : FALSE) : TRUE )
BOOL USBHostBluetoothTx2IsComplete( BYTE deviceAddress, BYTE *errorCode );
BYTE USBHostBluetoothWriteAcl( BYTE deviceAddress, void *buffer, DWORD length);
BYTE USBHostBluetoothWriteCmd( BYTE deviceAddress, void *buffer, WORD wLength );

#endif
