*** Settings ***
Resource   ..//Resources//common_po.resource
Library    SeleniumLibrary

*** Keywords ***

Create options for Chrome
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}        add_argument        headless
    Call Method    ${options}        add_argument        no-sandbox
    Call Method    ${options}        add_argument        disable-dev-shm-usage
    Call Method    ${options}        add_argument        user-data-dir=${EXECDIR}
    RETURN    ${options}
    
Store page is loaded
    ${chrome_OPT}=    Create Options For Chrome
    Open Browser    ${url}        Chrome    chrome_options=${chrome_OPT}
    Maximize Browser Window
    ${title}=        Get Title
    Should Be Equal    ${title}    ${pageTitle_txt}   
    Sleep  2s
