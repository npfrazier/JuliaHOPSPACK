

##### First script
##### Set up ability to build executables

# download julia for developers
# http://julialang.org/downloads/#Nightly.builds

#
Pkg.update()
Pkg.add("WinRPM")
WinRPM.update()
Pkg.update() # should be nothing to do


using WinRPM
WinRPM.install("gcc")


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


# this is where build_executable.jl,etc and your_name.jl is located
julia_dir = "$(homedir())/skydrive/projects/laborecon/optimize" 
jl_name   = "main.jl" # "main.jl"

# Executable
exec_name = "MakeItSo" # name for executable
exec_dir  =  "$(homedir())/skydrive/projects/laborecon/optimize/" # where you want the executable located

force     = true        # if .exe already exists then replace it
targetdir = abspath(exec_dir)

cd(julia_dir)
include("build_executable.jl") # loads file that make executable

build_executable(exec_name,jl_name,targetdir;force=true)