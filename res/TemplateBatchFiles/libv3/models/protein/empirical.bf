LoadFunctionLibrary("../protein.bf");
LoadFunctionLibrary("../parameters.bf");
LoadFunctionLibrary("../frequencies.bf");
LoadFunctionLibrary("../../UtilityFunctions.bf");
LoadFunctionLibrary("../terms.bf");

/** @module models.protein.empirical */

/**
 * @name models.protein.empirical.ModelDescription
 * @param {String} type
 * @returns {Dictionary} model description
 * @description Create the baseline schema (dictionary) for empirical protein model definitions
 */
function models.protein.empirical.ModelDescription(type) {
    return {
        "alphabet": models.protein.alphabet,
        "description": "General class of empirical substitution matrices for amino-acids",
        "canonical": 1, // is of the r_ij \times \pi_j form
        "reversible": 1,
        terms.efv_estimate_name: terms.freqs.predefined,
        "parameters": {
            "global": {},
            "local": {},
            "empirical": 0
        },
        "type": type,
        "get-branch-length": "",
        "set-branch-length": "models.generic.SetBranchLength",
        "constrain-branch-length": "models.generic.constrain_branch_length",
        "frequency-estimator": "frequencies.empirical.protein",
        "q_ij": "",
        "time": "models.protein.generic.Time",
        "defineQ": "models.protein.empirical._DefineQ",
        "post-definition": "models.generic.post.definition"
    };
}


/**
 * @name models.protein.WAG._GenerateRate
 * @private
 * @description Generate rate matrix for the WAG model of protein evolution (http://mbe.oxfordjournals.org/content/18/5/691)
 * @param {String} from - source amino acid
 * @param {String} to   - target amino acid
 * @param {String} namespace
 * @param {String} modelType
 */
function models.protein.WAG._GenerateRate (from,to,namespace,modelType) {
    return models.protein.empirical._GenerateRate (models.protein.WAG.empirical_Q, from,to,namespace,modelType);
}

/**
 * @name models.protein.WAG.ModelDescription
 * @description Create the baseline schema (dictionary) for the WAG model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
function models.protein.WAG.ModelDescription(type) {
    models.protein.WAG.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.WAG.ModelDescription.model_definition ["empirical-rates"] = models.protein.WAG.empirical_Q;
    models.protein.WAG.ModelDescription.model_definition ["frequency-estimator"] = "models.protein.WAG.frequencies";
    models.protein.WAG.ModelDescription.model_definition ["q_ij"] = "models.protein.WAG._GenerateRate";
    return models.protein.WAG.ModelDescription.model_definition;
}

/**
 * @name models.protein.WAGF.ModelDescription
 * @description Create the baseline schema (dictionary) for the WAG+F model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
/*
function models.protein.WAGF.ModelDescription(type) {
    models.protein.WAGF.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.WAGF.ModelDescription.model_definition ["empirical-rates"] = models.protein.WAG.empirical_Q;
    models.protein.WAGF.ModelDescription.model_definition ["frequency-estimator"] = "frequencies.empirical.protein";
    models.protein.WAGF.ModelDescription.model_definition ["parameters"] = {"global": {}, "local": {}, "empirical": 19};
    models.protein.WAGF.ModelDescription.model_definition ["q_ij"] = "models.protein.WAG._GenerateRate";
    return models.protein.WAGF.ModelDescription.model_definition;
}*/

/**
 * @name models.protein.WAG.frequencies
 * @param {Dictionary} Baseline WAG model
 * @returns {Dictionary} Updated WAG model with empirical frequencies
 * @description Define the empirical amino acid frequencies associated with the WAG model of protein evolution
 */
function models.protein.WAG.frequencies (model, namespace, datafilter) {
    model[terms.efv_estimate] =
        {{     0.0866279}
        {     0.0193078}
        {     0.0570451}
        {     0.0580589}
        {     0.0384319}
        {     0.0832518}
        {     0.0244313}
        {      0.048466}
        {     0.0620286}
        {      0.086209}
        {     0.0195027}
        {     0.0390894}
        {     0.0457631}
        {     0.0367281}
        {      0.043972}
        {     0.0695179}
        {     0.0610127}
        {     0.0708956}
        {     0.0143859}
        {     0.0352742}
        };

    model[terms.efv_estimate_name] = terms.freqs.predefined;
    (model["parameters"])["empirical"] = 0;
    return model;
}


/* Define a dictionary of amino-acid exchangeability rates for the WAG model of protein evolution. Note that this dictionary has been **normalized** using the WAG default frequencies. */ 
models.protein.WAG.empirical_Q = {
 "A":{
   "C":0.02081175,
   "D":0.04424356,
   "E":0.09644885,
   "F":0.008490242,
   "G":0.1237844,
   "H":0.008127018999999999,
   "I":0.009834135000000001,
   "K":0.05899778,
   "L":0.03600239,
   "M":0.0182884,
   "N":0.02091646,
   "P":0.06909218,
   "Q":0.03502343,
   "R":0.02545459,
   "S":0.245933,
   "T":0.1358225,
   "V":0.1492591,
   "W":0.001708106,
   "Y":0.008912199000000001
  },
 "C":{
   "D":0.001813745,
   "E":0.001301055,
   "F":0.01605407,
   "G":0.02679532,
   "H":0.006383892,
   "I":0.008654049,
   "K":0.004819601,
   "L":0.03476936,
   "M":0.007992529,
   "N":0.0108821,
   "P":0.005254569,
   "Q":0.003809101,
   "R":0.02437562,
   "S":0.1027029,
   "T":0.03284827,
   "V":0.0745652,
   "W":0.01082647,
   "Y":0.02013312
  },
 "D":{
   "E":0.3762142,
   "F":0.001884863,
   "G":0.07562952000000001,
   "H":0.02386347,
   "I":0.002005993,
   "K":0.03123852,
   "L":0.007672926,
   "M":0.002123675,
   "N":0.2227414,
   "P":0.02036354,
   "Q":0.02377493,
   "R":0.00679797,
   "S":0.07819566,
   "T":0.02400406,
   "V":0.01133463,
   "W":0.001959249,
   "Y":0.01205807
  },
 "E":{
   "F":0.003272523,
   "G":0.04960369,
   "H":0.01461601,
   "I":0.006480045,
   "K":0.1682461,
   "L":0.01395734,
   "M":0.006450074,
   "N":0.0388587,
   "P":0.03277285,
   "Q":0.2108299,
   "R":0.02026676,
   "S":0.05143238,
   "T":0.0526847,
   "V":0.0438051,
   "W":0.00236373,
   "Y":0.007267292
  },
 "F":{
   "G":0.00436267,
   "H":0.01741975,
   "I":0.05389076,
   "K":0.005783216,
   "L":0.1913755,
   "M":0.02437025,
   "N":0.00394504,
   "P":0.007754001,
   "Q":0.003851615,
   "R":0.004740036,
   "S":0.03983115,
   "T":0.01100758,
   "V":0.04835584,
   "W":0.02309483,
   "Y":0.2389425
  },
 "G":{
   "H":0.006395123,
   "I":0.001548868,
   "K":0.02431859,
   "L":0.005546612,
   "M":0.003563543,
   "N":0.04617598,
   "P":0.01169843,
   "Q":0.0127224,
   "R":0.02698185,
   "S":0.09789926,
   "T":0.01446092,
   "V":0.01393229,
   "W":0.005087841,
   "Y":0.003835501
  },
 "H":{
   "I":0.007029141,
   "K":0.05796705,
   "L":0.04519012,
   "M":0.008272107000000001,
   "N":0.1623063,
   "P":0.03343772,
   "Q":0.1655236,
   "R":0.09862788,
   "S":0.05400277,
   "T":0.0303076,
   "V":0.008806540999999999,
   "W":0.003964322,
   "Y":0.1433978
  },
 "I":{
   "K":0.02108143,
   "L":0.2869017,
   "M":0.08714326,
   "N":0.02273747,
   "P":0.004799484,
   "Q":0.004391122,
   "R":0.008628942000000001,
   "S":0.02330635,
   "T":0.09337141,
   "V":0.5819514,
   "W":0.003208113,
   "Y":0.01555502
  },
 "K":{
   "L":0.02330296,
   "M":0.0191231,
   "N":0.1235674,
   "P":0.02674718,
   "Q":0.1501354,
   "R":0.246964,
   "S":0.07056185,
   "T":0.08881348999999999,
   "V":0.02272611,
   "W":0.002076079,
   "Y":0.004933538
  },
 "L":{
   "M":0.09935387,
   "N":0.005395922,
   "P":0.01997258,
   "Q":0.03351591,
   "R":0.02296714,
   "S":0.02515217,
   "T":0.02091482,
   "V":0.133956,
   "W":0.01004497,
   "Y":0.01475715
  },
 "M":{
   "N":0.008131996000000001,
   "P":0.008228767999999999,
   "Q":0.05956464,
   "R":0.03152741,
   "S":0.03603533,
   "T":0.0970828,
   "V":0.1531609,
   "W":0.007786238,
   "Y":0.01586107
  },
 "N":{
   "P":0.009369552999999999,
   "Q":0.05950219,
   "R":0.02932074,
   "S":0.28996,
   "T":0.1299922,
   "V":0.01460187,
   "W":0.001085813,
   "Y":0.04020457
  },
 "P":{
   "Q":0.03597839,
   "R":0.03135791,
   "S":0.1177049,
   "T":0.05093139,
   "V":0.02342947,
   "W":0.002104766,
   "Y":0.007998193000000001
  },
 "Q":{
   "R":0.140086,
   "S":0.07506641,
   "T":0.05493632,
   "V":0.0224171,
   "W":0.003257243,
   "Y":0.008430004
  },
 "R":{
   "S":0.08931696,
   "T":0.03550112,
   "V":0.01873906,
   "W":0.01757311,
   "Y":0.01412465
  },
 "S":{
   "T":0.2803409,
   "V":0.01731717,
   "W":0.007907568,
   "Y":0.0291351
  },
 "T":{
   "V":0.1032926,
   "W":0.001673848,
   "Y":0.01077852
  },
 "V":{
   "W":0.005516418,
   "Y":0.01165155
  },
 "W":{
   "Y":0.0920111
  }
};




/**
 * @name models.protein.LG._GenerateRate
 * @private
 * @description Generate rate matrix for the LG model of protein evolution (doi: 10.1093/molbev/msn067)
 * @param {String} from - source amino acid
 * @param {String} to   - target amino acid
 * @param {String} namespace
 * @param {String} modelType
 */
function models.protein.LG._GenerateRate (from,to,namespace,modelType) {
    return models.protein.empirical._GenerateRate (models.protein.LG.empirical_Q, from,to,namespace,modelType);
}

/**
 * @name models.protein.LG.ModelDescription
 * @description Create the baseline schema (dictionary) for the LG model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
 function models.protein.LG.ModelDescription(type) {
    models.protein.LG.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.LG.ModelDescription.model_definition ["empirical-rates"] = models.protein.LG.empirical_Q;
    models.protein.LG.ModelDescription.model_definition ["frequency-estimator"] = "models.protein.LG.frequencies";
    models.protein.LG.ModelDescription.model_definition ["q_ij"] = "models.protein.LG._GenerateRate";
    return models.protein.LG.ModelDescription.model_definition;
}

/**
 * @name models.protein.LGF.ModelDescription
 * @description Create the baseline schema (dictionary) for the LG+F model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
 /*
function models.protein.LGF.ModelDescription(type) {
    models.protein.LGF.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.LGF.ModelDescription.model_definition ["empirical-rates"] = models.protein.LG.empirical_Q;
    models.protein.LGF.ModelDescription.model_definition ["frequency-estimator"] = "frequencies.empirical.protein";
    models.protein.LGF.ModelDescription.model_definition ["parameters"] = {"global": {}, "local": {}, "empirical": 19};
    models.protein.LGF.ModelDescription.model_definition ["q_ij"] = "models.protein.LG._GenerateRate";
    return models.protein.LGF.ModelDescription.model_definition;
}
*/


/**
 * @name models.protein.LG.frequencies
 * @param {Dictionary} Baseline LG model
 * @returns {Dictionary} Updated LG model with empirical frequencies
 * @description Define the empirical amino acid frequencies associated with the LG model of protein evolution
 */
function models.protein.LG.frequencies (model, namespace, datafilter) {
    model[terms.efv_estimate] =
 
          {{     0.07906500000000008}
           {     0.012937}
           {     0.053052}
           {     0.071586}
           {     0.042302}
           {     0.057337}
           {     0.022355}
           {     0.062157}
           {     0.0646}
           {     0.099081}
           {     0.022951}
           {     0.041977}
           {     0.04404}
           {     0.040767}
           {     0.055941}
           {     0.061197}
           {     0.053287}
           {     0.069147}
           {     0.012066}
           {     0.034155}
          };
    model[terms.efv_estimate_name] = terms.freqs.predefined;
    (model["parameters"])["empirical"] = 0;
    return model;
}

/* Define a dictionary of amino-acid exchangeability rates for the LG model of protein evolution. Note that this dictionary has been **normalized** using the LG default frequencies. */ 
models.protein.LG.empirical_Q = {
 "A":{
   "C":0.03522956,
   "D":0.0229346,
   "E":0.08133689,
   "F":0.01174132,
   "G":0.1296008,
   "H":0.008776704999999999,
   "I":0.01018879,
   "K":0.03791848,
   "L":0.04285406,
   "M":0.02822381,
   "N":0.01271276,
   "P":0.05674114,
   "Q":0.04325807,
   "R":0.02601647,
   "S":0.3164948,
   "T":0.1247291,
   "V":0.1927457,
   "W":0.002385593,
   "Y":0.008181845
  },
 "C":{
   "D":0.003630821,
   "E":0.0002740351,
   "F":0.05115122,
   "G":0.03570948,
   "H":0.01566596,
   "I":0.0218034,
   "K":0.0009375764,
   "L":0.06438966,
   "M":0.02243974,
   "N":0.02428347,
   "P":0.003632027,
   "Q":0.003782507,
   "R":0.0327155,
   "S":0.1864267,
   "T":0.06666287,
   "V":0.1482198,
   "W":0.00884617,
   "Y":0.04355245
  },
 "D":{
   "E":0.41069,
   "F":0.0008060157,
   "G":0.05300146,
   "H":0.02267472,
   "I":0.0007269456,
   "K":0.01999816,
   "L":0.00163422,
   "M":0.0006414941,
   "N":0.2331202,
   "P":0.01900553,
   "Q":0.02334345,
   "R":0.007586211,
   "S":0.08303903999999999,
   "T":0.02482688,
   "V":0.002872194,
   "W":0.0003945694,
   "Y":0.005048546
  },
 "E":{
   "F":0.0008705765,
   "G":0.02188286,
   "H":0.01036699,
   "I":0.003010126,
   "K":0.1277224,
   "L":0.007552471,
   "M":0.004362376,
   "N":0.02487791,
   "P":0.02020781,
   "Q":0.1841385,
   "R":0.02227563,
   "S":0.04097288,
   "T":0.03524391,
   "V":0.01853676,
   "W":0.001027702,
   "Y":0.004485425
  },
 "F":{
   "G":0.00561965,
   "H":0.01668329,
   "I":0.0756681,
   "K":0.001690408,
   "L":0.2810447,
   "M":0.04516806,
   "N":0.004111401,
   "P":0.004551429,
   "Q":0.001599162,
   "R":0.003226682,
   "S":0.02422454,
   "T":0.009619268,
   "V":0.04952661,
   "W":0.03243575,
   "Y":0.2916085
  },
 "G":{
   "H":0.007618063,
   "I":0.0005919608,
   "K":0.02096479,
   "L":0.00479784,
   "M":0.003503711,
   "N":0.06602329999999999,
   "P":0.009489902,
   "Q":0.01195119,
   "R":0.02388046,
   "S":0.116496,
   "T":0.00756921,
   "V":0.005802412,
   "W":0.003544273,
   "Y":0.002043191
  },
 "H":{
   "I":0.007404237,
   "K":0.04927923,
   "L":0.03970833,
   "M":0.01111019,
   "N":0.207085,
   "P":0.02451727,
   "Q":0.2146863,
   "R":0.1485124,
   "S":0.06628340000000001,
   "T":0.03406144,
   "V":0.009003304,
   "W":0.007881539999999999,
   "Y":0.1983005
  },
 "I":{
   "K":0.01124222,
   "L":0.4493203,
   "M":0.1073075,
   "N":0.008794702,
   "P":0.003771706,
   "Q":0.003249348,
   "R":0.007772081,
   "S":0.004291965,
   "T":0.06026516,
   "V":0.04910478,
   "W":0.001473992,
   "Y":0.008688692
  },
 "K":{
   "L":0.01490483,
   "M":0.01648691,
   "N":0.09851189,
   "P":0.01880635,
   "Q":0.1442522,
   "R":0.3871668,
   "S":0.05012591,
   "T":0.06627711,
   "V":0.01401048,
   "W":0.0006587949,
   "Y":0.004929905
  },
 "L":{
   "M":0.1584993,
   "N":0.003142484,
   "P":0.01200011,
   "Q":0.02597806,
   "R":0.01847365,
   "S":0.0122045,
   "T":0.01766063,
   "V":0.1288122,
   "W":0.008179586000000001,
   "Y":0.01119695
  },
 "M":{
   "N":0.01703821,
   "P":0.004810887,
   "Q":0.07459796,
   "R":0.02962982,
   "S":0.0232297,
   "T":0.1177837,
   "V":0.1436375,
   "W":0.009190009000000001,
   "Y":0.01798497
  },
 "N":{
   "P":0.007795161,
   "Q":0.07563193999999999,
   "R":0.04601631,
   "S":0.268368,
   "T":0.116636,
   "V":0.006330976,
   "W":0.0005989957,
   "Y":0.02286955
  },
 "P":{
   "Q":0.02784403,
   "R":0.02035162,
   "S":0.08959077,
   "T":0.03331558,
   "V":0.02243022,
   "W":0.001255797,
   "Y":0.00334857
  },
 "Q":{
   "R":0.1718491,
   "S":0.08193787,
   "T":0.06297003,
   "V":0.01591156,
   "W":0.003117996,
   "Y":0.009615879000000001
  },
 "R":{
   "S":0.05745502,
   "T":0.03375392,
   "V":0.01292756,
   "W":0.007836037000000001,
   "Y":0.01174968
  },
 "S":{
   "T":0.3773224,
   "V":0.00744159,
   "W":0.003285156,
   "Y":0.01496724
  },
 "T":{
   "V":0.1655336,
   "W":0.00185899,
   "Y":0.009186346
  },
 "V":{
   "W":0.002501667,
   "Y":0.009316084000000001
  },
 "W":{
   "Y":0.1177739
  }
};
//==================================================================================================================//



/**
 * @name models.protein.JTT._GenerateRate
 * @private
 * @description Generate rate matrix for the JTT model of protein evolution (doi: 10.1093/bioinformatics/8.3.275)
 * @param {String} from - source amino acid
 * @param {String} to   - target amino acid
 * @param {String} namespace
 * @param {String} modelType
 */
function models.protein.JTT._GenerateRate (from,to,namespace,modelType) {
    return models.protein.empirical._GenerateRate (models.protein.JTT.empirical_Q, from,to,namespace,modelType);
}

/**
 * @name models.protein.JTT.ModelDescription
 * @description Create the baseline schema (dictionary) for the JTT model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
 function models.protein.JTT.ModelDescription(type) {
    models.protein.JTT.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.JTT.ModelDescription.model_definition ["empirical-rates"] = models.protein.JTT.empirical_Q;
    models.protein.JTT.ModelDescription.model_definition ["frequency-estimator"] = "models.protein.JTT.frequencies";
    models.protein.JTT.ModelDescription.model_definition ["q_ij"] = "models.protein.JTT._GenerateRate";
    return models.protein.JTT.ModelDescription.model_definition;
}

/**
 * @name models.protein.JTTF.ModelDescription
 * @description Create the baseline schema (dictionary) for the JTT+F model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
 /*
function models.protein.JTTF.ModelDescription(type) {
    models.protein.JTTF.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.JTTF.ModelDescription.model_definition ["empirical-rates"] = models.protein.JTT.empirical_Q;
    models.protein.JTTF.ModelDescription.model_definition ["frequency-estimator"] = "frequencies.empirical.protein";
    models.protein.JTTF.ModelDescription.model_definition ["parameters"] = {"global": {}, "local": {}, "empirical": 19};
    models.protein.JTTF.ModelDescription.model_definition ["q_ij"] = "models.protein.JTT._GenerateRate";
    return models.protein.JTTF.ModelDescription.model_definition;
}*/


/**
 * @name models.protein.JTT.frequencies
 * @param {Dictionary} Baseline JTT model
 * @returns {Dictionary} Updated JTT model with empirical frequencies
 * @description Define the empirical amino acid frequencies associated with the JTT model of protein evolution
 */
function models.protein.JTT.frequencies (model, namespace, datafilter) {
    model[terms.efv_estimate] =
      {{	0.07686099999999986}
        {	0.020279}
        {	0.051269}
        {	0.06182}
        {	0.04053}
        {	0.074714}
        {	0.022983}
        {	0.052569}
        {	0.059498}
        {	0.091111}
        {	0.023414}
        {	0.042546}
        {	0.050532}
        {	0.041061}
        {	0.051057}
        {	0.068225}
        {	0.058518}
        {	0.066374}
        {	0.014336}
        {   0.032303}
    };
    model[terms.efv_estimate_name] = terms.freqs.predefined;
    (model["parameters"])["empirical"] = 0;
    return model;
}

/* Define a dictionary of amino-acid exchangeability rates for the JTT model of protein evolution. Note that this dictionary has been **normalized** using the JTT default frequencies. */ 
models.protein.JTT.empirical_Q = {
 "A":{
   "C":0.01164983,
   "D":0.04242226,
   "E":0.06594220000000001,
   "F":0.005605013,
   "G":0.1300142,
   "H":0.005055569,
   "I":0.01901336,
   "K":0.02198075,
   "L":0.02824504,
   "M":0.01099041,
   "N":0.02373925,
   "P":0.09902242999999999,
   "Q":0.02285967,
   "R":0.02714587,
   "S":0.2651969,
   "T":0.2681624,
   "V":0.1940882,
   "W":0.00120894,
   "Y":0.004506008
  },
 "C":{
   "D":0.005415286,
   "E":0.003332529,
   "F":0.02749291,
   "G":0.04082289,
   "H":0.01666262,
   "I":0.007914733,
   "K":0.002915936,
   "L":0.01499622,
   "M":0.009581053000000001,
   "N":0.01333012,
   "P":0.006248431,
   "Q":0.003749032,
   "R":0.05207011,
   "S":0.1470474,
   "T":0.02749309,
   "V":0.04123968,
   "W":0.01582953,
   "Y":0.06831603999999999
  },
 "D":{
   "E":0.4801284,
   "F":0.001318116,
   "G":0.0950686,
   "H":0.0237263,
   "I":0.00609632,
   "K":0.01680615,
   "L":0.005602049,
   "M":0.004448682,
   "N":0.2361102,
   "P":0.006425849,
   "Q":0.0214193,
   "R":0.007908676,
   "S":0.04020279,
   "T":0.02487944,
   "V":0.02092512,
   "W":0.0008238323,
   "Y":0.014664
  },
 "E":{
   "F":0.001776388,
   "G":0.08335330000000001,
   "H":0.005602518,
   "I":0.005875793,
   "K":0.1030317,
   "L":0.008881953,
   "M":0.004099415,
   "N":0.02459647,
   "P":0.009701838000000001,
   "Q":0.1403343,
   "R":0.01626078,
   "S":0.02131682,
   "T":0.01940362,
   "V":0.03088188,
   "W":0.001639765,
   "Y":0.002049689
  },
 "F":{
   "G":0.003751538,
   "H":0.01042113,
   "I":0.04085083,
   "K":0.00145895,
   "L":0.2278042,
   "M":0.01021273,
   "N":0.003126321,
   "P":0.00750314,
   "Q":0.001875789,
   "R":0.003334736,
   "S":0.0644024,
   "T":0.008128382,
   "V":0.03939149,
   "W":0.007711647,
   "Y":0.1771572
  },
 "G":{
   "H":0.004635577,
   "I":0.002826581,
   "K":0.01605493,
   "L":0.006331483,
   "M":0.003052693,
   "N":0.03290136,
   "P":0.01051474,
   "Q":0.009497159999999999,
   "R":0.06941973,
   "S":0.1278738,
   "T":0.01854212,
   "V":0.03120506,
   "W":0.007801362,
   "Y":0.001695907
  },
 "H":{
   "I":0.00955641,
   "K":0.03124215,
   "L":0.04925195,
   "M":0.007718657,
   "N":0.1712807,
   "P":0.05770555,
   "Q":0.2333939,
   "R":0.1639271,
   "S":0.0507224,
   "T":0.02793385,
   "V":0.008086143,
   "W":0.001837774,
   "Y":0.1889208
  },
 "I":{
   "K":0.01205203,
   "L":0.2127567,
   "M":0.1131285,
   "N":0.0208902,
   "P":0.004981443,
   "Q":0.003213843,
   "R":0.01221257,
   "S":0.02763923,
   "T":0.1494435,
   "V":0.6328057,
   "W":0.001928334,
   "Y":0.009802181
  },
 "K":{
   "L":0.01334602,
   "M":0.01462393,
   "N":0.1076208,
   "P":0.01093234,
   "Q":0.1218169,
   "R":0.333364,
   "S":0.03237125,
   "T":0.05650736,
   "V":0.008234754,
   "W":0.001277824,
   "Y":0.002839562
  },
 "L":{
   "M":0.09030557,
   "N":0.005841096,
   "P":0.05358937,
   "Q":0.0291124,
   "R":0.01900652,
   "S":0.04042405,
   "T":0.01594697,
   "V":0.1169137,
   "W":0.007602722,
   "Y":0.007788057
  },
 "M":{
   "N":0.0140708,
   "P":0.008298109999999999,
   "Q":0.0187608,
   "R":0.02200785,
   "S":0.01948259,
   "T":0.1237496,
   "V":0.2016795,
   "W":0.002886323,
   "Y":0.006133368
  },
 "N":{
   "P":0.006154998,
   "Q":0.03156908,
   "R":0.02303155,
   "S":0.3450795,
   "T":0.1375939,
   "V":0.01092017,
   "W":0.000397107,
   "Y":0.02263447
  },
 "P":{
   "Q":0.06603124,
   "R":0.03627542,
   "S":0.1902389,
   "T":0.06887338,
   "V":0.01404214,
   "W":0.001003017,
   "Y":0.003677695
  },
 "Q":{
   "R":0.1542939,
   "S":0.03744234,
   "T":0.03065318,
   "V":0.01193211,
   "W":0.002468744,
   "Y":0.008229024999999999
  },
 "R":{
   "S":0.06833079,
   "T":0.03805319,
   "V":0.01141599,
   "W":0.01803412,
   "Y":0.007610617
  },
 "S":{
   "T":0.2795782,
   "V":0.02711589,
   "W":0.004457448,
   "Y":0.02030591
  },
 "T":{
   "V":0.0759305,
   "W":0.00115485,
   "Y":0.006495937
  },
 "V":{
   "W":0.003436295,
   "Y":0.005345272
  },
 "W":{
   "Y":0.02415905
  }
};

//==================================================================================================================//


/**
 * @name models.protein.JC._GenerateRate
 * @private
 * @description Generate rate matrix for the JC69 (equal rates) model of protein evolution
 * @param {String} from - source amino acid
 * @param {String} to   - target amino acid
 * @param {String} namespace
 * @param {String} modelType
 */
function models.protein.JC._GenerateRate (from,to,namespace,modelType) {
    return models.protein.empirical._GenerateRate (models.protein.JC.empirical_Q, from,to,namespace,modelType);
}

 /**
 * @name models.protein.JC.ModelDescription
 * @description Create the baseline schema (dictionary) for the JC69 (equal rates) model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
function models.protein.JC.ModelDescription(type) {
    models.protein.JC.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.JC.ModelDescription.model_definition ["empirical-rates"] = models.protein.JC.empirical_Q;
    models.protein.JC.ModelDescription.model_definition ["frequency-estimator"] = "models.protein.JC.frequencies";
    models.protein.JC.ModelDescription.model_definition ["q_ij"] = "models.protein.JC._GenerateRate";
    return models.protein.JC.ModelDescription.model_definition;
}

/**
 * @name models.protein.JCF.ModelDescription
 * @description Create the baseline schema (dictionary) for the JC69+F model of protein evolution
 * @returns {Dictionary} model description
 * @param {String} type
 */
 /*
function models.protein.JCF.ModelDescription(type) {
    models.protein.JCF.ModelDescription.model_definition = models.protein.empirical.ModelDescription(type);
    models.protein.JCF.ModelDescription.model_definition ["empirical-rates"] = models.protein.JC.empirical_Q;
    models.protein.JCF.ModelDescription.model_definition ["frequency-estimator"] = "frequencies.empirical.protein";
    models.protein.JCF.ModelDescription.model_definition ["parameters"] = {"global": {}, "local": {}, "empirical": 19};
    models.protein.JCF.ModelDescription.model_definition ["q_ij"] = "models.protein.JC._GenerateRate";
    return models.protein.JCF.ModelDescription.model_definition;
}*/


/**
 * @name models.protein.JC.frequencies
 * @param {Dictionary} Baseline JC69 model
 * @returns {Dictionary} Updated JC69 model with empirical frequencies
 * @description Define the empirical amino acid frequencies associated with the JC69 model of protein evolution
 */
function models.protein.JC.frequencies (model, namespace, datafilter) {
    model[terms.efv_estimate] =
      {{	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {	0.05}
        {   0.05}
    };
    model[terms.efv_estimate_name] = terms.freqs.predefined;
    (model["parameters"])["empirical"] = 0;
    return model;
}

/* Define a dictionary of equal amino-acid exchangeability rates for the JC69 model of protein evolution.  Note that this dictionary has been **normalized** using the JC69 default frequencies. */ 
models.protein.JC.empirical_Q = {
    "A":
        {"C":0.05,
        "D":0.05,
        "E":0.05,
        "F":0.05,
        "G":0.05,
        "H":0.05,
        "I":0.05,
        "K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "C":
        {"D":0.05,
        "E":0.05,
        "F":0.05,
        "G":0.05,
        "H":0.05,
        "I":0.05,
        "K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "D":
        {"E":20.05,
        "F":0.05,
        "G":0.05,
        "H":0.05,
        "I":0.05,
        "K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "E":
        {"F":0.05,
        "G":0.05,
        "H":0.05,
        "I":0.05,
        "K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "F":
        {"G":0.05,
        "H":0.05,
        "I":0.05,
        "K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "G":
        {"H":0.05,
        "I":0.05,
        "K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "H":
        {"I":0.05,
        "K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "I":
        {"K":0.05,
        "L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":30.05,
        "W":0.05,
        "Y":0.05},
    "K":
        {"L":0.05,
        "M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":20.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "L":
        {"M":0.05,
        "N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "M":
        {"N":0.05,
        "P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "N":
        {"P":0.05,
        "Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "P":
        {"Q":0.05,
        "R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "Q":
        {"R":0.05,
        "S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "R":
        {"S":0.05,
        "T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "S":
        {"T":0.05,
        "V":0.05,
        "W":0.05,
        "Y":0.05},
    "T":
        {"V":0.05,
        "W":0.05,
        "Y":0.05},
    "V":
        {"W":0.05,
        "Y":0.05},
    "W":
        {"Y":0.05}
};



/**
 * @name models.protein.Empirical._GenerateRate
 * @description Generates the r_ij component of q_ij := r_ij * time * freq_j
 * @param {Dict} rateDict
 * @param {Number} fromChar
 * @param {Number} toChar
 * @param {String} namespace
 * @param {String} model_type
 * @return list of parameters
 */
function models.protein.empirical._GenerateRate(rateDict, fromChar, toChar, namespace, model_type) {

    models.protein.empirical._GenerateRate.p = {};
    models.protein.empirical._GenerateRate.p  [model_type]       = {};
    if (fromChar < toChar) {
        models.protein.empirical._GenerateRate.p  [terms.rate_entry] = "" + (rateDict[fromChar])[toChar];
    } else {
        models.protein.empirical._GenerateRate.p  [terms.rate_entry] = "" + (rateDict[toChar])[fromChar];
    }
    return models.protein.empirical._GenerateRate.p;
}

/**
 * @name models.protein.empirical._DefineQ
 * @param {Dictionary} model definition
 * @param {String} namespace
 */
function models.protein.empirical._DefineQ(model_dict, namespace) {
    models.protein.generic.DefineQMatrix (model_dict, namespace);
    return model_dict;
}