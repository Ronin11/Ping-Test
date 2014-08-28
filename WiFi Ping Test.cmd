@echo off
title WiFi Ping Test

REM set The target IP address
set /P IP=Enter IP: %=%

REM delete the current DataLoss.csv data file
del /f DataLoss.csv

REM Start at 2000 bytes, and increment by 1000 bytes up to 20000 bytes.
for /L %%s in (2000,1000,20000) do (
	echo.
	
	REM Parse the data from the FPing command, print it to the screen, and store it in the CSV file.
	for /F "tokens=2 delims=(%%" %%a in ('fping %IP% -t 10 -w 10 -n 1000 -s %%s') do (
		if %%a GEQ 0 (
			if %%a LEQ 100 (
				echo %%a >> DataLoss.csv
				echo %%s - %%a Percent Loss
				)
			)
			
		)
)
echo Done
