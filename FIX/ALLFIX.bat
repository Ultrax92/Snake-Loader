@echo off

echo Privileges utilisateur actuels: %userprofile%
echo.
echo Demande des privileges administrateur...

net session >nul 2>&1
if %errorLevel% == 0 (
    goto :continue
) else (
    goto :admin
)

:admin
echo.
echo Vous devez executer ce fichier .bat en tant qu'administrateur.
echo Veuillez accorder des privileges administrateur en sélectionnant « Oui » lorsque vous y êtes invite.
echo.
powershell -Command "Start-Process '%0' -Verb RunAs"
exit

:continue
echo Privileges administrateur confirmes.
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Config" /v VulnerableDriverBlocklistEnable /t REG_DWORD /d 0x000000

bcdedit /set hypervisorlaunchtype off

echo.
echo Veuillez redemarrer votre PC
echo.
pause>nul
exit