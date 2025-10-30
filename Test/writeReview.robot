*** Settings ***
Library    SeleniumLibrary
Resource   ..//Resources//shoppingCart_kw.resource
Resource   ..//Resources//checkoutPage_kw.resource
Resource   ..//Resources//history_kw.resource
Resource   ..//Resources//common.resource
Documentation     Este test buscara un elemento indicado para posteriormente agregarlo X
...             veces, luego de eso escribira un review en dicho elemento

*** Test Cases ***
Look for HP and write a review
    Store page is loaded
    Write a review








    
