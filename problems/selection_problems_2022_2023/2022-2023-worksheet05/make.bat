@ECHO OFF

pushd %~dp0

REM Command file for Sphinx documentation

if "%SPHINXBUILD%" == "" (
	set SPHINXBUILD=sphinx-build
)
set SOURCEDIR=.
set BUILDDIR=_build

if "%1" == "" goto help

%SPHINXBUILD% >NUL 2>NUL
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
	echo.installed, then set the SPHINXBUILD environment variable to point
	echo.to the full path of the 'sphinx-build' executable. Alternatively you
	echo.may add the Sphinx directory to PATH.
	echo.
	echo.If you don't have Sphinx installed, grab it from
	echo.https://www.sphinx-doc.org/
	exit /b 1
)

if [%2] == [] (
    %SPHINXBUILD% -M %1 %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %O%
) else (
    if [%2] == [solutions] (
        echo.Building solutions
        %SPHINXBUILD% -M %1 %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %O% -t Internal
        python replace.py
	    cd _build\latex
	    pdflatex 2022-2023-worksheet05
        ren 2022-2023-worksheet05.pdf 2022-2023-worksheet05-solutions.pdf
        xcopy 2022-2023-worksheet05-solutions.pdf ..\.. /Y
		cd ..\..
    ) else (
        echo.Building questions
		%SPHINXBUILD% -M %1 %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %O%
	    cd _build\latex
        xcopy 2022-2023-worksheet05.pdf ..\.. /Y
		cd ..\..		
	)
)
goto end


:help
%SPHINXBUILD% -M help %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %O%

:end
popd
