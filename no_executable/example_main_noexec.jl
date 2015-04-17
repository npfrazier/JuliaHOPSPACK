
# !! for all packages !!
# better to use import and definition rather than "using"
# ex: import Optim 
#     Optim.optimize()


# The batch file will pass the following arguments 
# IN_FILE = ARGS[1]   
# OUT_FILE = ARGS[2]   
# LocalDirectory - Where to expect in_file and out_file

# ARGS stores any arguments passed to Julia through command line
file_in  = ARGS[1]
file_out = ARGS[2]
localdir = ARGS[3]

cd(localdir)

# rest of program is identical

### Read in HOPSPACK param_vec
numbers   = readdlm(file_in)	
prob_type = numbers[1] # F FC or C
ntheta    = int(numbers[2]) # length(theta)

### Create parameter vector
theta     = zeros(ntheta)
for ii in 1:ntheta
	theta[ii] = numbers[2+ii]
end

### Calculate values
# Replace with "DNE" as value if undefined
# run obj function
objfct1 = []
try
	aux    = sqrt(theta[1]*(theta[1]^(1.0/3.0)))
	objfct1 = sin(theta[1])/(1.0+aux)
catch
	objfct1 = "DNE"
end

#  could have constraints or multiple objfun vals	


###  store all values to be passed to HOPSPACK
Fvals   = [objfct1]         # [objfct1; objfct2; objfct3]
nFvals  = length(Fvals)
NLCvals = [ ]
nNLC    = length(NLCvals) 
LCvals  = [ ]
nLC     = length(LCvals) 

### print output to HOPSPACK
out_vec = []
if prob_type[1] == 'F' # check if objfun values requested
	# add to output result
	out_vec = [out_vec; nFvals; Fvals]
end

if ismatch(r"(C)", prob_type) 	# check if constraints request
	# add to output result
	out_vec = [out_vec; nNLC; NLCvals]
	out_vec = [out_vec; nLC; LCvals]
end

### write output
fid_out = open(file_out, "w")
writedlm(fid_out, out_vec',"\r\n")
close(fid_out)
