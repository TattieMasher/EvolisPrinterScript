@echo off
SET watcher=AppReplacer.exe
SET printer=RISEx.exe
GOTO CheckReplacer

:CheckReplacer
ECHO Checking that AppWatcher is running.
TASKLIST | FINDSTR "%watcher%"
timeout /T 2

rem 0 = RUNNING ***** ***** *****
IF ERRORLEVEL==0 (GOTO CheckRISEx) ELSE (GOTO StartApps)
timeout /T 2


:CheckRISEx
ECHO Checking that RISEx is running.
TASKLIST | FINDSTR "%printer%"
IF ERRORLEVEL==0 (GOTO KillRISEx) ELSE (GOTO StartApps)
timeout /T 2


:KillReplacer
ECHO %watcher% is running. Attempting to end.
taskkill /f /im "%watcher%"
ECHO Ended AppWatcher.
timeout /T 2
GOTO StartScripts


:KillRISEx
ECHO %printer% is running. Attempting to end.
taskkill /f /im "%printer%"
ECHO Ended RISEx.
timeout /T 2
GOTO StartScripts


:StartApps
ECHO Starting %watcher%
START %watcher%
ECHO Started %watcher%
PAUSE