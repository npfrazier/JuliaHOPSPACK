



@echo off

REM I assume you have added Julia to the $(SYSTEM PATH). Some modification will be necessary if you have not I.E. being clever with pointing to the correct directory

REM Edit your directory to where main_input.jl is located
cd C:\Users\Nick\SkyDrive\projects\LaborEcon\optimize\test_out

REM HOPSPACK passes four arguments stored in %1,%2,%3, and %4. The first two are the input and output file names. The third and forth are TAG and TYPE and not necessary for this application.
julia main_input.jl %1 %2

