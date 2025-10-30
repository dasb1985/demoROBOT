*** Settings ***
Resource   ..//Resources//common_po.resource
Library    SeleniumLibrary

*** Keywords ***
Store page is loaded
    Open Browser    ${url}        Chrome
    Maximize Browser Window
    ${title}=        Get Title
    Should Be Equal    ${title}    ${pageTitle_txt}   
    Sleep  2s
