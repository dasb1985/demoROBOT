*** Variables ***

${orderDetail_btn}=    xpath=(//table[contains(@class,'table') and contains(@class,'table-bordered')]//tbody/tr)[1]//a[contains(@class,'btn-info')]
${myAccount_btn}=    xpath=//a[@title='My Account']
${maLogout_btn}=    xpath=//ul[contains(@class,'dropdown-menu-right')]//a[text()='Logout']


${orderDetails_tbl}=    xpath=//div[@id='content']//table[contains(@class,'table') and contains(@class,'table-bordered')]//tbody/tr

${productDetailsCount_tbl}=    xpath=//div[@id='content']//table[.//thead/tr/td[contains(text(),'Product Name')]]//tbody
${productDetails_tbl}=    xpath=//div[@id='content']//table[.//thead/tr/td[contains(text(),'Product Name')]]

${orderHistory_tbl}=    xpath=//div[@id='content']//table[.//thead/tr/td[contains(text(),'Status')]]//tbody



${pending_txt}=    Pending