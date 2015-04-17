

function main()

	# !! for all packages !!
	# use import and definition rather than "using"
	# ex: import Optim 
	#     Optim.optimize()

	### Read in HOPSPACK param_vec
	numbers   = readdlm("in_params.txt")	
	prob_type = numbers[1] # F FC or C
	ntheta    = numbers[2] # length(theta)

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
		objfct1 = gratituous_sub_function(theta[1])
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
	fid_out = open("out_params.txt", "w")
	writedlm(fid_out, out_vec',"\r\n")
	close(fid_out)

	### always return 0!
	# put any error messages in first line of out_params (or "DNE" if only one value if undefined)
	return 0
end

function gratituous_sub_function(x::Float64)
		aux    = sqrt(x*(x^(1.0/3.0)))
		objfct1 = sin(x)/(1.0+aux)
end
