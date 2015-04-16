


To make this work you need to do a few additional things!

First, edit the main_input.jl file and change the directory at the top to your directory.

Second, edit the directory in "no_exec_flavio_example.bat". This directory should be the one that contains "main_input.jl"

Third, "hops_config.txt" is actually ready to go. Notice that it has two citizens by default. This will actually take longer than if you disable one citizen.

Fourth, I did not include a copy of HOPSPACK_main_serial.exe here because it is large. You can (a) add HOPSPACK to the SYSTEM PATH, (b) move these files to a directory containing HOPSPACK_main_serial.exe, or (c) add the path before "hops_config.txt" when running the program.

Finally, ready to run. From your command line go to the directory indicated by your option from part 4:
(a) the folder with the .bat file,
(b) the folder with everything in it,
(c) amend below to "$(PATH)/hops_config.txt"
and then run:

> HOPSPACK_main_serial hops_config.txt