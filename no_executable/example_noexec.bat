



@echo off

REM HOPSPACK will pass the following arguments in to the batch file
REM IN_FILE = ARGS[1]      Call with %1
REM	# OUT_FILE = ARGS[2]   Call with %2
REM	# TAG = ARGS[3]        Call with %3
REM	# TYPE = ARGS[4]       Call with %4

REM Here I assume you have added Julia to the $(SYSTEM PATH). Some modification will be necessary if you have not I.E. being clever with pointing to the correct directory

REM Set Locals ~ DO NOT ADD A SPACE BEFORE/AFTER =
REM *** Name of your obj_function e.g. example_main_noexc.jl
set objfun="example_main_noexec.jl"
REM *** Directory to where [obj_function].jl is located
set localdir="C:\Users\Nick\SkyDrive\projects\j_library\juliaHOPSPACK\no_executable"

cd "%localdir%"

REM HOPSPACK passes four arguments stored in %1,%2,%3, and %4. The first two are the input and output file names. The third and forth are TAG and TYPE and not necessary for this application.
julia "%objfun%" %1 %2 "%localdir%"

