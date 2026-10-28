@echo off
setlocal

:: Lay duong dan Desktop that (ke ca khi bi redirect sang OneDrive)
for /f "usebackq delims=" %%D in (`powershell -NoProfile -Command "[Environment]::GetFolderPath('Desktop')"`) do set "DESK=%%D"

set "ZIP=%DESK%\LevelUp_Config_Installer.zip"
set "DEST=%DESK%\LevelUp_Config_Installer"
set "STEAMCMD=%DESK%\scriptsteamlink_V2.cmd"

echo [1/4] Tai LevelUp_Config_Installer.zip...
curl -L -f -o "%ZIP%" "https://www.dropbox.com/scl/fi/j0u1skuvbvw3m4siunlq1/LevelUp_Config_Installer.zip?rlkey=6344momd520opzy69wy4i1us1&st=hwpvxawz&dl=1" || goto :err

echo [2/4] Tai scriptsteamlink_V2.cmd...
curl -L -f -o "%STEAMCMD%" "https://www.dropbox.com/scl/fi/6fymlz6clqg5p459v9jc1/scriptsteamlink_V2.cmd.txt?rlkey=cy4vcvbe5ha8emxhrjn0or1mj&st=p1dkg33p&e=3&dl=1" || goto :err

echo [3/4] Giai nen...
powershell -NoProfile -Command "Expand-Archive -LiteralPath '%ZIP%' -DestinationPath '%DEST%' -Force" || goto :err

echo [4/4] Chay Copy-LevelUp-Config.bat...
for /r "%DEST%" %%F in (Copy-LevelUp-Config.bat) do if exist "%%F" (
    pushd "%%~dpF"
    call "%%F"
    popd
    goto :done
)
echo Khong tim thay Copy-LevelUp-Config.bat sau khi giai nen.
goto :err

:done
echo Hoan tat.
exit /b 0

:err
echo Co loi xay ra, kiem tra lai ket noi hoac link tai.
pause
exit /b 1
