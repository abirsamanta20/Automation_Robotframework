*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://demo.nopcommerce.com
${BROWSER}    Chrome
${UserName}   abirsamanta53@gmail.com
${Password}   Abirsamanta@24

*** Test Cases ***
LoginTest
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login to Application
    Sleep   5s
    Close Browser

*** Keywords ***
Login to Application
    Click Element  xpath://*[@class="ico-login"]
    Input Text    xpath://*[@class="email"]   ${UserName} 
    Sleep   3s
    Clear Element Text   xpath://*[@id="Email"] 
    sleep  3s
    Input Text    xpath://*[@class="email"]   ${UserName} 
    sleep  3s
   
    Input Text    xpath://*[@id="Password"]  ${Password} 
  
    Sleep   3s
    Click Element   xpath://*[@class="button-1 login-button"]
    sleep   3s
   
