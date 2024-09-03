*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://demo.nopcommerce.com
${BROWSER}    Chrome

*** Test Cases ***
LoginTest1   
    ${PageTitle}=   LoginApplication    ${URL}    ${BROWSER}
    Log To Console    ${PageTitle}
    Click Element    xpath://*[@class="ico-login"]
    Input Text    xpath://*[@id="Email"]    abirsamanta53@gmail.com
    Input Password    xpath://*[@id="Password"]    Abirsamanta@24

*** Keywords ***
LoginApplication
    [Arguments]    ${webpagelink}    ${webbrowser}
    Open Browser    ${webpagelink}    ${webbrowser}
    Maximize Browser Window
    ${title}    Get Title
    RETURN    ${title}
