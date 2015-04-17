



@echo off

REM :: Batch file takes arguments and assigns Hops_params to common file for julia processesing. This would be unecessary if the julia executable could take inputs

REM :: The HOPSPACK will pass the following arguments in to the batch file
REM IN_FILE = ARGS[1]      Call with %1
REM	OUT_FILE = ARGS[2]   Call with %2
REM	TAG = ARGS[3]        Call with %3
REM	TYPE = ARGS[4]       Call with %4


REM :: copy HOPSPACK in_parameters to a convenient storage place
copy /Y %1 in_params.txt

REM :: run julia executable
MakeItSo

REM :: copy julia out_values to the RETURN_TO_HOPS file
copy /Y out_params.txt %2 


