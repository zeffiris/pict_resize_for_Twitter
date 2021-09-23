@echo off

@cd /d %~dp0
@powershell -NoProfile -ExecutionPolicy RemoteSigned -File .\pict_resize_for_Twitter.ps1 %*
