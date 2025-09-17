@REM Create JKAProxyPlus projects for Visual Studio using CMake
@echo off
:vs
cls
echo JKA Proxy Plus VS Projects Generator
echo ------------------------------------
:: VS Options
echo Select the Visual Studio version:
echo.
echo 1) Visual Studio 2013 (msvc12)
echo 2) Visual Studio 2015 (msvc14)
echo 3) Visual Studio 2017 (msvc15)
echo 4) Visual Studio 2019 (msvc16)
echo 5) Visual Studio 2022 (msvc17)
echo.
set /p proj_option=Enter your option: 

if "%proj_option%" == "1" ( 
	set proj_vs="Visual Studio 12 2013"
) else if "%proj_option%" == "2" ( 
	set proj_vs="Visual Studio 14 2015"
) else if "%proj_option%" == "3" ( 
	set proj_vs="Visual Studio 15 2017"
) else if "%proj_option%" == "4" ( 
	set proj_vs="Visual Studio 16 2019"
) else if "%proj_option%" == "5" ( 
	set proj_vs="Visual Studio 17 2022"
) else ( 
	echo Invalid option!
	pause
	goto :vs 
)
:: Arch Options
:arch
echo.
echo Select the target architecture:
echo.
echo 1) 32-bit (x86)
echo 2) 64-bit (x64)
echo.
set /p proj_option=Enter your option: 

if "%proj_option%" == "1" ( 
	set proj_arch=Win32
	set proj_arch_host=x86
) else if "%proj_option%" == "2" ( 
	set proj_arch=x64
	set proj_arch_host=x64
) else ( 
	echo Invalid option!
	pause
	goto :arch 
)
:: Resume
echo.
echo Project for %proj_vs% (%proj_arch_host%) selected!
pause
echo ------------------------------------
:: Cmake build
for %%X in (cmake.exe) do (set FOUND=%%~$PATH:X)
if not defined FOUND (
	echo CMake was not found on your system. Please make sure you have installed CMake
	echo from http://www.cmake.org/ and cmake.exe is installed to your system's PATH
	echo environment variable.
	echo.
	pause
	exit /b 1
) else (
	echo Found CMake!
)
if not exist build\nul (mkdir build)
pushd build
cmake -G %proj_vs% -A %proj_arch% -T host=%proj_arch_host% -D MSVC_RUNTIME=static ..
popd
pause