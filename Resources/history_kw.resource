*** Settings ***
Resource   ..//Resources//history_po.resource
Library    Collections
Library    SeleniumLibrary

*** Keywords ***

Check order
    [Documentation]    Esto esta diseñado para obtener la tabla con los items, recorrerla, realizar un diccionario de dicha tabla en python,
    ...    y posteriormente en base a listas realizar la comparacion de todos los elementos de las tablas
    Click Element    ${orderDetail_btn}
    Sleep   2s
    Capture Page Screenshot    selenium-history-{index}.png
    ${orderDetails}=     Get Text   ${orderDetails_tbl}
    Log    ${orderDetails}

    ${rows}=    Get Element Count    ${productDetailsCount_tbl}
    @{products}=    Create List
    FOR    ${i}    IN RANGE    1    ${rows + 1}
        ${name}=       Get Table Cell    ${productDetails_tbl}    ${i}    1
        ${model}=      Get Table Cell    ${productDetails_tbl}    ${i}    2
        ${quantity}=   Get Table Cell    ${productDetails_tbl}    ${i}    3
        ${price}=      Get Table Cell    ${productDetails_tbl}    ${i}    4
        ${total}=      Get Table Cell    ${productDetails_tbl}    ${i}    5
        &{product}=    Create Dictionary    name=${name}    model=${model}    quantity=${quantity}    price=${price}    total=${total}
        Append To List    ${products}    ${product}
    END

    &{expected1}=    Create Dictionary    name=iMac    model=Product 14    quantity=1    price=$100.00    total=$100.00
    &{expected2}=    Create Dictionary    name=iPod Classic    model=product20    quantity=1    price=$100.00    total=$100.00
    @{expected}=    Create List    ${expected1}    ${expected2}
    Lists Should Be Equal    @{products}    @{expected}
    ${statusDetail}=    Get Text    ${orderHistory_tbl}
    Log    ${statusDetail}
    Should Contain    ${statusDetail}    ${pending_txt}


Logout from page
    Click Element    ${myAccount_btn}
    Sleep     2s
    Click Element    ${maLogout_btn}

