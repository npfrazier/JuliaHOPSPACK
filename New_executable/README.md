

There will be some fixed costs to getting this set up correctly the first time.

### Download Julia v0.4

You will have to use the developer ("bleeding edge") version of Julia at <a href="http://julialang.org/downloads/#Nightly.builds">Bleeding Edge Build</a>. This should install "next" to Julia v0.3. Notice that need to build the executable in v0.4 but everything else can be done in v0.3 without any complication.

### Download HOPSPACK

I recommend you <a href="http://www.sandia.gov/hopspack/index.shtml">download and install HOPSPACK for your machine</a> now if you have not already so that is ready to go later. I also assume below that you have added HOPSPACK to your system path as this simplifies description and use of HOPSPACK in general.

### Prepare Julia

Open "run_file.jl" in Julia v0.4. Run the first script. Notice that first script is very straightforward for non-Windows users. This is likely because I have not tested it on non-Windows machines. 

### Build Executable

First time out I recommend building the example to abstract away from the problem of de-bugging the Julia objfun code while also learning to build executables. Notice that trying to de-bug the executable can be a frustrating process.

In one directory you should have:
 * "run_file.jl"
 * a .jl with a function main() that takes NO inputs. main() will be the only function directly called by the executable so it should call any others functions and contain "import" statements (rather in a pre-amble).
 * "build_executable.jl" and "build_sysimg.jl".** 


Now edit the paramerization section of "run_file.jl" to indicate the directory where you want to store executable. This could be same or different from where .jl file is. Both of these directories need to exist before running the program. Finally, finish running the script to build the executable. The executable will be created with a large number of library files that need to stay in the same folder as the executable.

To help understand what is going on I wrote some notes on using the executable that is set up running the <a href="#example">example problem</a>.

- "hops_config.txt" is the only paramerization file that would typically be adjusted by end-user
- the Julia executable is "MakeItSo.exe"
- the routine HOPSPACK calls is "example_exec.bat"
- The solution will output to "hops_pointout.txt" (configurable in "hops_config.txt")
- HOPSPACK_main_serial is the program that minimizes the function
- "cache_in.txt" and "cache_out.txt" store intermediate results (configurable in "hops_config.txt")
- The executable was compiled from "example_main_exec.jl" by running the "run_file.jl" script
- All the lib* files are required for the executable to run
- "out_params.txt" and "in_params.txt" are used inside of "FlavioExample.bat" to communicate with the executable (see TODO below)

### Run HOPSPACK

Once your executable is ready. Navigate to its folder. You should move the contents of the "exec" folder to the folder with your executable. Given this, I have set up everything so that HOPSPACK is ready to run the example from the previous page without further adjustment. What this means is that the local file: "hops_config.txt" has "example_exec.bat" as the name of the objective function. You may want to take a second to look at the other parameters but I recommend running it once before changing anything. Notice that it has two citizens by default. This will actually take longer than if you disable one citizen.

You can open "example_exec.bat" in a text editor and verify that is a batch file that copies what HOPSPACK sends to common files that can be accessed by the executable. To run a different executable you would need to edit the batch file and change the name from "MakeItSo". 

Ready to run. From your command line:

> HOPSPACK_main_serial hops_config.txt

The final result will be stored in "hops_pointout.txt." "cache_in.txt" and "cache_out.txt" will store intermediate trials. 




** These are included with Julia v0.4 when you download ("$PATH\AppData\Local\Julia-0.4.0-dev\share\julia" on Windows) but are NOT included in the Julia library. I have put them in this repo for convenience. You could add them to the Julia library but I recommend you leave them in the folder that has "run_file.jl"