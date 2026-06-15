@echo off
REM Static analysis on bootloader application sources only (skip third-party lib/)
cppcheck --enable=all --suppress=missingIncludeSystem --xml --xml-version=2 ^
    -i lib ^
    -I src ^
    src 2> cppcheck.xml
echo Cppcheck complete — results in cppcheck.xml
