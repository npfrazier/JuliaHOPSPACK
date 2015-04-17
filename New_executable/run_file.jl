

##### First script
##### Set up ability to build executables

# download julia for developers
# http://julialang.org/downloads/#Nightly.builds

# 
Pkg.update()

##########
# IF YOU ARE RUNNING WINDOWS
Pkg.add("WinRPM")
WinRPM.update()

using WinRPM
WinRPM.install("gcc")
# 
#########

# The default Julia packages (like LAPACK) are added to the executable but additional packages (like Distributions and Optim) are not. Add any packages you plan to call in your objective function the usual way
# e.g. Pkg.add("whatever")

# note that no packages are needed for the example



##### Second script
##### Make an executable

# what you need:
## In one directory you should:
### a .jl with a function main() that takes NO inputs (should only be one main.jl). main() will perform all function and processes and return output of executable
### build_executable.jl and build_sysimg.jl
## directory where you want to store executable. 
### Could be same or different from where .jl file is

# both of these directories need to exist before running the program
# Could be same directory!

### Parameterize

# this is where build_executable.jl,etc and your_name.jl is located
julia_dir = "$(homedir())/skydrive/projects/j_library/juliahopspack/new_executable" 
jl_name   = "example_main_exec.jl" # "main.jl"

# Executable
exec_name = "MakeItSo" # name for executable
exec_dir  =  "$(homedir())/skydrive/projects/j_library/juliahopspack/new_executable/exec" # where you want the executable located

### BUILD EXECUTABLE

force     = true        # if .exe already exists then replace it
targetdir = abspath(exec_dir)

cd(julia_dir)
include("build_executable.jl") # loads file that make executable

build_executable(exec_name,jl_name,targetdir;force=true)