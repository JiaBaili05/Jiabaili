@echo off & chcp 65001 >nul
title Windows Server激活助手 终极版
mode con: cols=80 lines=30

:: 管理员权限验证
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo 正在请求管理员权限...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)

:main_menu
cls
echo.
echo    ==============================
echo      Windows Server 版本选择工具
echo    ==============================
echo.
echo    [1] Windows Server 2016
echo    [2] Windows Server 2019
echo    [3] Windows Server 2022
echo    [4] Windows Server 2025
echo    [5] 已经是正式版本
echo.
set /p choice=请输入对应数字 (1-5) : 

if "%choice%"=="1" goto server2016
if "%choice%"=="2" goto server2019
if "%choice%"=="3" goto server2022
if "%choice%"=="4" goto server2025
if "%choice%"=="5" goto formal_version
echo 输入无效，请按任意键重新选择...
pause >nul
goto main_menu

:server2016
call :execute_commands 2016 CB7KF-BWN84-R7R2Y-793K2-8XDDG
goto dism_2016

:server2019
call :execute_commands 2019 WMDGN-G9PQG-XVVXX-R3X43-63DFG
goto dism_2019

:server2022
call :execute_commands 2022 WX4NM-KYWYW-QJJR4-XV3QB-6VM33
goto dism_2022

:server2025
call :execute_commands 2025 D764K-2NDRG-47T6Q-P8T8W-YP6DF
goto dism_2025

:execute_commands
echo.
echo ========================================
echo 正在执行Server %1 激活命令...
echo 注意：如果有弹窗报错信息属于正常现象，无需处理！关闭即可！
echo ========================================
timeout /t 3 >nul

echo [1/4] 卸载现有密钥...
slmgr /upk
echo 请忽略弹窗的错误提示（如有）
timeout /t 2 >nul

echo [2/4] 安装新密钥...
slmgr.vbs /ipk %2
echo 请忽略弹窗的错误提示（如有）
timeout /t 2 >nul

echo [3/4] 设置KMS服务器...
slmgr.vbs /skms kms.lotro.cc
echo 请忽略弹窗的错误提示（如有）
timeout /t 2 >nul

echo [4/4] 尝试激活...
slmgr.vbs /ato
echo.
echo 基础激活命令执行完成！
timeout /t 3 >nul
goto :eof

:dism_2016
echo.
echo ========================================
echo 正在执行Server 2016版本转换...
DISM /Online /Set-Edition:ServerDatacenter /ProductKey:CB7KF-BWN84-R7R2Y-793K2-8XDDG /AcceptEula
goto complete

:dism_2019
echo.
echo ========================================
echo 正在执行Server 2019版本转换...
DISM /Online /Set-Edition:ServerDatacenter /ProductKey:WMDGN-G9PQG-XVVXX-R3X43-63DFG /AcceptEula
goto complete

:dism_2022
echo.
echo ========================================
echo 正在执行Server 2022版本转换...
DISM /Online /Set-Edition:ServerDatacenter /ProductKey:WX4NM-KYWYW-QJJR4-XV3QB-6VM33 /AcceptEula
goto complete

:dism_2025
echo.
echo ========================================
echo 正在执行Server 2025版本转换...
DISM /Online /Set-Edition:ServerDatacenter /ProductKey:D764K-2NDRG-47T6Q-P8T8W-YP6DF /AcceptEula
goto complete

:formal_version
cls
echo.
echo    ==============================
echo      请选择当前正式版系统版本
echo    ==============================
echo.
echo    [1] Server 2016
echo    [2] Server 2019
echo    [3] Server 2022
echo    [4] Server 2025
echo.
set /p sub_choice=请输入对应数字 (1-4) : 

if "%sub_choice%"=="1" goto dism_2016
if "%sub_choice%"=="2" goto dism_2019
if "%sub_choice%"=="3" goto dism_2022
if "%sub_choice%"=="4" goto dism_2025
echo 输入无效，请按任意键重新选择...
pause >nul
goto formal_version

:complete
echo.
echo ========================================
echo 所有操作已完成！
echo 建议执行以下操作：
echo 1. 运行 slmgr /dlv 查看激活状态
echo 2. 重启系统使更改生效
echo ========================================
pause >nul
exit
