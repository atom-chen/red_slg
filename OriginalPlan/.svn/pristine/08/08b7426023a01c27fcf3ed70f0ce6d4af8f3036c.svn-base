@echo off
@set lastpath=%~dp0

@cd cpptodoxy
@if [%1] == [] ( 
	@run.bat
	@cd %lastpath%
) else ( 
	@run.bat %1
	@cd %lastpath% 
)