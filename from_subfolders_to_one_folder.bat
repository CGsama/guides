REM move all file in subfolder to a new created all folder with old folder name append in front of file name
REM by C8E
SET base=%CD%\all
mkdir all
echo %base%
FOR /D %%G in ("*") DO (
	echo %%~nxG
	cd %%~nxG
	FOR %%i in ("*") DO (
		echo %%~nxi
		copy %%~nxi %base%\%%~nxG_%%~nxi
	)
	cd ..
)