(* ::Package:: *)

(* TODO: 30/04/2020: Add BerryPhase function, perhaps to Optics module *)
(* Mathematica Package  *)

(* :Title: TBpack *)
(* :Author: Vasil A. Saroka <40.ovasil@gmail.com> *)
(* :Context: TBpack` *)
(* :Version: 0.5.0 *)
(* :Date: 2022-02-19 *)

(* :Mathematica Version: 10.0+ *)
(* :Copyright: (c) 2020 Vasil A. Saroka *)

BeginPackage["TBpack`", {"TBpack`UnitcellGenerators`", "TBpack`DataAnalysis`","TBpack`Optimization`","TBpack`Optics`","TBpack`Sneg`"}];

Unprotect[Evaluate[$Context<>"*"]]; (* taken from CustomTicks package *)


(* Usage messages: use here String Representation of Boxes to get formatting similar to built-in functions *)

(* for Functions *)
Hamiltonian::usage = "Hamiltonian[\!\(\*RowBox[{\"{\", StyleBox[SubscriptBox[\"unitcell\",\"1\"],\"TI\"],\",\", StyleBox[SubscriptBox[\"unitcell\",\"2\"],\"TI\"], \"}\"}]\)] constructs Hamiltonian and overlapping matrices for a system presented by the \!\(\*StyleBox[\"unitcell\",\"TI\"]\) list of ideal \!\(\*StyleBox[SubscriptBox[\"unitcell\",\"1\"],\"TI\"]\) and relaxed \!\(\*StyleBox[SubscriptBox[\"unitcell\",\"2\"],\"TI\"]\).
Hamiltonian[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"options\",\"TI\"]}]\)] constucts Hamiltonian and overlapping matrices using specified option settings.
Hamiltonian[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , \"TranslationVectors\" ,\"\[Rule]\", \"{{\", StyleBox[SubscriptBox[\"tr\",\" 11\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"tr\",\" 12\"],\"TI\"], \",\" , \"\[Ellipsis]\" , \"},{\" , StyleBox[SubscriptBox[\"tr\",\" 21\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"tr\",\" 22\"],\"TI\"], \",\" , \"\[Ellipsis]\",\"}}\" }]\)] uses lists of ideal \!\(\*StyleBox[SubscriptBox[\"tr\",\"1n\"],\"TI\"]\) and relaxed \!\(\*StyleBox[SubscriptBox[\"tr\",\"2n\"],\"TI\"]\) translation vectors.";

ElectronicStructure::usage = "ElectronicStructure[\!\(\*RowBox[{\"{\", StyleBox[SubscriptBox[\"unitcell\",\"1\"],\"TI\"],\",\", StyleBox[SubscriptBox[\"unitcell\",\"2\"],\"TI\"], \"}\"}]\)] calculates electronic energy levels for a system presented by the \!\(\*StyleBox[\"unitcell\",\"TI\"]\) list of ideal \!\(\*StyleBox[SubscriptBox[\"unitcell\",\"1\"],\"TI\"]\) and relaxed \!\(\*StyleBox[SubscriptBox[\"unitcell\",\"2\"],\"TI\"]\).
ElectronicStructure[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"options\",\"TI\"]}]\)] calculates electronic energy levels for a system using specified option settings.
ElectronicStructure[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , \"EigenVectors\", \"\[Rule]\", StyleBox[\"True\",\"TI\"] }]\)] returns a list of electronic energy levels, eigenvectors and velocity operator matrices.
ElectronicStructure[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , \"TranslationVectors\" ,\"\[Rule]\", \"{{\", StyleBox[SubscriptBox[\"tr\",\"11\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"tr\",\" 12\"],\"TI\"], \",\" , \"\[Ellipsis]\" , \"},{\" , StyleBox[SubscriptBox[\"tr\",\" 21\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"tr\",\" 22\"],\"TI\"], \",\" , \"\[Ellipsis]\",\"}}\" }]\)] uses ideal \!\(\*StyleBox[SubscriptBox[\"tr\",\"1n\"],\"TI\"]\) and relaxed \!\(\*StyleBox[SubscriptBox[\"tr\",\"2n\"],\"TI\"]\) translation vectors and the \!\(\*StyleBox[\"k\",\"TI\"]\)-point {0,0,0}.
ElectronicStructure[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , \"TranslationVectors\" ,\"\[Rule]\", \"{\", StyleBox[SubscriptBox[\"tr\",\"1\"],\"TI\"] , \",\" , StyleBox[SubscriptBox[\"tr\",\"2\"],\"TI\"], \"}\", \",\" , Kpoint, \"\[Rule]\", StyleBox[\"klist\",\"TI\"] }]\)] uses the list of \!\(\*StyleBox[\"k\",\"TI\"]\)-points \!\(\*StyleBox[\"klist\",\"TI\"]\).
ElectronicStructure[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , \"TranslationVectors\" ,\"\[Rule]\", \"{\", StyleBox[SubscriptBox[\"tr\",\"1\"],\"TI\"] , \",\" , StyleBox[SubscriptBox[\"tr\",\"2\"],\"TI\"], \"}\", \",\" , Kpoint, \"\[Rule]\", StyleBox[\"klist\",\"TI\"], \",\" , ParallelEvaluation, \"\[Rule]\", StyleBox[\"True\",\"TI\"] }]\)] calculates in parallel for different elements of \!\(\*StyleBox[\"klist\",\"TI\"]\).";

ElectronicBands1D::usage = "ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"]}]\)] calculates electronic energy bands for a 1D system presented by \!\(\*StyleBox[\"unitcell\",\"TI\"]\) and the translation vector \!\(\*StyleBox[\"tr\",\"TI\"]\). 
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , StyleBox[\"options\",\"TI\"]}]\)] calculates electronic energy bands using specified options.
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"TBModelParameters\" , \"\[Rule]\" , StyleBox[\"list\",\"TI\"]}]\)] uses specified tight-binding model parameters given as \!\(\*StyleBox[\"list\",\"TI\"]\).
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"HoppingDistances\" , \"\[Rule]\" , StyleBox[\"list\",\"TI\"]}]\)] uses specified hopping distances given as \!\(\*StyleBox[\"list\",\"TI\"]\).
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"HoppingDistanceDelta\" , \"\[Rule]\" , StyleBox[\"value\",\"TI\"]}]\)] uses specified \!\(\*StyleBox[\"value\",\"TI\"]\) of the largest absolute deviation of the hopping distances.
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"Efield\" , \"\[Rule]\" , StyleBox[\"vector\",\"TI\"]}]\)] uses specified external electric field set by 3 Cartesian component \!\(\*StyleBox[\"vector\",\"TI\"]\).
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"Bfield\" , \"\[Rule]\" , StyleBox[\"vector\",\"TI\"]}]\)] uses specified external magnetic field set by 3 Cartesian component \!\(\*StyleBox[\"vector\",\"TI\"]\).
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"NumberOfKpoints\" , \"\[Rule]\" , StyleBox[\"value\",\"TI\"]}]\)] uses specified by \!\(\*StyleBox[\"value\",\"TI\"]\) the number of \!\(\*StyleBox[\"k\",\"TI\"]\)-points in a uniform grid of 1D reciprocal space.
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"EigenVectors\" , \"\[Rule]\" , StyleBox[\"True\",\"TI\"]}]\)] returns a list of electronic energy bands, eigenvectors and velocity operator matrices.
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"ParallelEvaluation\" , \"\[Rule]\" , StyleBox[\"True\",\"TI\"]}]\)] calculates in parallel for different \!\(\*StyleBox[\"k\",\"TI\"]\)-points.
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"RelaxGeometry\" , \"\[Rule]\" , StyleBox[\"True\",\"TI\"], \",\" , \"OptimizationProgram\" , \"\[Rule]\" , \"{\", StyleBox[\"integer\",\"TI\"], \",\" , StyleBox[\"path\",\"TI\"] , \",\", StyleBox[\"fname\",\"TI\"], \",\", StyleBox[\"opts\",\"TI\"] , \"}\"}]\)] uses geometry optimization of the unit cell by the program set by \!\(\*StyleBox[\"integer\",\"TI\"]\), located at \!\(\*StyleBox[\"path\",\"TI\"]\), with executable \!\(\*StyleBox[\"fname\",\"TI\"]\) and options \!\(\*StyleBox[\"opts\",\"TI\"]\).
ElectronicBands1D[\!\(\*RowBox[{StyleBox[\"unitcell\",\"TI\"], \",\" , StyleBox[\"tr\",\"TI\"] , \",\" , \"Path2Save\" , \"\[Rule]\" , StyleBox[\"path\",\"TI\"]}]\)] saves the results of the calculation in a file located at \!\(\*StyleBox[\"path\",\"TI\"]\).";

(* for Options *)
TranslationVectors::usage = "Option specifying the primitive translations in \[Angstrom].";
HoppingIntegrals::usage = "Option specifying the values of the tight-binding hopping integrals as \!\(\*RowBox[{\"{\" , StyleBox[SubscriptBox[\"t\",\"0\"],\"TI\"] , \",\" , StyleBox[SubscriptBox[\"t\",\"1\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"t\",\"2\"],\"TI\"] , \"\[Ellipsis]\" , \"}\" }]\) in eV.  See also \!\(\*StyleBox[\"HoppingDistances\",\"TI\"]\).";
OverlappingIntegrals::usage = "Option specifying the values of the ovelapping integrals as \!\(\*RowBox[{\"{\" , StyleBox[SubscriptBox[\"s\",\"0\"],\"TI\"] , \",\" , StyleBox[SubscriptBox[\"s\",\"1\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"s\",\"2\"],\"TI\"] , \"\[Ellipsis]\" , \"}\" }]\),  where \!\(\*StyleBox[SubscriptBox[\"s\",\"0\"],\"TI\"]\) is equal to 1 at all times.";
HoppingDistances::usage = "Option specifying distances between atomic sites ascendingly \!\(\*RowBox[{\"{\" , StyleBox[SubscriptBox[\"d\",\"0\"],\"TI\"] , \",\" , StyleBox[SubscriptBox[\"d\",\"1\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"d\",\"2\"],\"TI\"] , \"\[Ellipsis]\" , \"}\" }]\) in \[Angstrom] and matching to the hopping integrals \!\(\*RowBox[{\"{\" , StyleBox[SubscriptBox[\"t\",\"0\"],\"TI\"] , \",\" , StyleBox[SubscriptBox[\"t\",\"1\"],\"TI\"], \",\" , StyleBox[SubscriptBox[\"t\",\"2\"],\"TI\"] , \"\[Ellipsis]\" , \"}\" }]\). \!\(\*StyleBox[SubscriptBox[\"d\",\"0\"],\"TI\"]\) is equal to 0 at all times.";
StrainExponent::usage = "Option setting \[Beta] in Exp[\!\(\*RowBox[{\"-\", \[Beta],  \"(\", StyleBox[\"l\",\"TI\"] , \"-\", StyleBox[SubscriptBox[\"l\",\"0\"],\"TI\"] ,\")\", \"/\", StyleBox[SubscriptBox[\"l\",\"0\"],\"TI\"]}]\)] in front of the tight-binding hopping integrals \!\(\*StyleBox[SubscriptBox[\"t\",\"1\"],\"TI\"]\), \!\(\*StyleBox[SubscriptBox[\"t\",\"2\"],\"TI\"]\), and etc. ";
Kpoint::usage = "Option setting the Cartesian components of the \!\(\*StyleBox[\"k\",\"TI\"]\)-points in the reciprocal space in 1/\[Angstrom].";
Efield::usage = "Option setting the Cartesian components of a homogeneous external electric field in V/\[Angstrom].";
Bfield::usage = "Option setting the Cartesian components of a homogeneous external magnetic field in T.";
EdgeCorrections::usage = "Option setting the hopping integral edge corrections in eV corresponding to coordination number 1 and 2 in the 2D hexagonal lattice.";
HoppingDistanceDelta::usage = "Option setting the largest absolute deviation in \[Angstrom] for which the hopping distance is still considered as matching to the coressponding tight-binding hopping integral, see V. A. Saroka, K. G. Batrakov, and L. A. Chernozatonskii, Phys. Solid State 56, 2135 (2014).";
SuperCellSize::usage = "Option specifying how many unit cells are contained in the supercell: 0D- 1; 1D- \!\(\*RowBox[{ \"2\" , StyleBox[\"n\",\"TI\"], \"+\", \"1\"}]\); 2D- \!\(\*SuperscriptBox[RowBox[{\"(\", \"2\" , StyleBox[\"n\",\"TI\"], \"+\", \"1\", \")\"}],\"2\"]\); 3D- \!\(\*SuperscriptBox[RowBox[{\"(\", \"2\" , StyleBox[\"n\",\"TI\"], \"+\", \"1\", \")\"}],\"3\"]\), where \!\(\*StyleBox[\"n\",\"TI\"]\) is a positive integer option value."

ParallelEvaluation::usage = "Option in some functions taking values \!\(\*StyleBox[\"True\",\"TI\"]\) or \!\(\*StyleBox[\"False\",\"TI\"]\) to specify choice of between usage of \!\(\*StyleBox[\"ParalleTable\",\"TI\"]\) and \!\(\*StyleBox[\"Table\",\"TI\"]\).";
EigenVectors::usage = "Option in some functions taking values \!\(\*StyleBox[\"True\",\"TI\"]\) or \!\(\*StyleBox[\"False\",\"TI\"]\) to specify usage of \!\(\*StyleBox[\"Eigenvalues\",\"TI\"]\) or \!\(\*StyleBox[\"Eigensystem\",\"TI\"]\).";

TBModelParameters::usage = "Option in some functions setting a list of the tight-binding parameters: {\!\(\*RowBox[{StyleBox[\"HoppingIntegrals\",\"TI\"], \",\" , StyleBox[\"OverlappingIntegrals\",\"TI\"], \",\" , StyleBox[\"StrainExponent\",\"TI\"], \",\" , StyleBox[\"EdgeCorrections\",\"TI\"]}]\)}.";
RelaxGeometry::usage = "Option in some functions specifying if the geometry optimization should be performed and choosing the optimization program.";
NumberOfKpoints::usage = "Option in some functions specifying the number of \!\(\*StyleBox[\"k\",\"TI\"]\)-points in the uniform 1D grid.";
Krange::usage = "Option in some functions specifying the range of \!\(\*StyleBox[\"k\",\"TI\"]\)-space to be meshed.";
OptimizationProgram::usage = "Option in some functions specifying the type of, path to, an executable file name and other options for the program that is to run geometry optimization: \!\(\*RowBox[{\"{\", StyleBox[\"type\",\"TI\"], \",\", StyleBox[\"path\",\"TI\"],\",\", StyleBox[\"fname\",\"TI\"], \",\", StyleBox[\"opts\",\"TI\"] ,\"}\"}]\).";
OptimizationFunction::usage = "Option in some functions specifying a name and list options for the function that is to run geometry optimization: \!\(\*RowBox[{\"{\", StyleBox[\"fun\",\"TI\"], \",\", StyleBox[\"opts\",\"TI\"] ,\"}\"}]\).";
Path2Save::usage = "Option in some functions setting the path to save the results of calculations. By default, it is \*StyleBox[\"$HomeDirectory\",\"TI\"]."

(* for general options used in and across TBpack subpackages, such as DataAnalysis, Optimization and etc. *)
Path2File::usage = "Option specifying a path to a file directory in such functions as \*StyleBox[\"ReadElectronicBands1D\",\"TI\"].";
FileName::usage = "Option specifying the name of the file to be processed or executed by such functions as \*StyleBox[\"ReadElectronicBands1D\",\"TI\"].";
LatticeConstant::usage = "Option specifying the scale of the 2D hexagonal lattice in \[Angstrom].";
BondLengthDelta::usage = "Option setting in \[Angstrom] the maximum deviation of the bond length in the unit cell from the explicitly specified bond length value.";
InputScriptTemplate::usage = "Option in some functions for providing an external program script template.";


(* Constants *)
$TBpackDirectory::usage = "$TBpackDirectory gives directory where TBpack.m file is located.";




Begin["`Private`"]

$TBpackDirectory = DirectoryName[$InputFileName];

(* Error messages *)
Hamiltonian::optlength = "HoppingIntegrals, OverlappingIntegrals, HoppingDistantes lists and elements of EdgeCorrections matrix must have the same lengths." 

(* System tigh-binding Hamiltonian and overlapping matrices *)
Options[Hamiltonian] = {
	TranslationVectors -> {{},{}},
	HoppingIntegrals -> {0,3.12,0,0},
	OverlappingIntegrals -> {1,0,0,0},
	HoppingDistances -> {0,1.42,2.46,2.84}(* graphene hexagonal lattice *),
	StrainExponent -> 3,
	Kpoint -> {0,0,0},
	Efield -> {0,0,0},
	Bfield -> {0,0,0},
	EdgeCorrections -> {
		{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
		{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, 
		{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}
		},
	HoppingDistanceDelta -> 0.05,
	SuperCellSize -> 1};
	
Hamiltonian[unitcell_List, OptionsPattern[]] := Catch[
Module[
{
	translationvectors = OptionValue[TranslationVectors],
	hoppingintegrals = OptionValue[HoppingIntegrals],
	overlappingintegrals = OptionValue[OverlappingIntegrals],
	hoppingdistances = OptionValue[HoppingDistances],
	strain = OptionValue[StrainExponent],
	k = OptionValue[Kpoint],
	efield = OptionValue[Efield],
	bfield = OptionValue[Bfield],
	edgecorrections = OptionValue[EdgeCorrections],
	hoppingdistancedelta = OptionValue[HoppingDistanceDelta],
	supercellsize = OptionValue[SuperCellSize],
	
	tlen,len,
	supercell,unum,
	uc,T1,T2,T3,
	aplist,anum,
	cnlist,
	
	hdlen,bondconfiglist,
	bondvectorlist,
	bondvector,
	
	H,S,hij,sij,
	r1,r2,r12,
	t,s,
	idealbondlength,
	optimizedbondlength,
	relbonddeformation,
	mflux,
	mfluxquanta = SetPrecision[2.067833758 10^5, Infinity](* flux quanta T \[Angstrom]^2*)
	(* mfluxquanta is rationalized to set its precision to infinity *),
	mphase,
	sphase,
	dt,tE,
	
	hlen,etest,
	
	hd,
	hdfun,
	hifun,
	oifun,
	
	(* subfunctions *)
	U,
	realnumbersQ
	
},

(*
Error messages:

Hamiltonian4TBpack::arg1="The argument `1` should be a list of points in 3D space.";Hamiltonian4TBpack::arg2="The argument `1` should be a list numeric vectors of 3D space or a list of lists of such vectors up to 3 ones.";
Hamiltonian4TBpack::inconsarg="Arguments `1` , `2` must have the same lengths which is less than length of `3`.";

tf1=MatchQ[#1,{arg___?(VectorQ[#1,NumericQ]&&Length[#1]==3&)}]&;tf2=(MatchQ[#1,{arg___?(VectorQ[#1,NumericQ]&&Length[#1]==3&)}]&&Length[#1]<=3)&;

If[!And@@(tf1/@unitcell),Throw[Message[Hamiltonian4TBpack::arg1,unitcell]]];
If[!And@@(tf2/@translationvectors),Throw[Message[Hamiltonian4TBpack::arg2,translationvectors]]];
If[!(Length@hoppingintegrals==Length@overlappingintegrals<=Length@nnlengthlist),Throw[Message[Hamiltonian4TBpack::inconsarg,hoppingintegrals,overlappingintegrals,nnlengthlist]]];

*)

(* Checking arguments and options *)
If[
	!SameQ[
			Length[hoppingintegrals],
			Length[overlappingintegrals],
			Length[hoppingdistances],
			Dimensions[edgecorrections][[3]]
	](* end SameQ *),
	Message[Hamiltonian::optlength];
	Throw[$Failed]
];

(*-------------------- subfunctions --------------------*)
(* Electrostatic potential *)
U[r_,e_]:=-r.e;  (* Homogenious electric field *)

(* exlcude numbers with heads Complex and Rational *)
realnumbersQ[n1_,n2_]:=(
							(Head[n1] === Real && Head[n2] === Real) ||
							(Head[n1] === Integer && Head[n2] === Real) || 
							(Head[n1] === Real && Head[n2] === Integer) ||
							(Head[n1] === Integer && Head[n2] === Integer)
);
(*------------------------------------------------------*)


(* First argument structure: unitcell={idealunitcell,optimizedunitcell};
   TranslationVectors option value structure: translationvectors={idealtranslationvectors,optimizedtranslationvectors} *)
tlen = Dimensions[translationvectors][[2]];
len = Dimensions[unitcell][[2]];

(* supercell is the initial unitcell + adjacent unitcells *)
supercell = Table[
	Switch[
	tlen,
	0,
		unum = 1;
		uc = unitcell[[o]];
		{uc},
	1,
		unum = 2 supercellsize + 1;
		T1 = translationvectors[[o,1]];
		uc = unitcell[[o]];
		Table[(#1 + i T1)&/@uc,{i,-supercellsize,supercellsize}],
	2,
		unum = (2 supercellsize + 1)^2;
		T1 = translationvectors[[o,1]];
		T2 = translationvectors[[o,2]];
		uc = unitcell[[o]];
		Flatten[Table[(#1 + i T1 + j T2)&/@uc,{i,-supercellsize,supercellsize},{j,-supercellsize,supercellsize}],1],
	3,
		unum = (2 supercellsize + 1)^3;
		T1 = translationvectors[[o,1]];
		T2 = translationvectors[[o,2]];
		T3 = translationvectors[[o,3]];
		uc = unitcell[[o]];
		Flatten[Table[(#1 + i T1 + j T2 + k T3)&/@uc,{i,-supercellsize,supercellsize},{j,-supercellsize,supercellsize},{k,-supercellsize,supercellsize}],2]],
{o,1,2}](* end Table *);



aplist = Flatten[supercell[[1]],1];(* atom position list *)
anum = Length[aplist];

(* local bond configuration *)
(* bondconfiglist structure:
{
	{pos,{bondvectorlist0,bondvectorlist1,bondvectorlist2, ...}},
	{pos2,{bondvectorlist0,bondvectorlist1,bondvectorlist2, ...}},
	...
}

bondvectorlist0 = {} is normally an empty list
bondvectorlist1 contains vectors to the nearest neighbors
 *)
hdlen = Length[hoppingdistances];
bondconfiglist = Table[
   bondvectorlist = Table[{}, {i, hdlen}];
   Do[	
   		r2 = aplist[[j]];
   		r1 = unitcell[[1, i]];
    	bondvector = r2 - r1;
    	idealbondlength = Sqrt[bondvector.bondvector];
    	Do[
    		If[
    			If[
					realnumbersQ[idealbondlength,hoppingdistances[[n]]],
					Abs[idealbondlength - hoppingdistances[[n]]] < hoppingdistancedelta,
					(* if idealbondlength and given hoppingdistance are not a real numbers 
						then they can be treated symbolically, so an exact comparison is attempted *)
					(* Sqrt[x_^2] :> x means that all symbols in the expression are stand for positive real numbers *)
					hoppingdistances[[n]] === (idealbondlength/.Sqrt[x_^2] :> x)
				]
				, 
      			AppendTo[bondvectorlist[[n]], bondvector]
      		],
      	 {n, 2, hdlen}](* end Do *),
   {j, anum}](* end Do *);
   {unitcell[[1, i]], bondvectorlist},
{i, 1, len}](* end Table *);

(* coordination number list *)
cnlist = Length/@(bondconfiglist[[;;,2,2]]); 


(* Hamiltonian and overlap matrices *)
H = ConstantArray[0,{len,len}];
S = ConstantArray[0,{len,len}];

(* Hamiltonian and overlap matrix elements filling *)
Do[
	hij = 0;
	sij = 0;
	(* Summation over adjecent unitcells *)
	Do[
		r1 = unitcell[[1,i]];
		r2 = supercell[[1,c,j]];
		r12 = r1 - r2; (* bondvector for ideal geometry *)
		idealbondlength = Sqrt[r12.r12];
		
		(* Summation over nearest neighbours of various orders *)
		Do[
			
			If[
				(*========= This If section makes decision if the loop should be evaluated and how the hoppping and overlapping integrals must be set ==========================*)
				If[
					realnumbersQ[idealbondlength,hoppingdistances[[l]]],
					If[
						Abs[hoppingdistances[[l]] - idealbondlength] < hoppingdistancedelta,
						t = If[ListQ[hoppingintegrals[[l]]], hoppingintegrals[[l, 1]], hoppingintegrals[[l]]];
						s = If[ListQ[overlappingintegrals[[l]]], overlappingintegrals[[l, 1]], overlappingintegrals[[l]]];
			
						(* correct hopping integral due to the environmental (surrounding) effect *)
						(* hopping integrals format
						{
							{t0,{t01,testfun01},{t02,testfun02}, ...}, 
							{t1,{t11,testfun11},{t12,testfun12}, ...},
							{t2,{t21,testfun21},{t22,testfun22}, ...},
							...
						}
						overlapping integrals format 
						{
							{s0,s01,s02,...}
							{s1,s11,s12,...},
							{s2,s21,s22,...}
							...
						}
						test functions for fixed first index such as testfun01, ..., testfun0n must not contain intersecting conditions
						the test functions run on ideal structure vectors r1, r2
						*)
						If[
							ListQ[hoppingintegrals[[l]]],
							hlen = Length[hoppingintegrals[[l]]];
						
							If[
								hlen > 1,
						
								Do[
									etest = hoppingintegrals[[l, m, 2]];
									(*Print[bondconfiglist[[i]]];*)
									If[
										etest[r1[[1]], r1[[2]], r1[[3]], r2[[1]], r2[[2]], r2[[3]], bondconfiglist[[i]], bondconfiglist[[j]], i, j], 
										(*Print["Yes"];*)							
										t = hoppingintegrals[[l, m, 1]];
										s = overlappingintegrals[[l,m]]
									],
								{m, 2, hlen}]
							];
						] (* end If hopping integral as a list*);
						(* Evaluate the rest of the code in the loop? Yes*)
						True,
						(* Evaluate the rest of the code in the loop? No*)
						False
					],
					(* if idealbondlength and given hoppingdistance are not a real numbers 
					then they are treated symbolically, and an exact comparison is attempted *)
					If[
						hoppingdistances[[l]] === (idealbondlength/.Sqrt[x_^2] :> x) (* Sqrt[x_^2] :> x means that all symbols in the expression are stand for positive real numbers *),
						t = If[ListQ[hoppingintegrals[[l]]], hoppingintegrals[[l, 1]], hoppingintegrals[[l]]];
						s = If[ListQ[overlappingintegrals[[l]]], overlappingintegrals[[l, 1]], overlappingintegrals[[l]]];
			
						(* correct hopping integral due to the environmental (surrounding) effect *)
						(* hopping integrals format
						{
							{t0,{t01,testfun01},{t02,testfun02}, ...}, 
							{t1,{t11,testfun11},{t12,testfun12}, ...},
							{t2,{t21,testfun21},{t22,testfun22}, ...},
							...
						}
						overlapping integrals format 
						{
							{s0,s01,s02,...}
							{s1,s11,s12,...},
							{s2,s21,s22,...}
							...
						}
						test functions for fixed first index such as testfun01, ..., testfun0n must not contain intersecting conditions
						the test functions run on ideal structure vectors r1, r2
						*)
						If[
							ListQ[hoppingintegrals[[l]]],
							hlen = Length[hoppingintegrals[[l]]];
						
							If[
								hlen > 1,
						
								Do[
									etest = hoppingintegrals[[l, m, 2]];
									(*Print[bondconfiglist[[i]]];*)
									If[
										etest[r1[[1]], r1[[2]], r1[[3]], r2[[1]], r2[[2]], r2[[3]], bondconfiglist[[i]], bondconfiglist[[j]], i, j], 
										(*Print["Yes"];*)							
										t = hoppingintegrals[[l, m, 1]];
										s = overlappingintegrals[[l,m]]
									],
								{m, 2, hlen}]
							];
						] (* end If hopping integral as a list*);
						(* Evaluate the rest of the code in the loop? Yes*)
						True,
						(* not a real number or a valid symbolic expression *)
				
						(* check if the hopping distance is defined via a pure function with boolean output, this allows us to address a range of hopping distances in a similar fashion;
						for the range of hopping distances the hopping and overlapping integrals are set as pure functions too *)
						hdfun = hoppingdistances[[l]];
						hd = hdfun[r1[[1]], r1[[2]], r1[[3]], r2[[1]], r2[[2]], r2[[3]], bondconfiglist[[i]], bondconfiglist[[j]], i, j];
						If[
							(hd === True),
							(* hopping distance is a pure function with boolean output True *)
							hifun = hoppingintegrals[[l]];
							oifun = overlappingintegrals[[l]];
							t = hifun[r1[[1]], r1[[2]], r1[[3]], r2[[1]], r2[[2]], r2[[3]], bondconfiglist[[i]], bondconfiglist[[j]], i, j];
							s = oifun[r1[[1]], r1[[2]], r1[[3]], r2[[1]], r2[[2]], r2[[3]], bondconfiglist[[i]], bondconfiglist[[j]], i, j];
							(*Print["Yes"];*)
							(* Evaluate the rest of the code in the loop? Yes *)
							True,
							(* hopping distance is not a pure function with boolean output True (also not a real number or valid symbolic expression) *)
							(* Evaluate the rest of the code in the loop? No *)
							False
						](* if hd True *)
					](* If symbolic comparison successful *)
				](* If real numbers are given for hopping distances *)
					
				(*========= This code section make decision if the hoppping and overlapping integrals must be used and how they are set ==========================*)
				,
				
	
				r1 = unitcell[[2,i]];
				r2 = supercell[[2,c,j]];				
				r12 = r1 - r2; (* bondvector for optimized geometry *)
				optimizedbondlength = Sqrt[r12.r12];

				(* 
				The effect of strain is taken into account as in the paper: 
				Ribeiro,R.M.,Pereira,V.M.,Peres,N.M.R.,Briddon,P.R.,and Castro Neto,A.H. 
				"Strained graphene:tight-binding and density functional calculations", 
				New Journal of Physics,11(11),115002 (2009). 
				http://doi.org/10.1088/1367-2630/11/11/115002 
				*)
				relbonddeformation = If[l==1,0,(optimizedbondlength - idealbondlength)/idealbondlength];


				(* Generalization of the Landau gauge to the arbitrary direction of the B :
				 eq.(24) from J.-C.Charlier and S.Roche,Rev.Mod.Phys.79,677 (2007).*)
				mflux = (r2 + r1)[[1]]/2 bfield[[3]] (r2 - r1)[[2]] + ((r2 + r1)[[2]]/2  bfield[[1]] - (r2 + r1)[[1]]/2  bfield[[2]]) (r2 - r1)[[3]]; (* magnetic flux *)
				mphase = Pi mflux/mfluxquanta;(* magnetic phase *)
				
				sphase = k.r12;(* space phase *)

				(* hoppingintegrals edge corrections due to the coordination number *)
				dt = If[
						(cnlist[[i]] == 0)||(cnlist[[j]] == 0),
						0,
						edgecorrections[[cnlist[[i]],cnlist[[j]],l]]
				]; (* end If edge correction *)
				
				
				(* electrostatic on-site energy *)
				tE = If[
							l == 1,
							If[
								VectorQ[efield, NumericQ] && Length[efield] == 3,
								(* efield is a 3-component Cartesian vector setting the electrostatic field strength *)
								U[r1,efield],
								(* if efield is not a 3-component Cartesian vector (i.e. electrostatic field strength) 
								   then it is assumed to be a pure function defining in eV an electrostatic potential 
								   in space as function of x, y and z. 
								*)
								efield[r1[[1]], r1[[2]], r1[[3]]]
							],
				 0];
				
								
				hij = hij + Exp[- strain relbonddeformation] (t + dt + tE) Exp[I (sphase - mphase)];
				sij = sij + Exp[- strain relbonddeformation] s Exp[I (sphase - mphase)];
	
				Break[];
			](* end If *),
		{l, 1, Length[hoppingintegrals]}](* end Do *),
		{c, 1, unum}](* end Do *);
	H[[i,j]] = hij;
	S[[i,j]] = sij,
{i, 1, len},
{j, 1, len}
](* end Do *);
{H, S}
](* end Module *)
](* end Catch *);
SyntaxInformation[Hamiltonian] = {"ArgumentsPattern" -> {_, OptionsPattern[]}};

(* Electronic energy levels *)
(* In addition to the explicitely specified new options with their default values, 
ElectronicStructure function takes the default options of Hamiltonian function, 
but Kpoint option value of Hamiltonian is replaced with the new value suitable 
for ElectronicStructure function.
*)
(* ParallelTable does not work properly! The package context must be added to DistributedContexts option of ParallelTable!  *)
ElectronicStructure[unitcell_List, OptionsPattern[{ParallelEvaluation->True,EigenVectors->False,Kpoint->{{0,0,0}},Hamiltonian}]]:=Catch[
Module[
{
	translationvectors = OptionValue[TranslationVectors],
	hoppingintegrals = OptionValue[HoppingIntegrals],
	overlappingintegrals = OptionValue[OverlappingIntegrals],
	hoppingdistances = OptionValue[HoppingDistances],
	strain = OptionValue[StrainExponent],
	klist = OptionValue[Kpoint],
	efield = OptionValue[Efield],
	bfield = OptionValue[Bfield],
	edgecorrections = OptionValue[EdgeCorrections],
	hoppingdistancedelta = OptionValue[HoppingDistanceDelta],
	supercellsize = OptionValue[SuperCellSize],
	
	bands,m,k,
	data,
	vm,kx,ky,kz,v,
	epsol,eval,evec,
	
	ordering
},

(* hoppingintegrals_?(VectorQ[#,NumericQ]&) 
overlappingintegrals_?(VectorQ[#,NumericQ]&)
\[Beta]_?NumericQ
*)

(*
ElectronicBands::klist="The argument must be a list of vectors three element long each.";

tf=VectorQ[#,(ListQ[#]&&Length[#]==3&)]&;

If[!tf@klist,Throw[Message[ElectronicBands::klist,unitcell]]];
*)

(* First argument structure: unitcell={idealunitcell,optimizedunitcell};
   TranslationVectors option value structure: translationvectors={idealtranslationvectors,optimizedtranslationvectors} *)
	
(*--------------------------- Body of the fucntion ---------------------------------*)
m = Hamiltonian[unitcell,
							TranslationVectors->translationvectors,
							HoppingIntegrals->hoppingintegrals,
							OverlappingIntegrals->overlappingintegrals,
							HoppingDistances->hoppingdistances,
							StrainExponent->strain,
							Kpoint->k,
							Efield->efield,
							Bfield->bfield,
							EdgeCorrections->edgecorrections,
							HoppingDistanceDelta->hoppingdistancedelta,
							SuperCellSize->supercellsize
];
	
If[
	OptionValue[EigenVectors],
	(*velocity operator in the gradient (effective mass) approximation*)
	vm = D[m[[1]]/.k->{kx,ky,kz},{{kx,ky,kz}}];
	data = If[
				OptionValue[ParallelEvaluation],
				ParallelTable[
					epsol = Chop[Eigensystem[m/.k->i]];
					ordering = Ordering[First[epsol]];
					{eval,evec} = #[[ordering]]&/@epsol;
					v = vm/.{kx->i[[1]],ky->i[[2]],kz->i[[3]]};	
					{Append[eval,i],evec,v},
				{i,klist},DistributedContexts->"TBpack`Private`"](* end ParallelTable *)
				,
				Table[
					epsol = Chop[Eigensystem[m/.k->i]];
					ordering = Ordering[First[epsol]];
					{eval,evec} = #[[ordering]]&/@epsol;		
					v = vm/.{kx->i[[1]],ky->i[[2]],kz->i[[3]]};
					{Append[eval,i],evec,v},
				{i,klist}](* end Table *)
	](* end If ParallelEvaluation *);
	data = Transpose[data];
	Join[{Transpose[First@data]},Rest@data]
	,
	bands = If[
				OptionValue[ParallelEvaluation],
				ParallelTable[Join[Sort@Chop@Eigenvalues[m/.k-> i],{i}],
				{i,klist},DistributedContexts->"TBpack`Private`"](* end ParallelTable *)
				,
				Table[Join[Sort@Chop[Eigenvalues[m/.k-> i]],{i}],{i,klist}](* end Table *)
	];(* end If ParallelEvaluation*)
	Transpose[bands]
](* end If EigenVectors *)
](* end Module *)
](* end Catch *);
SyntaxInformation[ElectronicStructure] = {"ArgumentsPattern" -> {_, OptionsPattern[]}};


(* 1D structures electronic energy bands *)
(* Error messages *)
ElectronicBands1D::nkp = "NumberOfKpoint must be a positive integer.";

(* Options *)
Options[ElectronicBands1D] = {
	TBModelParameters->{{0,3.12,0,0},{1,0,0,0},3,{{{0,0,0,0},{0,0,0,0},{0,0,0,0}},{{0,0,0,0},{0,0,0,0},{0,0,0,0}},{{0,0,0,0},{0,0,0,0},{0,0,0,0}}},"Partoens2006"},
	HoppingDistances->{0, 1.42, 2.45951, 2.84},
	HoppingDistanceDelta->0.05,
	SuperCellSize->1,
	Efield->{0,0,0},
	Bfield->{0,0,0},
	NumberOfKpoints->50,
	Krange->Automatic,
	EigenVectors->False,
	ParallelEvaluation->True,
	RelaxGeometry->False,
	(*OptimizationProgram->{1,Automatic,Automatic,{}},*)
	OptimizationFunction->{Automatic,{}},
	Path2Save->$HomeDirectory
};
ElectronicBands1D[unitcell_List, translationvector_List, OptionsPattern[]] := Catch[Module[
{
  	(* model parameters *)
  	hoppingintegrals = OptionValue[TBModelParameters][[1]],
  	overlappingintegrals = OptionValue[TBModelParameters][[2]],
  	strain = OptionValue[TBModelParameters][[3]],
  	edgecorrections = OptionValue[TBModelParameters][[4]],
   	modelname = OptionValue[TBModelParameters][[5]],
   	
   	hoppingdistances = OptionValue[HoppingDistances],
   	hoppingdistancedelta = OptionValue[HoppingDistanceDelta],
   	supercellsize = OptionValue[SuperCellSize],
   	efield = OptionValue[Efield],
   	bfield = OptionValue[Bfield],
   	
   	numberofkpoints = OptionValue[NumberOfKpoints],
   	krange = OptionValue[Krange],
   	(*optimizationprogram = OptionValue[OptimizationProgram],*)
   	optimizationfunction = OptionValue[OptimizationFunction],
   	path2save = OptionValue[Path2Save],
   	opflag = OptionValue[RelaxGeometry],
    
    hlen, ecdim,
    
    opprefix, programname,
   	
   	opfun, opdata, 
   	opUnitCell, opT,
   	UnitCell, T,
   	
   	k1, k2, dk, klist,
   
   	data,
   	bands,
   	
   	stream, text,
   	nd, 
   	(* matrix formating *)
   	wfformat, vmformat
},

(* Checking arguments and options *)
If[
  	Not[IntegerQ[numberofkpoints]] || numberofkpoints < 1,
	Message[ElectronicBands1D::nkp];
	Throw[$Failed]
];

nd = Function[{x},
		If[
		NumericQ[x],
		ToString@PaddedForm[1.0 Chop[x,10^-15],{7+2,7},ExponentFunction->(If[-16<#<16,Null,#]&)],
		"Null"
		]
]; (* number display function *)

hlen = Length[hoppingintegrals];
ecdim = Dimensions[edgecorrections];

(*------------------------------------- Data file header ----------------------------------*)
(* open stream for the log file *)
stream = OpenWrite[FileNameJoin[{path2save,"ElectronicBands1D_"<>DateString[{"Year","Month","Day","_at_","Hour","_","Minute","_","Second"}]<>".txt"}],FormatType-> OutputForm,CharacterEncoding->"ASCII",PageWidth->Infinity];
Write[stream,"# Created by TBpack \n# Wolfram Mathematica "<>$Version];
Write[stream,"# ElectronicBands1D started on "<>DateString[]];

text=Flatten@{
"\n# Model name: "<>modelname,	
"\n# Hopping integrals, eV",
Table["t"<>ToString[i-1]<>" = "<>nd[hoppingintegrals[[i]]],{i,hlen}],
"\n# Overlapping integrals",
Table["s"<>ToString[i-1]<>" = "<>nd[overlappingintegrals[[i]]],{i,hlen}],
"\n# Strain exponent","beta = "<>nd[strain],
"\n# Edge corrections, eV",
Table["dt"<>ToString[k-1]<>"_"<>ToString[i]<>"_"<>ToString[j]<>" = "<>nd[edgecorrections[[i,j,k]]]<>If[k == ecdim[[3]],"\n",""],{i,ecdim[[1]]},{j,ecdim[[2]]},{k,ecdim[[3]]}],"\n"};
Scan[Write[stream,#]&,text];
   

  (*------------------------------ UNIT CELL GEOMETRY OPTIMIZATION ----------------------------------*)
  (* unitcell optimization flag: 
  opflag = True or False;
  True - perform unit cell geometry optimization; 
  False - skip optimization *) 
  If[
   		opflag,
   		opprefix = "Optimized";
   		opfun = optimizationfunction[[1]];
   		
   		opfun = If[opfun === Automatic, OptimizationByLAMMPS, opfun];
   		programname = ToString[opfun];
   		opdata = opfun[unitcell, translationvector, Sequence@@(optimizationfunction[[2]])];
   		UnitCell = opdata[[1, 1]];
   		T = opdata[[1, 2]];
   		opUnitCell = opdata[[2, 1]];
   		opT = opdata[[2, 2]];
   		,
   		programname = "";
   		opprefix = "Ideal";
   		UnitCell = unitcell;
   		T = translationvector;
   		opUnitCell = unitcell;
   		opT = translationvector;
   ](* end If *);
  
  (*--------------------------------------------------------------------------------*)
  
(*------------------------------------- Data file header ---------------------------*)
(* system under consideration *)
Write[stream,"\n# "<>opprefix<>" system under consideration: "<>programname];
(* unit cell *)
Scan[Write[stream,#]&,Flatten@{"unit cell atoms (x, y, z), Angstrom",Row[nd/@#,"\t"]&/@(opUnitCell)}];
(* translation vector *)
Scan[Write[stream,#]&,{"\n# Translation vector (x, y, z), Angstrom",Row[nd/@(opT),"\t"]}];
(* hopping distances *)
text=Flatten@{"\n# Hopping distances, Angstrom",Table[Row[{ToString[i-1]<>" order :",nd[hoppingdistances[[i]]]},"\t"],{i,hlen}]};
Scan[Write[stream,#]&,text];
Write[stream,"\n# Hopping distance delta, Angstrom\ndelta = "<>nd[hoppingdistancedelta]];
Scan[Write[stream,#]&,{"\n# Electric field (Ex, Ey, Ez), V/Angstrom",Row[Table[nd[efield[[i]]],{i,Length[efield]}],"\t"]}];
Scan[Write[stream,#]&,{"\n# Magnetic field (Bx, By, Bz), T",Row[Table[nd[bfield[[i]]],{i,Length[bfield]}],"\t"]}];
  
  
    
  (*-------------------------- BRILLOUIN ZONE SAMPLING ----------------------------*)
  (* kinterval is either Automatic or {kmin, kmax} *)
  If[
  		krange === Automatic,
  		k1 = 0;
  		k2 = Pi/Sqrt[T.T] (* The half of the Brillouin zone *)
  		,
  		k1 = krange[[1]];
  		k2 = krange[[2]]
  ];
  
  If[
  		numberofkpoints == 1,
  		klist = {k1 T/Sqrt[T.T]},
  		dk = (k2 - k1)/(numberofkpoints - 1); (* step *)
  		klist = Table[T/Sqrt[T.T] i, {i, k1, k2, dk}]; (* klist *)
  ];
  (*--------------------------------------------------------------------------------*)

    	 
  (*----------------------------  CALCULATION -------------------------------------*)
  data = ElectronicStructure[{UnitCell,opUnitCell}, 
  		TranslationVectors -> {{T}, {opT}}, 
  		HoppingIntegrals -> hoppingintegrals, 
    	OverlappingIntegrals -> overlappingintegrals,
    	HoppingDistances -> hoppingdistances,
    	StrainExponent -> strain,
    	Kpoint -> klist,
    	Efield -> efield,
    	Bfield -> bfield, 
    	EdgeCorrections -> edgecorrections,
    	HoppingDistanceDelta -> hoppingdistancedelta,
    	SuperCellSize -> supercellsize,
    	EigenVectors -> OptionValue[EigenVectors],
    	ParallelEvaluation -> OptionValue[ParallelEvaluation]
    	];
  (*--------------------------------------------------------------------------------*)
  
  If[
   		OptionValue[EigenVectors],
   		(*------------------------ DATA TRANSFORMATION -----------------------------------*)
   		(* reduction to the 1D form data representation *)
   		bands = Append[Most@First@data, (Sqrt[Total[#^2]]) & /@ Last[First@data]];
   		
   		(*------------------------------------- Data file body ---------------------------*)
   		Write[stream,"\n# Electronic band structure:"];
		Scan[Write[stream,#]&,Flatten@{"E, eV \t (last element of each column) k, Angstrom^-1",Row[nd/@#,"\t"]&/@bands}];
		Write[stream,"\n# Eigenvectors:"];
		(*format wave function data and write them into the text file*)
		wfformat = Function[{x}, Append[Row[nd/@#, "\t"]&/@x,"\n"]];
   		Scan[Write[stream,#]&,
   			Flatten@Map[wfformat,data[[2]]]
   		](* end Scan *);
   		Write[stream,"\n# Velocity operator matrices:"];
   		(*format velocity matrix elements data and write them into the text file*)
   		vmformat = Function[{x}, Append[Map[Row[nd/@#, "\t"]&,Flatten[x, {{3}, {1}, {2}}],{2}],"\n"]];
   		Scan[Write[stream,#]&,
   			Flatten@Map[vmformat,data[[3]]]
   		](* end Scan *);
   		Write[stream,"\n# Finished on "<>DateString[]];
		Close[stream];
   		(*------------------------------------- Data file end ----------------------------*)
   		
   		
   		(*-------------------------------- RESULTS ---------------------------------------*)
   		Join[
    		{bands},
    		Rest@data,
    		{{hoppingintegrals,
    		overlappingintegrals,
    		strain,
    		edgecorrections,
    		modelname}}
    	]
   		,
   		(*------------------------  DATA TRANSFORMATION -----------------------------------*)
   		(* reduction to the 1D form data representation *)
   		bands = Append[Most@data, (Sqrt[Total[#^2]]) & /@ Last[data]];
   		
   		(*------------------------------------- Data file body ---------------------------*)
   		Write[stream,"\n# Electronic band structure:"];
		Scan[Write[stream,#]&,Flatten@{"E, eV \t (last element of each column) k, Angstrom^-1",Row[nd/@#,"\t"]&/@bands}];
		Write[stream,"\n# Finished on "<>DateString[]];
		Close[stream];
		(*------------------------------------- Data file end ----------------------------*)
   		
   		(*--------------------------------  RESULTS ---------------------------------------*)
   
   		Join[
    		{bands},
    		{{hoppingintegrals,
    		overlappingintegrals,
    		strain,
    		edgecorrections,
    		modelname}}
    		]
   ](* end If EigenVectors *)
](* end Module *)
](* end Catch *);
SyntaxInformation[ElectronicBands1D] = {"ArgumentsPattern" -> {_, _, OptionsPattern[]}};



End[]

(Attributes[#] = {Protected, ReadProtected}) & /@ Names[Evaluate[$Context<>"*"]]

EndPackage[]
