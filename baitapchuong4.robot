*** Settings ***
Documentation     Test đăng nhập trang OrangeHRM
Library           SeleniumLibrary

*** Variables ***
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USER}     Admin
${VALID_PASS}     admin123
${INVALID_USER}   saiuser
${INVALID_PASS}   saipass

*** Test Cases ***
Đăng Nhập Hợp Lệ
    [Documentation]    Kiểm tra đăng nhập với tài khoản đúng
    Mở Trình Duyệt
    Nhập Thông Tin Đăng Nhập    ${VALID_USER}    ${VALID_PASS}
    Click Nút Login
    Kiểm Tra Đăng Nhập Thành Công
    Đóng Trình Duyệt

Đăng Nhập Không Hợp Lệ
    [Documentation]    Kiểm tra đăng nhập với tài khoản sai
    Mở Trình Duyệt
    Nhập Thông Tin Đăng Nhập    ${INVALID_USER}    ${INVALID_PASS}
    Click Nút Login
    Kiểm Tra Đăng Nhập Thất Bại
    Đóng Trình Duyệt

*** Keywords ***
Mở Trình Duyệt
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name="username"]    timeout=10

Nhập Thông Tin Đăng Nhập
    [Arguments]    ${user}    ${pass}
    Input Text    xpath=//input[@name="username"]    ${user}
    Input Text    xpath=//input[@name="password"]    ${pass}

Click Nút Login
    Click Button    xpath=//button[@type='submit']
    Sleep    2

Kiểm Tra Đăng Nhập Thành Công
    Wait Until Page Contains Element    xpath=//h6[text()='Dashboard']    timeout=10

Kiểm Tra Đăng Nhập Thất Bại
    Wait Until Page Contains    Invalid credentials    timeout=10

Đóng Trình Duyệt
    Close Browser
