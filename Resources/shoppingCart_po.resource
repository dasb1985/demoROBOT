*** Variables ***
${search_input}=    name=search
${date_input}=    id=input-option225
${quantity_input}=    id=input-quantity
${reviewName_input}=    id=input-name
${reviewDescription}=    id=input-review

#Buttons
${search_btn}=            xpath=//button[@class="btn btn-default btn-lg"]
${addToCart_btn}=         xpath=//button[@type="button" and contains(@onclick, "cart.add")]
${addToComparation_btn}=         xpath=//button[@type="button" and contains(@onclick, "compare.add")]
${addToCartTwo_btn}=    id=button-cart
${displayCart_btn}=       xpath=//div[@id="cart"]/button
${cart_btn}=              xpath=//div[@id="cart"]//ul
${hpLaptop_img}=        xpath=//*[@id="content"]/div[3]/div/div/div[1]/a/img
${reviewContinue_btn}=    xpath=//*[@id="button-review"]

${checkout_menu_btn}=     xpath=//a[contains(@href, 'checkout/checkout')]

#Text Locators
${alert_text_locator}=    xpath=//div[contains(@class, "alert-success")]
${alert_text_comparation}=    xpath=//*[@id="product-search"]/div[1]
${alert_review_success}=    xpath=//*[@id="form-review"]/div[2]
${cart_information}=    xpath=//div[@id="cart"]//ul

${checkout_txt}=    Checkout
${loremIpsum_txt}=    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
${16GB_txt}=    16GB
${reviewName_txt}=    Daniel Sanchez Says
${reviewSuccess_txt}=    Thank you for your review. It has been submitted to the webmaster for approval.

#link
${specification_lnk}=    xpath=//*[@id="content"]/div/div[1]/ul[2]/li[2]/a
${review_lnk}=    xpath=//*[@id="content"]/div/div[2]/div[3]/p/a[2]
${comparision_lnk}=    xpath=//*[@id="product-search"]/div[1]/a[2]

#tables
${specification_tbl}=    xpath=//*[@id="tab-specification"]/table/tbody[1]

${ratingGropu_rbtn}=    rating

${table_anchor_for_ScreenShoot}=    xpath=//*[@id="content"]/table/tbody[3]/tr/td[2]