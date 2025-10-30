*** Settings ***
Resource   ..//Resources//common_po.resource
Library    SeleniumLibrary

*** Keywords ***
Store page is loaded
    Open Browser    ${url}        Chrome
    ...    options=add_argument('--headless=new');
    ...    add_argument('--no-sandbox');
    ...    add_argument('--disable-dev-shm-usage');
    ...    add_argument('--user-data-dir=/tmp/chrome-user-${CURDIR}')
    
    Maximize Browser Window
    ${title}=        Get Title
    Should Be Equal    ${title}    ${pageTitle_txt}   
    Sleep  2s
