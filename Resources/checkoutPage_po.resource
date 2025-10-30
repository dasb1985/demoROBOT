*** Variables ***
${registerAccount_radioBtn}=    xpath=//input[@type='radio' and @name='account' and @value='register']
${guestAccount_radioBtn}=    xpath=//input[@type='radio' and @name='account' and @value='guest']
${cashOnDelivery_radioBtn}=    xpath=//label[contains(normalize-space(.), 'Cash On Delivery')]/input[@type='radio' and @name='payment_method']

${continueToBIlling_btn}=        xpath=//*[@id="button-account"]
${continueToDeliveryAsNew_btn}=    xpath=//*[@id="button-register"]
${continueToDeliveryMethodAsNew_btn}    xpath=//*[@id="button-shipping-address"]
${continueToDelivery_btn}=        xpath=//input[@type='button' and @id='button-guest' and @value='Continue']
${continueToPayment_btn}=    xpath=//div[@id='collapse-shipping-method']//input[@type='button' and @id='button-shipping-method']
${continueToConfirmOrder_btn}=    xpath=//input[@type='button' and @id='button-payment-method']
${confirmOrder_btn}=    xpath=//*[@id="button-confirm"] 



#Checkbox
${acceptTermsAndCondition_chk}=    xpath=//*[@id="collapse-payment-address"]/div/div[4]/div/input[1]
${acceptTermsAndConditionfromPayment_chk}=    xpath=//*[@id="collapse-payment-method"]/div/div[3]/div/input[1]


#Links
${acoountHistory_link}=    //*[@id="content"]/p[2]/a[2]

#Input elements for registration
${name_inp}=    id=input-payment-firstname
${lastnmae_inp}=    id=input-payment-lastname
${email_inp}=    id=input-payment-email
${phone_inp}=    id=input-payment-telephone
${address1_inp}=    id=input-payment-address-1 
${city_inp}=    id=input-payment-city
${postcode_inp}=    id=input-payment-postcode
${country_inp}=    name=country_id
${region_inp}=    name=zone_id
${pass_inp}=    id=input-payment-password
${passConfirm_inp}=    id=input-payment-confirm 


${resumeOrder_tbl}=    xpath=//div[@id='collapse-checkout-confirm']//table[contains(@class,'table') and contains(@class,'table-bordered')]


${placeholder_order}=    xpath=//*[@id="content"]/h1
#Text and messages
${shippingDescription}=    xpath=//input[@type='radio' and @name='shipping_method']/parent::label
${expectedShipping}=    Flat Shipping Rate - $5.00
${orderPlaced}=    Your order has been placed!