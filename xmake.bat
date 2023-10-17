@echo off
REM Script para ensamblar, enlazar y ejecutar de una sola vez

set nombre=%1

if exist %nombre%.obj del %nombre%.obj
if exist %nombre%.exe del %nombre%.exe

c:\masm32\bin\ml /c /Zd /coff %nombre%.asm
if errorlevel 1 goto errasm

c:\masm32\bin\Link /SUBSYSTEM:CONSOLE %nombre%.obj
if errorlevel 1 goto errlink

chcp 65001

cls
%nombre%.exe
pause
goto TheEnd

:errasm
echo _
echo Error al ensamblar
goto TheEnd

:errlink
echo _
echo Error al enlazar
goto TheEnd

:TheEnd

