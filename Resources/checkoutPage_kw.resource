*** Settings ***
Resource   ..//Resources//checkoutPage_po.resource
Library    RPA.Excel.Files
Library    Collections
Library    SeleniumLibrary

*** Keywords ***
Continue as guest user
    [Documentation]    Opcion para continuar el proceso como invitado
    Sleep    2s
    Click Button    ${guestAccount_radioBtn}
    Click Button    ${continueToBIlling_btn}

Continue creating new account
    [Documentation]    Seleccion para comenzar flujo de crear una cuenta    
    Sleep   2s
     Click Button    ${registerAccount_radioBtn}
     Click Button    ${continueToBIlling_btn}

Fillup personal data
    [Documentation]    Completara datos personales
    Sleep  2s
    Look for user on data file   ${idVarPrincipal}
    Input Text    ${name_inp}    ${excelName}
    Input Text    ${lastnmae_inp}     ${excelLastname}
    Input Text    ${email_inp}          ${excelMail}
    Input Text    ${phone_inp}      ${excelPhone}
    

Fillup address data
    [Documentation]    Completara datos de direccion
    Input Text    ${address1_inp}  ${excelAddres1} 
    Input Text    ${city_inp}         ${excelCity}
    Input Text    ${postcode_inp}       ${excelPostCode}
    Select From List By Label    ${country_inp}      ${excelCountry}
    Sleep   2s
    Select From List By Label    ${region_inp}     ${excelRegion}

Fillup password data and continue to delivery
    [Documentation]    Ingresara campos de contraseña de forma segura, usando *** para mantener privacidad
    Input Password    ${pass_inp}    ${excelPAss}
    Input Password    ${passConfirm_inp}   ${excelPAss}
    Click Element    ${acceptTermsAndCondition_chk}
    Capture Page Screenshot    screenshot-createdAccount-{index}.png
    Click Button    ${continueToDeliveryAsNew_btn}

Deliver Detailsy continue
    [Documentation]    Pasamos por seccion con los detalles del delivery
    Sleep   2s
    Capture Page Screenshot      selenium-Checkout-{index}.png  
    Click Button    ${continueToDeliveryMethodAsNew_btn}
                
Continue to Delivery Method section
    Click Button    ${continueToDelivery_btn}


Validate Type and shippingRate
    [Documentation]    Revisamos que el tipo y el shipping sea el solicitado en prueba
    Sleep   3s
    ${message}=    Get Text    ${shippingDescription}
    Should Be Equal    ${message}    ${expectedShipping}
    Capture Page Screenshot    screenshot-deliveryMehotd-{index}.png
    Click Button    ${continueToPayment_btn}


Select payment method
    [Documentation]    Seleccionamos metodo de pago, en este caso Cash On Delivery
    Sleep   2s
    Click Button    ${cashOnDelivery_radioBtn}
    Select Checkbox    ${acceptTermsAndConditionfromPayment_chk}
     Capture Page Screenshot    screenshot-paymentMethod-{index}.png
    Click Button    ${continueToConfirmOrder_btn}

Check final amounts 
    Sleep   2s
    Capture Page Screenshot    screenshot-confirmOrder-{index}.png
    ${test}=    Get Table Cell    ${resumeOrder_tbl}    row=2    column=2
    Log    ${test}

Confirm order
    Click Button      ${confirmOrder_btn} 


Validate order has been placed
    [Documentation]    Validaremos que la orden ha sido finalizada correctamente
    Sleep    2s
    ${order_placed}=     Get Title
    Should Be Equal    ${order_placed}    ${orderPlaced}

    ${full_text}=    Get Text    ${placeholder_order}
    Log    message=${full_text}
    Should Be Equal    ${full_text}        ${orderPlaced}



Look for user on data file
    [Arguments]  ${excelID}
    [Documentation]    Cargaremos archivo excel con usuarios en memoria, para luego recorrerlo y buscar el ID del usuario que queremos usar
    Open Workbook    Data/usuarios.xlsx
    ${data}=         Read Worksheet As Table    header=True
    Close Workbook

    FOR    ${row}    IN    @{data}
        ${id}=    Set Variable    ${row}[id]
        Run Keyword If    '${id}' == '${excelID}'    Set Test Variable    ${user}    ${row}
    END
    Read info to variables    ${user} 


Read info to variables
    [Arguments]    ${userToRead}
    [Documentation]    Una vez capturado el usuario, tomamos la data y la dejamos disponible para el test
    Log    ${userToRead}
    Set Test Variable    ${ID}    ${userToRead}[id]
    Set Test Variable    ${excelName}    ${userToRead}[nombre]
    Set Test Variable  ${excelLastname}     ${userToRead}[apellido]
    Set Test Variable    ${excelMail}    ${userToRead}[correo]
    Set Test Variable    ${excelPAss}    ${userToRead}[pass]
    Set Test Variable     ${excelPhone}    ${userToRead}[telefono]
    Set Test Variable    ${excelAddres1}    ${userToRead}[direccion1]
    Set Test Variable  ${excelCity}     ${userToRead}[ciudad]
    Set Test Variable   ${excelPostCode}    ${userToRead}[postcode]
    Set Test Variable   ${excelCountry}     ${userToRead}[pais]
    Set Test Variable     ${excelRegion}    ${userToRead}[region]



Go to history page
    [Documentation]    Iremos al Historial de compras
    CLick Element    ${acoountHistory_link}
    Sleep   2s



