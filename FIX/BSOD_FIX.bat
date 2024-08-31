@echo off

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d  3

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d  3

echo Veuillez redemarrer votre PC.
pause
) ELSE (
    ECHO Veuillez executer le .bat en tant qu'administrateur.
    pause
)