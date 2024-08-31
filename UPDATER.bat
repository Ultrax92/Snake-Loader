@echo off
:: Vérifier si le script est déjà exécuté en tant qu'administrateur
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo Demande des droits administrateur...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: Maintenant que nous avons les droits administratifs, continuez l'exécution du script
echo Droits administratifs obtenus, poursuite du script...

REM Aller dans le dossier de l'application
cd /d "%~dp0"

REM Supprimer tous les fichiers sauf unins000.dat, unins000.exe et UPDATER.bat
for %%i in (*.*) do (
    if not "%%i"=="unins000.dat" if not "%%i"=="unins000.exe" if not "%%i"=="UPDATER.bat" del /q "%%i"
)
IF ERRORLEVEL 1 (
    echo Erreur : Impossible de supprimer les anciens fichiers.
    pause
    exit /b 1
)

REM Supprimer tous les sous-dossiers
for /d %%i in (*) do rd /s /q "%%i"
IF ERRORLEVEL 1 (
    echo Erreur : Impossible de supprimer les sous-dossiers.
    pause
    exit /b 1
)

REM Extraire le nouveau contenu du fichier ZIP
powershell -command "Expand-Archive -Path '%TEMP%\Snake Loader.zip' -DestinationPath '%~dp0' -Force"
IF ERRORLEVEL 1 (
    echo Erreur : Impossible d'extraire le fichier ZIP.
    pause
    exit /b 1
)

REM Supprimer le fichier ZIP temporaire
del /q "%TEMP%\Snake Loader.zip"
IF ERRORLEVEL 1 (
    echo Erreur : Impossible de supprimer le fichier ZIP temporaire.
    pause
    exit /b 1
)

REM Démarrer la nouvelle version de l'application
start "" "%~dp0Snake Loader.exe"
IF ERRORLEVEL 1 (
    echo Erreur : Impossible de démarrer Snake Loader.exe.
    pause
    exit /b 1
)

REM Afficher un message de succès
msg * "La mise à jour a été effectuée avec succès."
exit /b 0
