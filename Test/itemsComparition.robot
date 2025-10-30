*** Settings ***
Library    SeleniumLibrary
Resource   ..//Resources//shoppingCart_kw.resource
Resource   ..//Resources//checkoutPage_kw.resource
Resource   ..//Resources//history_kw.resource
Resource   ..//Resources//common.resource
Documentation     Este test realizara una comparacion entre dos elementos para luego obtener un cuadro de comapracion


*** Test Cases ***
Comparation test
    Store page is loaded
    Search product: Apple Cinema 30 for comparision
    Search product: Samsung SyncMaster 941BW for comparision
    Go to product comparition page









    
