*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

# Library   ${EXECDIR}\\utils\\commonFunctions\\getSupplementalID.py
Library   ${EXECDIR}//Testcase//nexcal//dictionary.py
# E:\robotframework_automation\Testcase\dictionary.py
*** Variables ***
${URL}            https://admin-nexcal.web.app/login
${BROWSER}        Chrome
# @{List}           abir    subir    arkajit    suman    riju    debasis
# &{dictionary}     member_id=13456624    member_ssn=427154789    member_first_name=Jjgbekjr    member_last_name=Kbeberer
# &{login}          UserName=david    Password=qwdf45tY@

*** Test Cases ***
LoginTestnexcal
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    LoginTestnexcal
    Login to Nexcal
    dependent details add
    Sleep   5s
    Close Browser

*** Keywords ***
LoginTestnexcal
    # Log To Console    ${List}[3]
    # Log To Console    ${dictionary['member_id']}  
    ${loginData}=   getLoginData 
     
    Click Element              xpath://*[@id="select-role-container"]/button/span[1]
    Sleep                      3s
    Click Element              xpath://*[@id="simple-menu"]/div[3]/ul/li[1]

    Clear Element Text        xpath://*[@name="user_id"]
    Input Text                xpath://*[@name="user_id"]    ${loginData['UserName']}
    Clear Element Text        xpath://*[@name="password"]
    Input Text                xpath://*[@name="password"]     ${loginData['Password']}
    Sleep                      2s
    Click Element              xpath://*[@class="button-label-with-icon"]

Login to Nexcal

#member details...............
    
    ${memberDetails}=   getmemberdata

    ${birthday}    Split String   ${memberDetails['member_dob']}   /
    ${dob_month}    Set Variable    ${birthday}[0]

    ${heir}    Split String    ${memberDetails['member_hire_date']}   /
    ${member_heir_month}    Set Variable    ${heir}[0]
    # Log To Console    --------------loginData--------------${memberDetails}

    Wait Until Element Is Visible    xpath://*[@id="admin-dashboard"]/ul/div[2]    timeout=10s
    Click Element    xpath://*[@id="admin-dashboard"]/ul/div[2]
    Sleep    2s

    Wait Until Element Is Visible    xpath://*[@id="root"]/div/div/main/div[2]/div[3]/div/div/div/div[1]/div[2]/div[3]/div[2]/div/div/div[1]/div[1]/div/div/div
    Click Element    xpath://*[@id="root"]/div/div/main/div[2]/div[3]/div/div/div/div[1]/div[2]/div[3]/div[2]/div/div/div[1]/div[1]/div/div/div
    Sleep    5s
    Click Element    xpath://*[@id="employer-dashboard"]/ul/div[2]
    Wait Until Element Is Visible    xpath://*[@id="pf-action-button-container"]/button[3]/span[1]/span[1]    timeout=5s
#     Click Element    xpath://*[@id="pf-action-button-container"]/button[3]/span[1]/span[1]
#     Sleep    3s
#     Input Text    xpath://*[@name="member_id"]    ${memberDetails['member_id']}
#     Input Text    xpath://*[@name="first_name"]    ${memberDetails['member_first_name']}
#     Input Text    xpath://*[@name="middle_name"]   ${memberDetails['member_middle_name']}
#     Input Text    xpath://*[@name="last_name"]    ${memberDetails['member_last_name']}

#     Sleep    3s

#     ${retries}=    Set Variable    10
#     ${text}=    Set Variable    ${memberDetails['member_ssn']}

#     ${SSN}=    Set Variable    xpath://*[@name="SSN"]
#     ${re_enter_ssn}=    Set Variable    xpath://*[@name="re_enter_SSN"]

#     FOR    ${counter}    IN RANGE    2
#         ${SSN_path}=    Set Variable    ${SSN}
#         IF    ${counter} != 0
#                 ${SSN_path}=    Set Variable    ${re_enter_ssn}
#         END
#         FOR    ${index}    IN RANGE    ${retries}
#             IF    ${index} != 0
#                 Press Keys        ${SSN_path}     CTRL+a+BACKSPACE
#             END
#             Press Keys    ${SSN_path}    ${text}
        
#             ${value}=    Get Element Attribute    ${SSN_path}    value

#             ${result}=    Evaluate    '${value.replace("-", "")}' == '${text}'
#             Exit For Loop If    ${result} == True
#         END   
#     END
   
#     ${current_date}=    Get Current Date    result_format=%m/%d/%Y
#     ${current_month_split}=    Split String    ${current_date}    /
#     ${current_month}=    Set Variable    ${current_month_split[0]}
# #date of birth of member..............   
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[2]/div[2]/div[7]/div/div[2]/div/div/div/button/span[1]
#     Wait Until Element Is Visible    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[1]/button[1]/span[1]/h6    timeout=5s
#     Click Element    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[1]/button[1]/span[1]/h6
#     Sleep    5s

#     Wait Until Element Is Visible    xpath://div[contains(@class, 'MuiPickersYear-root') and text()='${birthday}[2]']    timeout=10s
#     Click Element    xpath://div[contains(@class, 'MuiPickersYear-root') and text()='${birthday[2]}']
#     Sleep    5s 
#     IF    $current_month > $dob_month
#         ${first_clicker}=    Evaluate    int($current_month) - int($dob_month)
#         FOR    ${index}    IN RANGE    0    ${first_clicker}

#             Click Element    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[2]/div[1]/div[1]/button[1]/span[1]
#         END

#     ELSE
#         ${second_clicker}=    Evaluate    int($dob_month) - int($current_month)
#         FOR    ${index}    IN RANGE    0    ${second_clicker}
#             Click Element    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[2]/div[1]/div[1]/button[2]/span[1]
#         END
#     END

#     Wait Until Element Is Visible    xpath://button[contains(@class, 'MuiPickersDay-day')][.//p[text()='${birthday[1]}']]
#     Click Element    xpath://button[contains(@class, 'MuiPickersDay-day')][.//p[text()='${birthday[1]}']]
#     Sleep    3s

#     Click Element    xpath:/html/body/div[5]/div[3]/div/div[2]/button[2]/span[1]
#     Sleep    3s

# #date of birth of member..............    
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[2]/div[2]/div[8]/div/div[2]/div/div/div/button/span[1]
#     Wait Until Element Is Visible    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[1]/button[1]/span[1]/h6    timeout=5s
#     Click Element    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[1]/button[1]/span[1]/h6
#     Sleep    5s

#     Wait Until Element Is Visible    xpath://div[contains(@class, 'MuiPickersYear-root') and text()='${heir}[2]']    timeout=14s
#     Click Element    xpath://div[contains(@class, 'MuiPickersYear-root') and text()='${heir}[2]']
#     Sleep    5s

#     IF    $current_month > $member_heir_month
#         ${first_clicker}=    Evaluate    int($current_month) - int($member_heir_month)
#         FOR    ${index}    IN RANGE    0    ${first_clicker}
#             Click Element    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[2]/div[1]/div[1]/button[1]/span[1]
#         END

#     ELSE
#         ${second_clicker}=    Evaluate    int($member_heir_month) - int($current_month)
#         FOR    ${index}    IN RANGE    0    ${second_clicker}
#             Click Element    xpath:/html/body/div[5]/div[3]/div/div[1]/div/div[2]/div[1]/div[1]/button[2]/span[1]
#         END
#     END

#     Wait Until Element Is Visible    xpath://button[contains(@class, 'MuiPickersDay-day')][.//p[text()='${heir[1]}']]
#     Click Element    xpath://button[contains(@class, 'MuiPickersDay-day')][.//p[text()='${heir[1]}']]

#     Sleep    5s

#     Click Element    xpath:/html/body/div[5]/div[3]/div/div[2]/button[2]/span[1]
#     Sleep    5s

#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[2]/div[2]/div[9]/div/div[2]/div
#     Wait Until Element Is Visible    xpath://*[@data-value="${memberDetails['member_gender'].upper()}"]    timeout=20s
#     Click Element    xpath://*[@data-value="${memberDetails['member_gender'].upper()}"]
    
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[2]/div[2]/div[10]/div/div[2]/div
#     Wait Until Element Is Visible    xpath://*[@data-value="${memberDetails['member_marital_status'].upper()}"]    timeout=20s
#     Click Element    xpath://*[@data-value="${memberDetails['member_marital_status'].upper()}"]
    
#     sleep    3s
#     IF  $memberDetails['member_tobacco'] == 'Yes'
#         Click Element    xpath://*[@id="check-support"]/span[1]/span/span[1]
#     END
#     Sleep    2s
    
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[3]/div[2]/div[2]/div/div[2]/div/div
#     IF    $memberDetails['member_class'] == 'FT-Full Time'
#         Wait Until Element Is Visible    xpath://*[@data-value="FT - Full Time"]    timeout=10s
#         Click Element    xpath://*[@data-value="FT - Full Time"]   
#     END
       
#     Sleep    2
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[4]/div[2]/div[1]/div/div[2]/div/div
#     Wait Until Element Is Visible    xpath://*[@data-value="4"]    timeout=10s
#     Click Element    xpath://*[@data-value="4"]
#     Sleep    2s
    
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[4]/div[2]/div[3]/div/div[2]/div/div
#     Wait Until Element Is Visible    xpath://*[@data-value="MONTHLY"]    timeout=10s
#     Click Element    xpath://*[@data-value="MONTHLY"]
#     Sleep    2s
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[4]/div[2]/div[4]/div/div[2]/div/div
#     Wait Until Element Is Visible    xpath://*[@data-value="FLAT RATE"]    timeout=10s
#     Click Element    xpath://*[@data-value="FLAT RATE"]
#     Sleep    2s
#     Press Keys    xpath://*[@id="create-employee"]/div[2]/div[4]/div[2]/div[7]/div/div[2]/div/div    //12
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[4]/div[2]/div[8]/div/div[2]/div/div
#     Wait Until Element Is Visible    xpath://*[@data-value="Yes"]    timeout=10s
#     Click Element    xpath://*[@data-value="Yes"]
#     Sleep    2s
#     Click Element    xpath://*[@id="create-employee"]/div[2]/div[5]/div[2]/div[1]/div/div[2]/div/div
#     Wait Until Element Is Visible    xpath://*[@data-value="HOME"]    timeout=10s
#     Click Element    xpath://*[@data-value="HOME"]

#     Input Text    xpath://*[@name="email"]    ${memberDetails['member_gmail']}
#     Sleep    2s

#     Press Keys    xpath://*[@name="phone_number"]    ${memberDetails['member_ph']}
#     Sleep    2s
#     Press Keys    xpath://*[@name="phone_extension"]    ${memberDetails['member_ph_extension']}
#     Sleep    2s
#     Input Text    xpath://*[@name="address_line_1"]    ${memberDetails['member_address']}
#     Sleep    2s
#     Input Text    xpath://*[@name="city"]    ${memberDetails['member_city']}
#     Sleep    3s
#     Click Element   xpath://*[@id="create-employee"]/div[2]/div[5]/div[2]/div[8]/div/div[2]/div/div

#     Scroll Element Into View    xpath://*[@data-value="North Carolina(${memberDetails['member_state']})"]
#     Click Element    xpath://*[@data-value="North Carolina(${memberDetails['member_state']})"]

    
    
#     Sleep    3s
#     Press Keys    xpath://*[@name="ZIP"]    '${memberDetails['member_zip']}'
#     Click Element    xpath://*[@class="pf-action-button-container margin-top-action-button"]/button[1]/span[1]
#     Sleep    10s

#dependent details add............
dependent details add
    ${dependent_data}=   getDependentData
    # Log To Console    dependent_data-----------${dependent_data}
    Wait Until Element Is Visible    xpath://*[@id="employer-dashboard"]/ul/div[2]    timeout=10s
    Click Element    xpath://*[@id="employer-dashboard"]/ul/div[2]
    Sleep    3s
    Input Text    xpath://*[@id="employer-sidebar-container"]/div/main/div[2]/div[2]/div/div/div/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[1]/div[1]/div/input   ${dependent_data['member_id']}
    

    Wait Until Element Is Visible    xpath://*[@id="employer-sidebar-container"]/div/main/div[2]/div[2]/div/div/div/div[1]/div[2]/div[3]/div[2]/div/div/div/div[2]    timeout=10s
    Click Element    xpath://*[@id="employer-sidebar-container"]/div/main/div[2]/div[2]/div/div/div/div[1]/div[2]/div[3]/div[2]/div/div/div/div[2]
    Wait Until Element Is Visible    xpath://span[@class="button-label-with-icon" and contains(text(), "Open Member Portal")]    timeout=10s

    Click Element    xpath://span[@class="button-label-with-icon" and contains(text(), "Open Member Portal")]

    Sleep    10s

    ${handles}=    Get Window Handles

    Switch Window    ${handles}[1]

    Wait Until Element Is Visible    xpath://button[contains(text(), "Add Family Member to Benefits")]    timeout=10s
    Click Element    xpath://button[contains(text(), "Add Family Member to Benefits")]
    
    Wait Until Element Is Visible    xpath://*[@placeholder="Enter dependent first name"]    timeout=10s
    Input Text    xpath://*[@placeholder="Enter dependent first name"]    ${dependent_data['dependent_first_name']}

    Input Text    xpath://*[@placeholder="Enter dependent middle name"]    ${dependent_data['dependent_middle_name']}
    Input Text    xpath://*[@placeholder="Enter dependent last name"]    ${dependent_data['dependent_last_name']}
    
    ${dependent_retries}=    Set Variable    10
    ${dependent_text}=    Set Variable    ${dependent_data['dependent_ssn']}

    ${dependent_SSN}=    Set Variable    xpath://*[@placeholder="Enter dependent SSN"]
    ${dependent_re_enter_ssn}=    Set Variable    xpath://*[@placeholder="Re-Enter SSN"]

    FOR    ${counter}    IN RANGE    2
        ${dependent_SSN_path}=    Set Variable    ${dependent_SSN}
        IF    ${counter} != 0
                ${dependent_SSN_path}=    Set Variable    ${dependent_re_enter_ssn}
        END
        FOR    ${index}    IN RANGE    ${dependent_retries}
            IF    ${index} != 0
                Press Keys        ${dependent_SSN_path}     CTRL+a+BACKSPACE
            END
            Press Keys    ${dependent_SSN_path}    ${dependent_text}
        
            ${value}=    Get Element Attribute    ${dependent_SSN_path}    value

            ${result}=    Evaluate    '${value.replace("-", "")}' == '${dependent_text}'
            Exit For Loop If    ${result} == True
        END   
    END

    ${current_date}=    Get Current Date    result_format=%m/%d/%Y
    ${current_month_split}=    Split String    ${current_date}    /
    ${current_month}=    Set Variable    ${current_month_split[0]}

    Click Element    xpath://*[@id="root"]/div/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div/div/div/button/span[1]
    Wait Until Element Is Visible    xpath:/html/body/div[2]/div[3]/div/div[1]/div/div[1]/button[1]/span[1]/h6    timeout=5s
    Click Element    xpath:/html/body/div[2]/div[3]/div/div[1]/div/div[1]/button[1]/span[1]/h6    
    ${dependent_birthday}    Split String   ${dependent_data['dependent_dob']}   /
    ${dependent_dob_month}    Set Variable    ${dependent_birthday}[0]
    
    Wait Until Element Is Visible    xpath://div[contains(@class, 'MuiPickersYear-root') and text()='${dependent_birthday}[2]']    timeout=14s
    Click Element    xpath://div[contains(@class, 'MuiPickersYear-root') and text()='${dependent_birthday}[2]']
    Sleep    5s

    IF    $current_month > $dependent_dob_month
        ${first_clicker}=    Evaluate    int($current_month) - int($dependent_dob_month)
        FOR    ${index}    IN RANGE    0    ${first_clicker}
            Click Element    xpath:/html/body/div[2]/div[3]/div/div[1]/div/div[2]/div[1]/div[1]/button[1]/span[1]
        END

    ELSE
        ${second_clicker}=    Evaluate    int($dependent_dob_month) - int($current_month)
        FOR    ${index}    IN RANGE    0    ${second_clicker}
            Click Element    xpath:/html/body/div[2]/div[3]/div/div[1]/div/div[2]/div[1]/div[1]/button[2]/span[1]
        END
    END


    Scroll Element Into View    xxpath://button[contains(@class, 'MuiPickersDay-day')]/span/p[text()='${dependent_birthday}[1]']
    Click Element    xpath://button[contains(@class, 'MuiPickersDay-day')]/span/p[text()='${dependent_birthday}[1]']
    Sleep    5s
    Click Element    xpath:/html/body/div[2]/div[3]/div/div[2]/button[2]/span[1]

    Input Text    xpath://*[@placeholder="Enter email"]    ${dependent_data['dependent_gmail']}
    Click Element    xpath://*[@id="root"]/div/div[2]/div/div[2]/div[2]/div[2]/div[8]/div/div[2]/div
    Wait Until Element Is Visible    xpath://*[@data-value="MALE"]    timeout=10s
    Click Element    xpath://*[@data-value="MALE"] 
    Click Element    XPATH://*[@id="root"]/div/div[2]/div/div[2]/div[2]/div[2]/div[9]/div/div[2]/div
    Wait Until Element Is Visible    xpath://*[@data-value="CHILD"]    timeout=5s
    Click Element    xpath://*[@data-value="CHILD"]
    Click Element    xpath://*[@id="root"]/div/div[2]/div/div[2]/div[2]/div[2]/div[10]/div/div[2]/div
    Wait Until Element Is Visible    xpath://*[@data-value="D-Dependent"]    timeout=5s
    Click Element    xpath://*[@data-value="D-Dependent"]
    Click Element    xpath://*[@id="check-support"]/span[1]/span
    Click Element    xpath://*[@id="root"]/div/div[2]/div/div[3]/div[2]/div/button
    Sleep    10s
    