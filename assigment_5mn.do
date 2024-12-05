

// d = 1 : policy effect
// t = 6 : implementation time
// individual, treatment, time effects


use "\\smb-isl01.fsu.edu\citrix\mfn23a\Documents\Econometrics\dataset_assignment_5.dta"

gen time = 0
replace time = 1 if t>=6

gen did = time*d



//base did estimate
reg y time d did

//with all effects
reghdfe y did x1 x2 x3 x4 x5 x6 x7 x8 x9 x10, absorb(id t)


reghdfe y did x2 x3 x7, absorb(id t)

reghdfe y did x7, absorb(id t)
reghdfe y did x1 x7, absorb(id t)


macro drop _tuple*

local x_list x1 x2 x3 x4 x5 x6 x7 x8 x9 x10

tuples `x_list', min(8) display
di `ntuples'

tempname output11
postfile `output11' str30 tuple beta1 using "output11.dta", replace
forval i = 1/`ntuples' {
	qui reghdfe y did `tuple`i'' , absorb(id t)
	post `output11' ("`tuple`i''") (_b[did])
}
postclose `output11'

