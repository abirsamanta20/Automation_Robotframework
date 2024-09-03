*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://www.tutorialspoint.com/selenium/practice/text-box.php
${BROWSER}    Chrome


*** Test Cases ***
LoginTest
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    login application
    Close Browser

*** Keywords ***
login application
#Text box.........
    Input Text    xpath://*[@id="fullname"]      Abir Samanta
    Input Text    xpath://*[@id="email"]      abirsamanta6384@gmail.com
    Input Text    xpath://*[@id="address"]    Medinipur East, West Bengal-721144
    Input Text    xpath://*[@id="password"]    Abir@20  
    Click Element    xpath://*[@type="submit"]
    Sleep    3s   
    Click Element    xpath://*[@id="headingOne"]/button 
#check box.........
    Scroll Element Into View    xpath://*[@id="navMenus"]/li[2]/a
    Click Element    xpath://*[@id="navMenus"]/li[2]/a
    select checkbox    c_bs_2
#Radio button.........    
    Scroll Element Into View    xpath://*[@id="navMenus"]/li[3]/a
    Click Element    xpath://*[@id="navMenus"]/li[3]/a
    Click Element    xpath:/html/body/main/div/div/div[2]/form/div[1]/input
    Sleep    3s   
#web table.........    
    Scroll Element Into View    xpath: //*[@id="navMenus"]/li[4]/a
    Click Element    xpath: //*[@id="navMenus"]/li[4]/a
    ${cols} =    Get Element Count    xpath://table[@class="table table-striped mt-3"]/thead/tr/th
    ${log_message_cols}=    Set Variable    Total Columns in table: ${cols}
    Log To Console    ${log_message_cols}
    ${rows} =    Get Element Count    xpath://table[@class="table table-striped mt-3"]/tbody/tr
    ${log_message_rows}=    Set Variable    Total rows in table: ${rows}
    Log To Console    ${log_message_rows}
    ${data}    get text    xpath://table[@class="table table-striped mt-3"]/tbody/tr[4]/td[4]
    Log To Console    ${data}
    Table Column Should Contain    xpath://table[@class="table table-striped mt-3"]    4    Email
    Table Row Should Contain    xpath://table[@class="table table-striped mt-3"]    2    Alden
    Table Cell Should Contain   xpath://table[@class="table table-striped mt-3"]    4    4    kierra@example.com 
    Sleep    3s 

#Click Button...........
    Scroll Element Into View    xpath://*[@id="navMenus"]/li[5]/a
    Click Element    xpath://*[@id="navMenus"]/li[5]/a
    # Click Button    css:button.btn.btn-primary
    Click Button    css:.btn.btn-primary
    Sleep    2s
    Execute JavaScript    document.querySelector('[class="btn btn-success"]').dispatchEvent(new MouseEvent('dblclick'));
    Sleep    3s

#links click............
    Scroll Element Into View    xpath://*[@id="navMenus"]/li[6]/a
    Click Element    xpath://*[@id="navMenus"]/li[6]/a
    Click Link    xpath:/html/body/main/div/div/div[2]/p[1]/a
    Sleep    2s

#click image..........
    Scroll Element Into View    xpath://*[@id="navMenus"]/li[7]/a
    Click Element    xpath://*[@id="navMenus"]/li[7]/a
    Sleep    2s

#upload/download..........
    Scroll Element Into View    xpath://*[@id="navMenus"]/li[8]/a
    Click Element    xpath://*[@id="navMenus"]/li[8]/a
    ${upload_bin}    Set Variable    //input[@id="uploadFile"]
    Choose File    ${upload_bin}    C:\\Users\\USER\\Downloads\\image.jpg
    Sleep    2s
#forms........... 
    Scroll Element Into View    xpath://*[@id="headingTwo"]/button
    Click Element    xpath://*[@id="headingTwo"]/button
    Sleep    2s    
    Click Element    xpath://*[@id="collapseTwo"]/div/ul/li[1]/a
    Input Text    xpath://*[@placeholder="First Name"]    Abir Samanta
    Input Text    xpath://*[@name="email"]    abirsamanta36871@gmail.com
    Click Element    xpath://*[@id="gender"]

    Input Text    xpath://*[@name="mobile"]    1972012457
    Input Text    xpath://*[@placeholder="First Name"]    Abir Samanta
    
    # Click Element    xpath://*[@id="collapseTwo"]

    Sleep    3s
    
 


       
