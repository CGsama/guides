@echo off
FOR /f %%i IN ('gpg -d key.txt') DO SET KEY=%%i
cppcryptfs -m %cd%\data -d k -p %KEY%
cppcryptfs -m %cd%\data -d l -p %KEY%
cppcryptfs -m %cd%\data -d m -p %KEY%
cppcryptfs -m %cd%\data -d n -p %KEY%