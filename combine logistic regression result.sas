ods output ParameterEstimates = _pe OddsRatios=_or;
proc logistic data=raw2;
class	
model  =  /
					link=glogit selection=s lackfit;
run;
ods output close;	
data _pe (keep = Variable Estimate pValue id) ;
	set _pe;
	id = _N_;
	rename ProbChiSq = pValue;
run;

data _or(drop = Effect Response);;
	set _or;
	id = _N_ + 1;
run;
data __summary(drop = id);
	merge _pe _or;
	by id;
run;
