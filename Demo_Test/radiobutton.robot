*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://demoqa.com
${BROWSER}    Chrome

*** Test Cases ***
LoginTest
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login to Application
    # Set Selenium Speed  3s
    Close Browser

*** Keywords ***
Login to Application
    Click Element  xpath://*[@id='app']/div/div/div[2]/div/div[2]/div/div[2]/svg
    # sleep   3s
    # Click Element  xpath://*[@id='item-0']


   

  
    