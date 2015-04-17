# JuliaHOPSPACK
Work in progress to integrate Julia-coded value functions into HOPSPACK search.

Tested only on Windows 8.

## OVERVIEW

As you might expect there is a choice to be made.

I see two ready-to-implement strategies for running HOPSPACK. For quick reference I provide a bullet point summary here and a more detailed discussion below. All code in the repo is set up to run the <a href="#example">example problem</a>.

### QUICK DISCUSSION

#### No Executable
 * Relatively easy/quick to set up 
 * Easier to de-bug on on-going basis
 * Allows multiple citizens
 * Potentially slow per-function-call


#### Executable
 * Larger fixed cost to set up
 * Usually much faster per-function-call
 * Requires using Julia v0.4.0 to build executable
 * De-bugging requires re-building executable
 * Permits only one citizen


#### QUICK INDEX
 * <a href="#discuss">Discussion: Exec or No Exec</a>
 * <a href="#hops">Install HOPSPACK</a>
 * <a href="#noexec">Without Executable</a>
 * <a href="#exec">With Executable</a>
 * <a href="#example">Example Problem</a>
 * <a href="#todo">Known Issues and TODOs</a>
 <a name="discuss"></a> 


### DISCUSSION: EXEC OR NO EXEC

The first option requires no executable and has a low fixed cost to set up but will run much slower per function call. The second has a larger fixed cost (at least the first time) but runs faster per function call. At the moment, only the first options permits the use of more than one HOPSPACK citizen though its worth noting that adding citizens in serial (without setting up parallel processing) *may* increase robustness/confidence in the solution but will also increase time to solution. Essentially the first option sets up a batch file wrapper that calls Julia from the command line and has it run some specified function. Obviously this requires initiating a new kernel each time which is slow, especially if you want to use lots of packages, but does happen faster than loading the REPL and with a little bit of planning is not unreasonably slow. The second option creates an executable out of the Julia that can only be run on the computer on which you built it. This executable will typically run much faster than loading a new Julia kernel and so speed per-function-call time. The cost is that at the moment the executable is unable to parse/receive arguments passed to it so it is wrapped in a batch file that writes HOPSPACK input.output to and from common text files (e.g. fromhops.txt and tohops.txt). These common files are the same no matter how many concurrent copies of the executable are running and so citizens could potentially unknowingly interfere with each other. 

To set up the first option requires a de-bugged JuliA code and a couple of minor changes to a batch file and then HOPSPACK will run (though possibly slowly). The second options requires installing the v0.4.0 of Julia, currently under development, which will allow you build executables. [It is probably more effort than it is worth to try and make the executable_builder script run with Julia v0.03*---the currently stable build.] Once you have installed the developer version, I have provided script that walks through the process of setting up your system and then building an executable. Notably, the marginal cost of creating another executable is fairly low once fixed costs have been paid. However, the executable will only run (so far) on the system on which it was built. That being said it runs pretty quick and presumably the overall process will improve as Julia grows. Thus, until someone gets the executable to accept arguments directly from HOPSPACK the approach should depend on the problem/resources at hand. Notably, for most applications there will be a more difficult to implement but faster option (executable) and a low cost but slower option (no executable).
<a name="hops"></a>


### INSTALL HOPSPACK

For convenience, included in this repo is a HOPSPACK executable for Windows that can be used out of the box. However, the best way forward would be to <a href="http://www.sandia.gov/hopspack/index.shtml">install HOPSPACK for your machine</a>. This will provide a HOPSPACK executable that you can move around to the relevant folder or add to path and leave in a fixed folder (or leave it in a fixed folder and be conscientious with specifying file locations). 

When running HOPSPACK given a working objective function, "hops_config.txt" is the only paramerization file that would typically be adjusted by end-user.


For more information on how HOPSPACK works you are encouraged to read Section 5 of the <a href="http://www.sandia.gov/hopspack/HopspackUserManual_2_0_2.pdf">HOPSPACK documentation</a>. 
<a name="noexec"></a> 

### NO EXECUTABLE: 

If simplicity is your preferred virtue the low cost way to integrate HOPSPACK (with any number of citizens) is write a batch file that launches the a new kernel. The quick way to make this work is to add the folder with the Julia executable to your path (on my machine this path is "C:\Users\Nick\AppData\Local\Julia-0.3.5\bin") and look at the batch file in the provided no_executable folder for the gist of the procedure. The code is pre-set to run the <a href="#example">example problem</a> with two HOPSPACK citizens. There is a readme file to finish the set-up on your local machine. Assuming you can run HOPSPACK on your machine then you should be able to get up and running in a 10 minutes or so. 
<a name="exec"></a> 

### WITH EXECUTABLE: 

You will need to learn how to build a Julia executable. I provide a script that walks you through the process but you will have to use the developer ("bleeding edge") version of Julia at <a href="http://julialang.org/downloads/#Nightly.builds">Bleeding Edge Build</a>. Please note that the warnings are there for a reason. When I was first working on this problem I did crash Julia and had to re-load it.

Once you have HOPSPACK and Julia v0.4.0 it is probably convenient to grab the contents of the new_executable folder which has an outline for completing the process. Open "run-file.jl" which has a first script to get Julia v0.4.0 ready to run build-executable and a second script that builds the executable. Once you sucessfully build your first executable, future executables should be relatively easy to build. For this reason I recommend building the example to abstract away from the problem of de-bugging the Julia objfun code while also learning to build executables.  
<a name="example"></a> 

### EXAMPLE:

The example minimizes the function

> f(x) = sin(x/(  1+ sqrt( x*x^(1/3) ) )) 

for x scalar. The global minimum is at 1. 

To run HOPSPACK use your command line to go to the directory with the content from Flavio_Example and type

> HOPSPACK_main_serial hops_config.txt

The solution should output to "hops_pointout.txt". 
<a name="FAQ"></a> 


## ONGOING/TODO:

For the executable approach, the largest hurdle is that the Julia executable relies on a common .txt file to communicate with the outside world. Therefore, only one citizen can safely run at a time and multiple citizens might call the executable simulatenously and unknowingly use the same common file. This could be solved by getting the executable to parse passed arguments.

