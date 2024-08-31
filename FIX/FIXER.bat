@echo off
color 0C
echo Merci d'avoir choisi nos software
echo Nous allons preparer votre PC - vous etes pret?
choice /C YN /M "Appuyez sur Y pour continuer ou sur N pour quitter."

if errorlevel 2 (
	color C0
	cls
    echo Sortie du script...
    timeout /nobreak /t 2 >nul
    exit
)

:: Rest des Skripts...
@echo off
title System Configuration
color 0C

:: Request admin access
NET FILE >nul 2>&1
if %errorLevel% == 0 (
    goto :adminCheck
) else (
	color C0
	cls
    echo Veuillez executer ce script en tant qu'administrateur.
    pause
    exit
)

:adminCheck
color 0C
cls
echo Merci d'avoir choisi MEDUSA SHOP!
echo Si vous rencontrez d'autres problemes, creez un ticket sur le serveur Discord categorie "SUPPORT".
echo Nous allons commencer a preparer votre PC, alors asseyez-vous et detendez-vous un petit moment.
timeout /t 3 /nobreak > NUL
echo
echo
:: Delete all temporary files
color 0C
echo Suppression des fichiers temporaires...
del /q /s %TEMP%\*.*

:: Deactivate Riot Vanguard
color 0C
echo Riot Vanguard sera desactive.
sc stop vgk
timeout /nobreak /t 2 >nul

:: Disable Hyper-V
color 0C
echo Desactivation d'Hyper-V...
bcdedit /set hypervisorlaunchtype off
powershell.exe -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All"

:: Disable VulnerableDriverBlocklist for Windows 11 22h2
color 0C
echo Desactivation de VulnerableDriverBlocklist...
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows\Vulnerability\Override" /v "Windows11_22H2_BlockList" /t REG_DWORD /d 0 /f

:: Add the specified regedits
color 0C
echo Ajout de regedits...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f

:: Disable Core Isolation
color 0C
echo Desactivation de l'isolation du noyau...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f
color 02



echo C'est fait! Le systeme redemarrera dans 5 secondes...
timeout /nobreak /t 5 >nul
shutdown /r /f /t 0
pause
