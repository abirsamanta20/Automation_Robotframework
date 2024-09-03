*** Settings ***
Library  SeleniumLibrary    
# Library  Collections
Library  OperatingSystem
# Library  DataDriver   ${EXECDIR}\\ITEDUIM\\testData\\ITEDUIMTestDataFirtsRow.xlsx
Library  DataDriver   ${EXECDIR}\\ITEDUIM\\testData\\first50Rows.xlsx


Resource    ../resources/loginResources.robot
Library   ${EXECDIR}\\utils\\commonFunctions\\getSupplementalID.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getEmployeeName.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getDashedSSN.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getAddressAsTestData.py
Library   ${EXECDIR}\\utils\\commonFunctions\\replace.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getDashedMobileNumber.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getHCREFs.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getRCEndDate.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getPhoneObject.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getBooleanForHomeNumber.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getBooleanForMobileNumber.py



Library    Process
# Suite Setup    Open My Browser
# Suite Teardown  Close Browsers
Test Template    Invalid login
*** Variables ***
${BROWSER}    Chrome
${URL}        https://nc.partners.ncqa3.hrissuite.com/auth/login
${userid}     dataqa@itedium.com
${Password}   GBTechService@2024

*** Test Cases ***
ReadingTestdataFromXLSXusing using ${memberName} and ${SSN (or ID)}

*** Keywords ***
Invalid Login
    [Arguments]  ${MasterPolicy}       ${Supplemental IDs}    ${memberName}    ${Sex}    ${DOB}    ${SSN (or ID)}    ${Address}    ${M Phone}    ${Employment}    ${Plan Description}    ${Benefit Begin}    ${Benefit End}    ${Employment Begin}    ${HC REFs}    ${RC Name}    ${RC Date}
    Open My Browser
   
    ${supplementalID}=   getSupplementalID   ${Supplemental IDs}  
    ${name}=    getEmployeeName     ${memberName}  

    Input username   ${userid}
    Input password    ${password}

    ${dashedSSN}=    getDashedSSN    ${SSN (or ID)}  
    ${typeOFDOB}=    Evaluate     type($DOB)
    ${DOBlength}=    Get Length    ${DOB}
    ${Phonelength}=    Get Length    ${M Phone}
    ${SSNlength}=    Get Length    ${SSN (or ID)}
    ${addressLength}=    Get Length    ${Address}



    Click To Login

    click Element    //*[@id="container"]/header/div/button
     
     Sleep    3s
    Input Text    name:intellisearch    ${supplementalID}
    click Element    //*[@id="side-bar"]/div/div/form/div/span/button  

    Sleep    3s
    Table Cell Should Contain   //*[@id="main-content"]/div/div[2]/div/div/div[2]/table    2    1     ${name["firstName"]}  
    Table Cell Should Contain   //*[@id="main-content"]/div/div[2]/div/div/div[2]/table    2    2     ${name["lastName"]}
    ${accountType}    Get Text    //*[@id="main-content"]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[3]
#     Log To Console     ----------------accountTypeaccountType-----------${accountType}
    IF    '${accountType}' == 'Employee'
            # Log To Console    in the ifffffffffffffffffff---- ${accountType}
        click Element    //*[@id="main-content"]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[6]/a
        Sleep    3s
        Switch Window    title=Administration Portal
        Sleep    3s
        Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    5    2    ${Sex[0]}
        IF    ${DOBlength} != 0
            Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    6    2    ${DOB.replace("-", "/")}
        END
        Sleep    3s
        Log To Console    --------------SSNlengthSSNlengthSSNlengthSSNlength--------------${SSNlength}
        IF   ${SSNlength} != 0
             Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    7    2    ${dashedSSN}
        END

       ${contactsRowElement}    Get WebElements    //*[@id="page_36"]/div[2]/div/table/tbody/tr  
       ${contactsRowCount}    Get Length    ${contactsRowElement}

        ${PhoneObject}=   getPhoneObject   ${M Phone}

        FOR    ${index}    IN RANGE    1    ${contactsRowCount + 1}
              ${rowElement}=    Get WebElements    ${contactsRowElement}[${index - 1}]
              ${rowText}=    Get Text    //*[@id="page_36"]/div[2]/div/table/tbody/tr[${index}]
              ${splitParts}=    Set Variable    ${rowText.replace("\n", " ").split(" ")}
           
              IF    ${addressLength} != 0
                    IF    '${splitParts[0]}' == 'Address'
                                ${actualAddress}=    getAddressAsTestData     ${rowText.split("Preferred")[-1].replace("\n", " ")}
                                ${actualAddressWithoutCommas}=    replace    ${actualAddress}
                                ${addressWithoutCommas}=    replace    ${Address}
                                # Log To Console   ---actualAddressWithoutCommasactualAddressWithoe----------${actualAddressWithoutCommas.strip()}
                                # Log To Console   --------addressWithoutCommasaddressWithoutCommas-----${actualAddress.strip()}
                                Should Be Equal As Strings     ${addressWithoutCommas.strip()}    ${actualAddressWithoutCommas.strip().replace("\n", " ")}    case_insensitive=True     ignore_whitespace=True    ignore_order=True
                    END
              END
              IF    ${Phonelength} >= 16
                    IF    '${splitParts[0]}' == 'Phone'
                            ${mobileNumberBoolean}=   getBooleanForMobileNumber   ${M Phone}
                            ${homeNumberBoolean}=   getBooleanForHomeNumber   ${M Phone}
                            IF   ${mobileNumberBoolean} == True
                                IF    '${splitParts[1]}' == 'Mobile'
                                        ${mobileNumber}=     getDashedMobileNumber    ${PhoneObject['Tel'].strip()}
                                        Should Be Equal As Strings    ${mobileNumber}    ${splitParts[-1]}
                                        # Log To Console   ---mobileNumberBoolean---------- ${mobileNumberBoolean}

                                END
                            END
                           
                            IF    ${homeNumberBoolean} == True
                                IF    '${splitParts[1]}' == 'Home'
                                        ${mobileNumber}=     getDashedMobileNumber    ${PhoneObject['Home'].strip()}
                                        Should Be Equal As Strings    ${mobileNumber}    ${splitParts[-1]}
                                END
                            END
                    END
              END
        END
       
        ${_actualAddress}    Get Text    //*[@id="page_36"]/div[2]/div/table/tbody/tr[2]/td[3]
        ${actualAddress}=    getAddressAsTestData    ${_actualAddress}
        ${actualAddressWithoutCommas}=    replace    ${actualAddress}
        ${addressWithoutCommas}=    replace    ${Address}
        # # ${mobileNumber}=     getDashedMobileNumber    ${M Phone}

        # # IF    ${Phonelength} == 16
        # #     ${mobileNumber}=     getDashedMobileNumber    ${M Phone}
        # #     ${contactsTableWebelement}    Get WebElements    //*[@id="page_36"]/div[2]/div/table/tbody/tr
        # #     ${contactsTableRowCount}    Get Length    ${contactsTableWebelement}
        # #     IF    ${contactsTableRowCount} == 3
        # #         Table Cell Should Contain    //*[@id="page_36"]/div[2]/div/table    3    3    ${mobileNumber.strip()}

        # #     ELSE
        # #         Table Cell Should Contain    //*[@id="page_36"]/div[2]/div/table    4    3    ${mobileNumber.strip()}
        # #     END
        # # END
        # //////////////////////////////////////////////////////////////////////////

        click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[2]/a  
        Sleep    3s
        ${employment_record_row_elements}    Get WebElements    //*[@id="page_37"]/div[1]/div/table/tbody/tr[2]
        ${employment_record_row_count}    Get Length    ${employment_record_row_elements}
        IF   '${Employment}' == 'TE'
            Should Be Equal As Numbers    ${employment_record_row_count}    1
            click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[3]
            Sleep    5s
            ${activeBenefitsRowElementForTE}     Get WebElements    //*[@id="page_38"]/div[1]/div/table/tbody/tr
            ${activeBenefitsRowCountForTE}    Get Length    ${activeBenefitsRowElementForTE}
            ${typeactiveBenefitsRowCount}    Evaluate    type('${activeBenefitsRowCountForTE}')
           
        ELSE
            Should Not Be Equal    ${employment_record_row_count}    1
            Sleep    2s
            click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[3]
            Sleep    3s
            ${activeBenefitsRowElement}     Get WebElements    //*[@id="page_38"]/div[1]/div/table/tbody/tr
            ${activeBenefitsRowCount}    Get Length    ${activeBenefitsRowElement}
            Sleep    3s
            ${planXpath}=    Set Variable    //*[@id="page_38"]/div[1]/div/table/tbody/tr[${activeBenefitsRowCount}]/td[2]
            Table Cell Should Contain    //*[@id="page_38"]/div[1]/div/table    ${activeBenefitsRowCount}    2    ${Plan Description}
            Table Cell Should Contain    //*[@id="page_38"]/div[1]/div/table    ${activeBenefitsRowCount}    4    ${Benefit Begin.replace("-", "/")}
            Table Cell Should Contain    //*[@id="page_38"]/div[1]/div/table    ${activeBenefitsRowCount}    5     ${Benefit End.replace("-", "/")}
        # ////////////////////////////////////////////////////////////////////
            click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[5]/a
            Sleep    3s
            ${benefitDetailRowElement}    Get WebElements    //*[@id="page_40"]/div/div[1]/table/tbody/tr
            ${benefitDetailROwCount}    Get Length    ${benefitDetailRowElement}
            # Log To Console    -----benefitDetailROwCount-------------- ${benefitDetailROwCount}
            #  ${text}=    Get Text    //*[@id="page_40"]/div/div[1]/table/tbody/tr[${benefitDetailROwCount}]
            ${lengthHCREFs}=    Get Length    ${HC REFs}

                FOR    ${index}    IN RANGE    1    ${benefitDetailRowCount}
                    Sleep    1s
                    #   Log To Console    ------indexindex----------${index - 1}
                    ${rowElement}=    Get WebElements    ${benefitDetailRowElement}[${index - 1}]
                    ${classAttribute}=    Get Element Attribute    ${rowElement}    class
                    ${rowText}=    Get Text    //*[@id="page_40"]/div/div[1]/table/tbody/tr[${index + 1}]
                    ${splitParts}=    Set Variable    ${rowText.split(" ")}
                    #   Log To Console    -----rowTextrowText------------${rowText}
                    #   Log To Console    -----indexxxxxxxxxx------------${index + 1}

                    IF    '${classAttribute}' == 'data_current'
                            IF    'Non Smoker Discount' in '${rowText}'
                                    IF    ${lengthHCREFs} != 0
                                    ${HCREFs}=    getHCREFs    ${HC REFs}
                                    Should Be Equal As Strings     ${HCREFs}    ${splitParts[3][0]}    case_insensitive=True  
                                    END  
                            END

                            IF    'Medicare Primacy' in '${rowText}'
                                #   Log To Console    ----- RC Name------------${RC Name}
                                IF    'Medicare Primacy' == '${RC Name}'
                                        ${RCDateLength}=    Get Length    ${RC Date}
                                        # Log To Console    ----- RCDateLengthRCDateLength----${RC Date}-------- ${RCDateLength}
                                        IF    ${RCDateLength} == 10
                                            Should Be Equal As Strings    ${RC Date.replace("-", "/")}    ${splitParts[3]}  
                                        END
                                        IF    ${RCDateLength} > 10
                                            ${RCEndDate}=    getRCEndDate    ${RC Date}
                                            Should Be Equal As Strings    ${RCEndDate}    ${splitParts[4]}  
                                        END
                                END
                               
                            END  
                    END
                END
       
                click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[1]/a
                Sleep    2s
                click Element    //*[@id="page_36"]/div[1]/div[1]/div[1]/a[1]
                Sleep    2s
                Textfield Value Should Be    //*[@id="hire_date"]     ${Employment Begin.replace("-", "/")}
            END
    ELSE
        click Element    //*[@id="main-content"]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[6]/a
        Log To Console    hammba hamba ramba ramba---------------

        Sleep    3s
        Switch Window    title=Administration Portal
        Sleep    3s
        Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    7    2    ${Sex[0]}
        # Log To Console    hammba hamba ramba ramba----Sex[0]----------- ${Sex}
        IF    ${DOBlength} != 0
            Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    8    2    ${DOB.replace("-", "/")}
        END
        # ${dashedSSNLength}=    Get Length    ${dashedSSN}
        IF   ${SSNlength} != 0
            Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    9    2    ${dashedSSN}
        END
            # Log To Console    ----------addressLengt------${addressLength}
        IF    ${addressLength} != 0
              ${_actualAddress}    Get Text    //*[@id="page_36"]/div[2]/div/table/tbody/tr[2]/td[3]
              ${actualAddress}=    getAddressAsTestData    ${_actualAddress}
              ${actualAddressWithoutCommas}=    replace    ${actualAddress}
              ${addressWithoutCommas}=    replace    ${Address}
              Should Be Equal As Strings     ${addressWithoutCommas.strip()}    ${actualAddressWithoutCommas.strip().replace("\n", " ")}    ignore_whitespace=True    ignore_order=True
        END
       
        IF    ${Phonelength} == 16
            ${mobileNumber}=     getDashedMobileNumber    ${M Phone}
            ${actualMobileNumber}    Get Text    //*[@id="page_36"]/div[2]/div/table/tbody/tr[3]/td[3]
            # Table Cell Should Contain    //*[@id="page_36"]/div[2]/div/table    3    3    ${mobileNumber.strip()}
            # Log To Console    actualMobileNumberactualMobileNumberactualMobileNumber----${actualMobileNumber.replace("-","").strip()}
            # Log To Console    mobileNumbermobileNumbermobileNumber----${mobileNumber.replace("-","").strip()}
            Should Be Equal As Strings     ${actualMobileNumber.replace("-","").strip()}    ${mobileNumber.replace("-","").strip()}    ignore_whitespace=True

        END
    END
    Close Browsers
