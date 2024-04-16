@echo off
setlocal enabledelayedexpansion

for %%f in (..\core\modules\mod*.class.php) do (
	set filename=%%~nf
)
:: trim mod and .class in beginning and end
set filename=%filename:~3,-6%

:: to lower case
for %%a in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z" "Ä=ä" "Ö=ö" "Ü=ü") do (
    set "filename=!filename:%%~a!"
)

echo %filename%

del /f module_%filename%-1.0.zip
rd /s /q .\tmp
robocopy .. .\tmp\%filename% /xd vendor test .git build .phpunit.cache codecoveragereport /s
robocopy ..\vendor\andrew-svirin .\tmp\%filename%\vendor\andrew-svirin /s
"C:\Program Files\7-Zip\7z.exe" a module_%filename%-1.0.zip .\tmp\%filename%
rd /s /q .\tmp