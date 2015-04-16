# JuliaHOPSPACK
Work in progress to integrate a Julia standalone executable into HOPSPACK


Everything you need to run Flavio's HOPSPACK example is located in the folder. The example minimizes the function
f(x) = sin(x/(  1+ sqrt( x*x^(1/3) ) )) for x scalar
The global minimum is at -1. The included solution file is "hops_pointout.txt".

To run HOPSPACK use your command line to go to the relevant directory and type
> HOPSPACK_main_serial hops_config.txt

QUESTIONS: 

Notice that:
- "hops_config.txt" is the only paramerization file that would typically be adjusted by end-user
- the Julia executable is "MakeItSo.exe"
- the routine HOPSPACK calls is "FlavioExample.bat"
- The solution will output to "hops_pointout.txt" (configurable in "hops_config.txt")
- HOPSPACK_main_serial is the program that minimizes the function
- "cache_in.txt" and "cache_out.txt" store intermediate results (configurable in "hops_config.txt")
- The executable was compiled from "main.jl" by running the "run_file.jl" script
- All the lib* files are required for the executable to run
- "out_params.txt" and "in_params.txt" are used inside of "FlavioExample.bat" to communicate with the executable (see TODO below)

If you have any questions about HOPSPACK I ask that you first read Section 5 of the manual "http://www.sandia.gov/hopspack/HopspackUserManual_2_0_2.pdf".


DISCLAIMER:
This worked for me on Windows 8 with Julia v0.040-dev.

TO RUN YOUR OWN FUNCTION:
You will need to learn how to build a Julia executable. To run the file that does this you will have to use the developer ("bleeding edge") version of julia at "http://julialang.org/downloads/#Nightly.builds". The warnings are there for a reason. When I was first working on this problem I did crash Julia and had to re-load it.

Then point yourself to "run-file.jl" here which has a code to get Julia v0.040 ready to run build-executable. More detail later.


ONGOING/TODO:
The largest hurdle is that only one citizen can safely run at a time. By safely I mean they may interfere with each other's work and unknowingly duplicate search. This problem arises from the Julia executable being unable to process arguments so I have to write a wrapper around the executable that stores the unique FID in (from HOPSPACK) to a common "in_params.txt" file for executable processing and then take the output stored in the common "out_params.txt" and have the wrapper rename it for HOPSPACK processing.

The issue is that there is nothing preventing two (or more) citizens from accessing the same "in_params.txt" or "out_params.txt" file. You would expect this occur as iterations or citizens got large.