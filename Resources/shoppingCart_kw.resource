*** Settings ***
Resource   ..//Resources//shoppingCart_po.resource
Library    SeleniumLibrary
Library    DateTime

*** Keywords ***

Search product: ${name_product} for add to cart
    [Documentation]    Esta keyword esta creada con el fin de buscar el producto indicado, agregarlo al carro y revisar que sea el correcto
    Input Text    ${search_input}    ${name_product}
    Click Button    ${search_btn}
    Click Button    ${addToCart_btn}
    Capture Page Screenshot    screenshot-${name_product}-{index}.png
    Sleep  2s
    #Successufully alert is displayed
    ${alert_text}=   Get Text    ${alert_text_locator}
    Log    ${alert_text}
    Should Contain  ${alert_text}    ${name_product}    ignore_case=True


Search product: ${name_product} for comparision
    [Documentation]    Siguiendo la keyword anterior como base agregara items para ser comparados
    Input Text    ${search_input}    ${name_product}
    Click Button    ${search_btn}
    Click Button    ${addToComparation_btn}
    Capture Page Screenshot    screenshot-${name_product}-{index}.png
    Sleep  2s
    #Successufully alert is displayed
    Wait Until Element Is Visible    ${alert_text_comparation}
    ${alert_text}=   Get Text    ${alert_text_comparation}
    Log    ${alert_text}
    Should Contain  ${alert_text}    Success: You have added ${name_product}    ignore_case=True

Validate Cart Contains Items
    [Documentation]    Revisaremos que el carro cuente con los items indicados como entrada
    [Arguments]    @{expected_products}
    ${cart_text}=    Get Text    ${cart_information}
    FOR    ${product}    IN    @{expected_products}
        Should Contain    ${cart_text}    ${product}     ignore_case=True
        Log    ${cart_text}
    END

Deploy cartMenu and validate items
    [Documentation]    Despliega preview del carro
    Click Button    ${displayCart_btn}
    Validate Cart Contains Items    Ipod Classic   iMac
    Capture Page Screenshot     screenshot-itemsOnCart-{index}.png  
    Sleep  2s

 Go to checkout page
    Sleep   2s
    Click Element   ${checkout_menu_btn}
    ${checkoutTitle_txt}=    Get Title
    Should Be Equal    ${checkoutTitle_txt}    ${checkout_txt}


Pick item ${name_product} and added ${itemAmount} times
    [Documentation]    Esta funcion buscara un item y lo agregara X veces al carro
    Input Text    ${search_input}    ${name_product}
    Click Button    ${search_btn}
    Sleep  2s
    Scroll Element Into View        ${addToCart_btn}
    Click Image        ${hpLaptop_img}
    Sleep  2s
    Capture Page Screenshot    screenshot-${name_product}-{index}.png
    Check specification
    Pick Delivery Date
    Input Text    ${quantity_input}    ${itemAmount}
    Click Button    ${addToCartTwo_btn}


Check specification
    [Documentation]    Obtendremos el texto de la especificacion para su checkeo
    Click Element    ${specification_lnk}
    ${specificationText}=    Get Text    ${specification_tbl}
    Should Contain    ${specificationText}    item=${16GB_txt}

Pick Delivery Date
    [Documentation]    Generamos la fecha del dia de hoy en el formato de la pagina, para luego sumar un dia que sera ingresado al sitio
    ${varDate}=    Get Current Date    result_format=%Y-%m-%d
    Log    ${varDate}
    ${dateToDeliver}=    Add Time To Date    ${varDate}    1 day
    Input Text    ${date_input}    ${dateToDeliver}

Write a review
    [Documentation]    En esta seccion realizaremos la escritura de un review, asignaremos un rating para posteriormente ser enviado a revision.
    Click Element    ${review_lnk}
    Input Text    ${reviewName_input}    ${reviewName_txt}
    Input Text    ${reviewDescription}    ${loremIpsum_txt}
    Select Radio Button    group_name=${ratingGropu_rbtn}    value=3
    Capture Page Screenshot   selenium-review-{index}.png
    Click Button        ${reviewContinue_btn}
    Sleep   2s
    Wait Until Element Is Visible    ${alert_review_success}
    ${warningText}=    Get Text    ${alert_review_success}
    Should Be Equal    ${warningText}        ${reviewSuccess_txt}
    Capture Page Screenshot   selenium-review-{index}.png  


Go to product comparition page
    Click Element    ${comparision_lnk}
    Scroll Element Into View    ${table_anchor_for_ScreenShoot}
    Capture Page Screenshot       selenium-comparition-table-{index}.png
