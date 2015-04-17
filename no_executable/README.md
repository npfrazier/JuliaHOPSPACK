
### Set local path

I assume you have a copy of hopspack_main_serial.exe either in the same folder or on path. I also recommend adding Julia to path as it makes editing the batch file either.

#### Test if on system path

To test if these are on path open up your command line and type in 
> julia

This should open the REPL which you can close with "exit()". If it does not, then Julia is not on the system path. To test for HOPSPACK type

> hopspack_main_serial

 This should error out asking for an input file [ERROR: need input file name"]. If you get a different error then HOPSPACK is probably not on the local path.

### Edit batch file

To make this work you need to edit the batch file.

Open "example_noexec.bat" and change the variable localdir to the correct directory for your machine. 

### Run HOPSPACK

I set up everything so that HOPSPACK is ready to run the example from the previous page without further adjustment. What this means is that the local file: "hops_config.txt" has "example_noexec.bat" as the name of the objective function. You may want to take a second to look at the other parameters but I recommend running it once before changing anything. Notice that it has two citizens by default. This will actually take longer than if you disable one citizen.

Ready to run. From your command line go to the directory with both "hops_config.txt" and "example_noexec.bat"
and then run:

> HOPSPACK_main_serial hops_config.txt

The final result will be stored in "hops_pointout.txt." "cache_in.txt" and "cache_out.txt" will store intermediate trials. 
