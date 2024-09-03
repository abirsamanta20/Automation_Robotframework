*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://demoqa.com/text-box
${NAME}       Abir Samanta
${EMAIL}      abirsamanta58752@gmail.com
${CURRENT_ADDRESS}    New Town, Kolkata, West Bengal
${PERMANENT_ADDRESS}   Purba Medinipur, West Bengal-721144

*** Test Cases ***
Submit_Form_And_Click_Radio_Button
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login to Application
    Close Browser
*** Keywords ***
Login to Application

    Click Element    xpath://*[@id='item-0']
    Input Text    xpath://*[@id='userName']    ${NAME}
    Input Text    xpath://*[@id='userEmail']    ${EMAIL}
    Input Text    xpath://*[@id='currentAddress']    ${CURRENT_ADDRESS}
    Input Text    xpath://*[@id='permanentAddress']    ${PERMANENT_ADDRESS}
    sleep    2s
    Execute JavaScript    window.scrollTo(0, document.getElementById('submit').getBoundingClientRect().top)
    Scroll Element Into View    xpath://*[@id="submit"]

    Sleep    2s
#check box............
    Scroll Element Into View    xpath://*[@id="item-1"]
    Click Element    xpath://*[@id="item-1"]
    Sleep    2s
    Execute JavaScript    document.querySelector('label[for="tree-node-home"]').click();

    Sleep    2s
#radio button.......    
    Scroll Element Into View    xpath://*[@id="item-2"]
    Click Element     xpath://*[@id="item-2"]
    Sleep    15s
    Scroll Element Into View    xpath://*[@id="app"]/div/div/div/div[2]/div[2]/div[2]/label
    Click Element    xpath://*[@id="app"]/div/div/div/div[2]/div[2]/div[2]/label
    Sleep    2s
#web table..........   
    Scroll Element Into View    xpath://li[@id="item-3"]
    Click Element    xpath://*[@id="item-3"]
    ${cols} =    Get Element Count    xpath://*[@id="app"]/div/div/div/div[2]/div[2]/div[3]/div[1]/div[1]/div
    ${log_message_columns}=    Set Variable    Total columns in table: ${cols}
    Log To Console    ${log_message_columns}
    ${rows} =    Get Element Count    xpath://*[@id="app"]/div/div/div/div[2]/div[2]/div[3]/div[1]/div[2]/div
    ${log_message_rows}=    Set Variable    Total rows in table: ${rows}
    Log To Console    ${log_message_rows}
    Sleep    4s
#buttons click........
    Execute JavaScript    document.getElementById("item-4").click()
    Sleep    3s
    

    Execute JavaScript    actions = new MouseEvent('contextmenu', {bubbles: true, cancelable: true, view: window}); document.getElementById('rightClickBtn').dispatchEvent(actions);
    Sleep    2s

    Press keys   xpath://*[@id="app"]/div/div/div/div[2]/div[2]/div[3]/button   ENTER
    Sleep    5s

#link click........
# Link click........
    Execute JavaScript    document.getElementById("item-5").click();

    Wait Until Element Is Visible    id=simpleLink
    Click Link    id=simpleLink
    Sleep    5s

    # Click Link    id=simpleLink
    # Sleep    2s




