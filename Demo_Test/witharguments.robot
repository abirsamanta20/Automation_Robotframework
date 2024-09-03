*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${URL}        https://demo.nopcommerce.com
${BROWSER}    Chrome


*** Test Cases ***
LoginTest   
    login application    ${URL}    ${BROWSER}
    Sleep    5s
    Close Browser

*** Keywords ***
login application
    [Arguments]    ${webpagelink}    ${webbrowser}
    Open Browser   ${webpagelink}    ${webbrowser} 
    Maximize Browser Window
    Click Element    xpath://*[@class="ico-login"]
    Input Text    xpath://*[@id="Email"]    abirsamanta53@gmail.com
    Input Password    xpath://*[@id="Password"]    Abirsamanta@24
    Click Element    xpath://button[@class="button-1 login-button"]