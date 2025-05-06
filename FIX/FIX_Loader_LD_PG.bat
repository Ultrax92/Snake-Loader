@echo off
:: Verifie si le script est lance en admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Ce script necessite les droits administrateur.
    timeout /t 5 >nul
    exit /b
)

:: Vider le cache DNS
echo Vider le cache DNS...
ipconfig /flushdns

:: Demarrer le service de l'heure Windows
echo Demarrage du service de synchronisation de l'heure...
net start w32time >nul 2>&1

:: Synchroniser l'heure
echo Synchronisation de la date et l'heure...
w32tm /resync

echo.
echo Termine... Lancement du loader...
timeout /t 5 >nul
exit