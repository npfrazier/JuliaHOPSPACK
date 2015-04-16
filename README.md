# JuliaHOPSPACK
Work in progress to integrate a Julia standalone executable into HOPSPACK. 

Tested only on Windows 8.

## OVERVIEW

At the moment there is a trade-off to make. You can (with a little effort) write a Julia executable that runs very quickly but in practice you are limited to one HOPSPACK citizen. You can also have Julia evaluate a script which is slower per-call but also allows for an arbitrary number of citizens. Thus, until someone gets the executable to accept arguments directly from HOPSPACK the approach should depend on the problem/resources at hand. Notably, for most applications there will be a more difficult to implement but faster option (executable) and a low cost but slower option (no executable).

INDEX
 * <a href="#noexec">Without Executable</a>
 * <a href="#exec">With Executable</a>
 * <a href="#buildexec">Build your Own Executable</a>
 * <a href="#todo">Known Issues and TODOs</a>


 <a name="noexec"></a> 
### NO EXECUTABLE: 

If simplicity is your preferred virtue the low cost way to integrate HOPSPACK (with any number of citizens) is write a batch file that launches the a new kernel. The quick way to make this work is to add the folder with the Julia executable to your path (on my machine this is "C:\Users\Nick\AppData\Local\Julia-0.3.5\bin") and look at the batch file in the no_executable folder for the gist of the procedure. The example is set up there for Flavio's example and two HOPSPACK citizens.

As a comparison, this is not substantially slower for this problem but WILL become a problem if you like to use lots of "using ..." statements. Switching to "import" so NOT

> using Distributions" 

but

> import Distributions  
> Distributions.Normal

will save a little bit of time. Notice the overall tradeoff here is that writing the executable will save run time for each calculation but potentially you can have any number of HOPSPACK citizens if running Julia as a new kernel. 

<a name="exec"></a> 


### USING EXECUTABLE: 

Everything you need to run Flavio's HOPSPACK example from class is located in the relevant folder. The example minimizes the function

> f(x) = sin(x/(  1+ sqrt( x*x^(1/3) ) )) 

for x scalar. The global minimum is at 1. 

To run HOPSPACK use your command line to go to the directory with the content from Flavio_Example and type
> HOPSPACK_main_serial hops_config.txt

The solution should output to "hops_pointout.txt". <a name="FAQ"></a> 

QUESTIONS: 

First notice that:
- "hops_config.txt" is the only paramerization file that would typically be adjusted by end-user
- the Julia executable is "MakeItSo.exe"
- the routine HOPSPACK calls is "FlavioExample.bat"
- The solution will output to "hops_pointout.txt" (configurable in "hops_config.txt")
- HOPSPACK_main_serial is the program that minimizes the function
- "cache_in.txt" and "cache_out.txt" store intermediate results (configurable in "hops_config.txt")
- The executable was compiled from "main.jl" by running the "run_file.jl" script
- All the lib* files are required for the executable to run
- "out_params.txt" and "in_params.txt" are used inside of "FlavioExample.bat" to communicate with the executable (see TODO below)

If you have any questions about HOPSPACK I ask that you first read Section 5 of the manual <a href="http://www.sandia.gov/hopspack/HopspackUserManual_2_0_2.pdf">HOPSPACK documentation</a>. <a name="buildexec"></a> 


## TO RUN YOUR OWN FUNCTION: 

You will need to learn how to build a Julia executable. To run the file that does this you will have to use the developer ("bleeding edge") version of julia at <a href="http://julialang.org/downloads/#Nightly.builds">Bleeding Edge Build</a>. The warnings are there for a reason. When I was first working on this problem I did crash Julia and had to re-load it.

It is probably convenient to grab the contents of the new_executable folder which has an outline for completing the process. Open "run-file.jl" which has a first script to get Julia v0.040 ready to run build-executable and a second script that builds the executable. More details later.  <a name="todo"></a> 

DISCLAIMER: This worked for me on Windows 8 with Julia v0.040-dev.

## ONGOING/TODO:

The largest hurdle is that only one citizen can safely run at a time. By safely I mean they may interfere with each other's work and unknowingly duplicate search. This problem arises from the Julia executable being unable to process arguments so I have to write a wrapper around the executable that stores the unique FID in (from HOPSPACK) to a common "in_params.txt" file for executable processing and then take the output stored in the common "out_params.txt" and have the wrapper rename it for HOPSPACK processing.

The issue is that there is nothing preventing two (or more) citizens from accessing the same "in_params.txt" or "out_params.txt" file. You would expect this occur as iterations or citizens got large.
