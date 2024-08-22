include <hand.scad>

//Parameter file
//Uncomment block to use various predefined examples
//Hands generated with call functions at the end of this file


/*[ STL Configuration ] */
//Facet minimum scale
$fs = 1;  // Don't generate smaller facets than 0.1 mm
//Angle maximum
$fa = 5;    // Don't generate larger angles than 3 degrees


//----------------------------------Hands---------------------------------//

//----------------------------ardipithecus_ramidus------------------------//
/*[ Global Configurations ] */
//Ligament width and thickness
lig_index = [2.5,0.6];
//Pulley length, thickness and radius
p_index = [5,1.5,1];
p_thumb = [5,2.2,1];
//Print angle
a_print = 45;

/*[ Index finger Configuration ] */
//Index bone lengths
bl_index = [64.58671708,	31.57699391,	20.29860911,	11.80390069];
//Index joint diameters
jd_index = [8.437246481,	7.593521833,	6.834169649];
//Index origin
o_index = [0,1.5,0];
//Index angle
a_index = [0,-10.58163552-2,0];
//Index width
w_index = 8.437246481-0;

/*[ Middle finger Configuration ] */
//Middle bone lengths
bl_middle = [67.02124249,	34.92729836,	25.11627907,	13.25581395];
//Middle joint diameters
jd_middle = [9.425062386,	8.482556147,	7.634300532];
//Middle origin
o_middle = [0,0,-6.36627907-3];
//Middle angle
a_middle = [0,-2.087983833,0];
//Middle width
w_middle = 9.425062386-0;

/*[ Ring finger Configuration ] */
//Ring bone lengths
bl_ring = [67.30388854,	34.75791267,	23.0575854,	12.63542112];
//Ring joint diameters
jd_ring = [9.521402835,	8.569262552,	7.712336297];
//Ring origin
o_ring = [0,1,-12.73255814-8];
//Ring angle
a_ring = [0,5.651494881+2,0];
//ring width
w_ring = 9.521402835-0;

/*[ Little finger Configuration ] */
//Little bone lengths
bl_little = [62.97836308,	29.73312884,	24.49324142,	12.46574539];
//Little joint diameters
jd_little = [7.721840798,	6.949656718,	6.254691046];
//Little origin
o_little = [0,3.5,-19.09883721-11];
//Little angle
a_little = [0,13.66322934+5,0];
//Little width
w_little = 7.721840798-0;

/*[ Thumb Configuration ] */
//Thumb bone lengths
bl_thumb = [18.540952,	24.2535953,	27.02306568,	16.78048391];
//Thumb joint diameters
jd_thumb = [11.42674839,	10.28407355,	9.255666193];
//Thumb origin
o_thumb = [-3,4.5,6.36627907+4];
//Middle angle
a_thumb = [0,-48.81407483-30,0];
//Thumb width
w_thumb = 11.42674839;



////---------------------------------human-------------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [2.5,0.6];
////Pulley length, thickness and radius
//p_index = [5,1.5,1];
//p_thumb = [5,2.2,1];
////Print angle
//a_print = 55;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [70.34038861,	31.45565209, 19.39689333,	19.70641476];
////Index joint diameters
//jd_index = [10.76135651,	9.685220862,	8.716698775];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;
//
///*[ Middle finger Configuration ] */
////Middle bone lengths
//bl_middle = [74.18573228,	33.25815526,	20.7852194,	21.47806005];
////Middle joint diameters
//jd_middle = [11.43187067,	10.2886836,	9.259815242];
////Middle origin
//o_middle = [0,0,-7.448036952-3];
////Middle angle
//a_middle = [0,-2.140901366,0];
////Middle width
//w_middle = 11.43187067-1;
//
///*[ Ring finger Configuration ] */
////Ring bone lengths
//bl_ring = [71.42394053,	30.98477567,	19.9905839,	21.0177524];
////Ring joint diameters
//jd_ring = [10.76135651,	9.685220862,	8.716698775];
////Ring origin
//o_ring = [0,1,-14.8960739-8];
////Ring angle
//a_ring = [0,6.12537194,0];
////ring width
//w_ring = 9.76135651-1;
//
///*[ Little finger Configuration ] */
////Little bone lengths
//bl_little = [59.76629115,	27.64859576,	17.98718936,	16.80406398];
////Little joint diameters
//jd_little = [9.410908342,	8.469817508,	7.622835757];
////Little origin
//o_little = [0,3.5,-22.34411085-11];
////Little angle
//a_little = [0,15.80854318,0];
////Little width
//w_little = 8.910908342-1;
//
///*[ Thumb Configuration ] */
////Thumb bone lengths
//bl_thumb = [13.70441601+5,	38.75265286,	26.99856966,	22.34343949];
////Thumb joint diameters
//jd_thumb = [12.37937763,	11.14143987,	10.02729588];
////Thumb origin
//o_thumb = [-3,4.5,7.448036952+4];
////Middle angle
//a_thumb = [0,-73.85566122-16,0];
////Thumb width
//w_thumb = 12.37937763;


////----------------------------bushbaby-----------------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [2.50,0.60];
////Pulley length, thickness and radius
//p_index = [5.00,1.50,1.00];
//p_thumb = [5.00,2.20,1.00];
////Print angle
//a_print = 45.00;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [56.63853107,	25.8068815,	17.61196125,	17.84533334];
////Index joint diameters
//jd_index = [9.096561496,	8.186905346,	7.368214811];
////Index origin
//o_index = [0,0,0];
////Index angle
//a_index = [0,-7.431407971,0];
////Index width
//w_index = 9.096561496-1.5;
//
///*[ Middle finger Configuration ] */
////Middle bone lengths
//bl_middle = [59.01950343,	34.2997634,	28.30959567,	19.29987376];
////Middle joint diameters
//jd_middle = [8.720930233,	7.848837209,	7.063953488];
////Middle origin
//o_middle = [0,0,-6.453488372-4];
////Middle angle
//a_middle = [0,-2.7102031,0];
////Middle width
//w_middle = 8.720930233-1;
//
///*[ Ring finger Configuration ] */
////Ring bone lengths
//bl_ring = [58.9792843,	34.53488372,	30.72937053,	23.72093023];
////Ring joint diameters
//jd_ring = [9.425062386,	8.482556147,	7.634300532];
////Ring origin
//o_ring = [0,0,-12.90697674-9];
////Ring angle
//a_ring = [0,1.694647069,0];
////ring width
//w_ring = 9.425062386-1;
//
///*[ Little finger Configuration ] */
////Little bone lengths
//bl_little = [57.10071942,	31.08372476,	19.54733822,	20.93313933];
////Little joint diameters
//jd_little = [8.437246481,	7.593521833,	6.834169649];
////Little origin
//o_little = [0,0,-19.36046512-13.5];
////Little angle
//a_little = [0,5.257809169+2,0];
////Little width
//w_little = 8.437246481-1;
//
///*[ Thumb Configuration ] */
////Thumb bone lengths
//bl_thumb = [24.74532258,	28.87141632,	26.84913684,	23.55878233];
////Thumb joint diameters
//jd_thumb = [12.46574539,	11.21917085,	10.09725376];
////Thumb origin
//o_thumb = [0,0,6.453488372+3];
////Middle angle
//a_thumb = [0,-40.42607874,0];
////Thumb width
//w_thumb = 12.46574539-2.5;


//-----------------------------chimpanzee-----------------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [2.50,0.60];
////Pulley length, thickness and radius
//p_index = [5.00,1.50,1.00];
//p_thumb = [5.00,2.20,1.00];
////Print angle
//a_print = 45.00;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [78.5814874,	22.70714519,	18.45515503,	15.37773101];
////Index joint diameters
//jd_index = [10.38261892,	9.344357027,	8.409921324];
////Index origin
//o_index = [0,0,0];
////Index angle
//a_index = [0,-3.962210676,0];
////Index width
//w_index = 10.38261892-2;
//
///*[ Middle finger Configuration ] */
////Middle bone lengths
//bl_middle = [78.42010484,	30.55995004,	22.68325792,	18.71945701];
////Middle joint diameters
//jd_middle = [11.19909502,	10.07918552,	9.071266968];
////Middle origin
//o_middle = [0,0,-8.994813313-3];
////Middle angle
//a_middle = [0,-1.487867529,0];
////Middle width
//w_middle = 11.19909502-2;
//
///*[ Ring finger Configuration ] */
////Ring bone lengths
//bl_ring = [76.40571628,	28.89601759,	23.09439549,	18.38742755];
////Ring joint diameters
//jd_ring = [10.95475954,	9.859283588,	8.873355229];
////Ring origin
//o_ring = [0,0,-17.98962663-6];
////Ring angle
//a_ring = [0,2.036325455,0];
////ring width
//w_ring = 10.95475954-2;
//
///*[ Little finger Configuration ] */
////Little bone lengths
//bl_little = [71.99450876,	19.11329571,	17.62823217,	15.2897081];
////Little joint diameters
//jd_little = [9.841628959,	8.857466063,	7.971719457];
////Little origin
//o_little = [0,0,-26.98443994-9];
////Little angle
//a_little = [0,5.952459438,0];
////Little width
//w_little = 9.841628959-2;
//
///*[ Thumb Configuration ] */
////Thumb bone lengths
//bl_thumb = [14.131419036,	22.77845568,	18.80725852,	15.43856702];
////Thumb joint diameters
//jd_thumb = [10.72166247,	9.54949622,	8.494546601];
////Thumb origin
//o_thumb = [0,0,8.994813313+3];
////Middle angle
//a_thumb = [0,-40.0127875,0];
////Thumb width
//w_thumb = 11.72166247-1;


//---------------------------------scale075------------------------//
///*[ Global Configurations ] */
//     //Ligament width and thickness
//     lig_index = [2.50,0.60];
//     //Pulley length, thickness and radius
//     p_index = [4.00,1.10,0.90];
//     p_thumb = [4.00,1.50,0.90];
//     //Print angle
//     a_print = 45.00;
//     
//     /*[ Index finger Configuration ] */
//     //Index bone lengths
//     bl_index = [47.76,23.59,14.55,14.78];
//     //Index joint diameters
//     jd_index = [8.07,7.26,6.54];
//     //Index origin
//     o_index = [0.00,1.20,0.00];
//     //Index angle
//     a_index = [0.00,-12.80,0.00];
//     //Index width
//     w_index = 7.07;
//     
//     /*[ Middle finger Configuration ] */
//     //Middle bone lengths
//     bl_middle = [50.64,24.94,15.59,16.11];
//     //Middle joint diameters
//     jd_middle = [8.57,7.72,6.94];
//     //Middle origin
//     o_middle = [0.00,0.00,-8.36];
//     //Middle angle
//     a_middle = [0.00,-2.14,0.00];
//     //Middle width
//     w_middle = 7.57;
//     
//     /*[ Ring finger Configuration ] */
//     //Ring bone lengths
//     bl_ring = [48.57,23.24,14.99,15.76];
//     //Ring joint diameters
//     jd_ring = [8.07,7.26,6.54];
//     //Ring origin
//     o_ring = [0.00,0.80,-18.32];
//     //Ring angle
//     a_ring = [0.00,6.13,0.00];
//     //ring width
//     w_ring = 6.32;
//     
//     /*[ Little finger Configuration ] */
//     //Little bone lengths
//     bl_little = [39.82,20.74,13.49,12.60];
//     //Little joint diameters
//     jd_little = [7.06,6.35,5.72];
//     //Little origin
//     o_little = [0.00,2.80,-26.68];
//     //Little angle
//     a_little = [0.00,15.81,0.00];
//     //Little width
//     w_little = 5.68;
//     
//     /*[ Thumb Configuration ] */
//     //Thumb bone lengths
//     bl_thumb = [14.03,29.06,20.25,16.76];
//     //Thumb joint diameters
//     jd_thumb = [9.28,8.36,7.52];
//     //Thumb origin
//     o_thumb = [-2.40,3.60,9.16];
//     //Middle angle
//     a_thumb = [0.00,-89.86,0.00];
//     //Thumb width
//     w_thumb = 9.28;


//----------------------------------scale05------------------------//
///*[ Global Configurations ] */
//     //Ligament width and thickness
//     lig_index = [2.50,0.60];
//     //Pulley length, thickness and radius
//     p_index = [3.00,0.80,0.80];
//     p_thumb = [3.00,1.00,0.80];
//     //Print angle
//     a_print = 45.00;
//     
//     /*[ Index finger Configuration ] */
//     //Index bone lengths
//     bl_index = [25.17,15.73,9.70,9.85];
//     //Index joint diameters
//     jd_index = [5.38,4.84,4.36];
//     //Index origin
//     o_index = [0.00,0.90,0.00];
//     //Index angle
//     a_index = [0.00,-12.80,0.00];
//     //Index width
//     w_index = 4.38;
//     
//     /*[ Middle finger Configuration ] */
//     //Middle bone lengths
//     bl_middle = [27.09,16.63,10.39,10.74];
//     //Middle joint diameters
//     jd_middle = [5.72,5.14,4.63];
//     //Middle origin
//     o_middle = [0.00,0.00,-6.27];
//     //Middle angle
//     a_middle = [0.00,-2.14,0.00];
//     //Middle width
//     w_middle = 4.72;
//     
//     /*[ Ring finger Configuration ] */
//     //Ring bone lengths
//     bl_ring = [25.71,15.49,10.00,10.51];
//     //Ring joint diameters
//     jd_ring = [5.38,4.84,4.36];
//     //Ring origin
//     o_ring = [0.00,0.60,-13.74];
//     //Ring angle
//     a_ring = [0.00,6.13,0.00];
//     //ring width
//     w_ring = 3.88;
//     
//     /*[ Little finger Configuration ] */
//     //Little bone lengths
//     bl_little = [19.88,13.82,8.99,8.40];
//     //Little joint diameters
//     jd_little = [4.71,4.23,3.81];
//     //Little origin
//     o_little = [0.00,2.10,-20.01];
//     //Little angle
//     a_little = [0.00,15.81,0.00];
//     //Little width
//     w_little = 3.46;
//     
//     /*[ Thumb Configuration ] */
//     //Thumb bone lengths
//     bl_thumb = [9.35,19.38,13.50,11.17];
//     //Thumb joint diameters
//     jd_thumb = [6.19,5.57,5.01];
//     //Thumb origin
//     o_thumb = [-1.80,2.70,6.87];
//     //Middle angle
//     a_thumb = [0.00,-89.86,0.00];
//     //Thumb width
//     w_thumb = 6.19;


//-------------------------------7fingers------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [2.5,0.6];
////Pulley length, thickness and radius
//p_index = [5,1.5,1];
//p_thumb = [5,2.2,1];
////Print angle
//a_print = 45;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [70.34038861,	31.45565209, 19.39689333,	19.70641476];
////Index joint diameters
//jd_index = [10.76135651,	9.685220862,	8.716698775];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;
//
///*[ Middle finger Configuration ] */
////Middle bone lengths
//bl_middle = [74.18573228,	33.25815526,	20.7852194,	21.47806005];
////Middle joint diameters
//jd_middle = [11.43187067,	10.2886836,	9.259815242];
////Middle origin
//o_middle = [0,0,-7.448036952-3];
////Middle angle
//a_middle = [0,-2.140901366,0];
////Middle width
//w_middle = 11.43187067-1;
////duplicate t/r [0,0,-13],[0,6,0]
//
///*[ Ring finger Configuration ] */
////Ring bone lengths
//bl_ring = [71.42394053,	30.98477567,	19.9905839,	21.0177524];
////Ring joint diameters
//jd_ring = [10.76135651,	9.685220862,	8.716698775];
////Ring origin
//o_ring = [0,1,-14.8960739-8-15];
////Ring angle
//a_ring = [0,6.12537194,0];
////ring width
//w_ring = 9.76135651-1;
////duplicate t/r [0,0,-12],[0,6,0]
//
///*[ Little finger Configuration ] */
////Little bone lengths
//bl_little = [59.76629115,	27.64859576,	17.98718936,	16.80406398];
////Little joint diameters
//jd_little = [9.410908342,	8.469817508,	7.622835757];
////Little origin
//o_little = [0,3.5,-22.34411085-11-30];
////Little angle
//a_little = [0,15.80854318,0];
////Little width
//w_little = 8.910908342-1;
//
///*[ Thumb Configuration ] */
////Thumb bone lengths
//bl_thumb = [13.70441601+5,	38.75265286,	26.99856966,	22.34343949];
////Thumb joint diameters
//jd_thumb = [12.37937763,	11.14143987,	10.02729588];
////Thumb origin
//o_thumb = [-3,4.5,7.448036952+4];
////Middle angle
//a_thumb = [0,-73.85566122-16,0];
////Thumb width
//w_thumb = 12.37937763;


//-------------------------------------rnd_pos------------------------//
///*[ Global Configurations ] */
//     //Ligament width and thickness
//     lig_index = [2.50,0.60];
//     //Pulley length, thickness and radius
//     p_index = [5.00,1.50,1.00];
//     p_thumb = [5.00,2.20,1.00];
//     //Print angle
//     a_print = 45.00;
//     
//     /*[ Index finger Configuration ] */
//     //Index bone lengths
//     bl_index = [70.34,31.46,19.40,19.71];
//     //Index joint diameters
//     jd_index = [10.76,9.69,8.72];
//     //Index origin
//     o_index = [0.00,1.50,0.00];
//     //Index angle
//     a_index = [0.00,-17.89,0.00];
//     //Index width
//     w_index = 9.76;
//     
//     /*[ Middle finger Configuration ] */
//     //Middle bone lengths
//     bl_middle = [74.19,33.26,20.79,21.48];
//     //Middle joint diameters
//     jd_middle = [11.43,10.29,9.26];
//     //Middle origin
//     o_middle = [0.00,0.00,-13.12];
//     //Middle angle
//     a_middle = [0.00,-1.77,0.00];
//     //Middle width
//     w_middle = 10.43;
//     
//     /*[ Ring finger Configuration ] */
//     //Ring bone lengths
//     bl_ring = [71.42,30.98,19.99,21.02];
//     //Ring joint diameters
//     jd_ring = [10.76,9.69,8.72];
//     //Ring origin
//     o_ring = [0.00,1.00,-28.22];
//     //Ring angle
//     a_ring = [0.00,1,0.00];
//     //ring width
//     w_ring = 8.76;
//     
//     /*[ Little finger Configuration ] */
//     //Little bone lengths
//     bl_little = [59.77,27.65,17.99,16.80];
//     //Little joint diameters
//     jd_little = [9.41,8.47,7.62];
//     //Little origin
//     o_little = [0.00,3.50,-45.56];
//     //Little angle
//     a_little = [0.00,40.63,0.00];
//     //Little width
//     w_little = 7.91;
//     
//     /*[ Thumb Configuration ] */
//     //Thumb bone lengths
//     bl_thumb = [18.70,38.75,27.00,22.34];
//     //Thumb joint diameters
//     jd_thumb = [12.38,11.14,10.03];
//     //Thumb origin
//     o_thumb = [-3.00,4.50,11.26];
//     //Middle angle
//     a_thumb = [0.00,-119.14,0.00];
//     //Thumb width
//     w_thumb = 12.38;

//------------------------------------rnd_joint------------------------//
///*[ Global Configurations ] */
//     //Ligament width and thickness
//     lig_index = [2.50,0.60];
//     //Pulley length, thickness and radius
//     p_index = [5.00,1.50,1.00];
//     p_thumb = [5.00,2.20,1.00];
//     //Print angle
//     a_print = 45.00;
//     
//     /*[ Index finger Configuration ] */
//     //Index bone lengths
//     bl_index = [70.34,31.46,19.40,19.71];
//     //Index joint diameters
//     jd_index = [12.20,5.97,8.26];
//     //Index origin
//     o_index = [0.00,1.50,0.00];
//     //Index angle
//     a_index = [0.00,-12.80,0.00];
//     //Index width
//     w_index = 9.76;
//     
//     /*[ Middle finger Configuration ] */
//     //Middle bone lengths
//     bl_middle = [74.19,33.26,20.79,21.48];
//     //Middle joint diameters
//     jd_middle = [9.39,12.73,6.16];
//     //Middle origin
//     o_middle = [0.00,0.00,-10.45];
//     //Middle angle
//     a_middle = [0.00,-2.14,0.00];
//     //Middle width
//     w_middle = 10.43;
//     
//     /*[ Ring finger Configuration ] */
//     //Ring bone lengths
//     bl_ring = [71.42,30.98,19.99,21.02];
//     //Ring joint diameters
//     jd_ring = [17.97,9.85,7.95];
//     //Ring origin
//     o_ring = [0.00,1.00,-22.90];
//     //Ring angle
//     a_ring = [0.00,6.13,0.00];
//     //ring width
//     w_ring = 8.76;
//     
//     /*[ Little finger Configuration ] */
//     //Little bone lengths
//     bl_little = [59.77,27.65,17.99,16.80];
//     //Little joint diameters
//     jd_little = [19.01,6.86,9.81];
//     //Little origin
//     o_little = [0.00,3.50,-33.34];
//     //Little angle
//     a_little = [0.00,15.81,0.00];
//     //Little width
//     w_little = 7.91;
//     
//     /*[ Thumb Configuration ] */
//     //Thumb bone lengths
//     bl_thumb = [18.70,38.75,27.00,22.34];
//     //Thumb joint diameters
//     jd_thumb = [21.06,11.18,11.25];
//     //Thumb origin
//     o_thumb = [-3.00,8.50,20.45];
//     //Middle angle
//     a_thumb = [0.00,-89.86,0.00];
//     //Thumb width
//     w_thumb = 12.38;


//------------------------------------rnd_bone------------------------//
/*[ Global Configurations ] */
//     //Ligament width and thickness
//     lig_index = [2.50,0.60];
//     //Pulley length, thickness and radius
//     p_index = [5.00,1.50,1.00];
//     p_thumb = [5.00,2.20,1.00];
//     //Print angle
//     a_print = 45.00;
//     
//     /*[ Index finger Configuration ] */
//     //Index bone lengths
//     bl_index = [67.89,49.73,31.77,31.39];
//     //Index joint diameters
//     jd_index = [10.76,9.69,8.72];
//     //Index origin
//     o_index = [0.00,1.50,0.00];
//     //Index angle
//     a_index = [0.00,-12.80,0.00];
//     //Index width
//     w_index = 9.76;
//     
//     /*[ Middle finger Configuration ] */
//     //Middle bone lengths
//     bl_middle = [38.56,48.24,20.95,21.92];
//     //Middle joint diameters
//     jd_middle = [11.43,10.29,9.26];
//     //Middle origin
//     o_middle = [0.00,0.00,-10.45];
//     //Middle angle
//     a_middle = [0.00,-2.14,0.00];
//     //Middle width
//     w_middle = 10.43;
//     
//     /*[ Ring finger Configuration ] */
//     //Ring bone lengths
//     bl_ring = [32.31,23.89,44.70,32.37];
//     //Ring joint diameters
//     jd_ring = [10.76,9.69,8.72];
//     //Ring origin
//     o_ring = [0.00,1.00,-22.90];
//     //Ring angle
//     a_ring = [0.00,6.13,0.00];
//     //ring width
//     w_ring = 8.76;
//     
//     /*[ Little finger Configuration ] */
//     //Little bone lengths
//     bl_little = [45.85,58.01,21.03,25.97];
//     //Little joint diameters
//     jd_little = [9.41,8.47,7.62];
//     //Little origin
//     o_little = [0.00,3.50,-33.34];
//     //Little angle
//     a_little = [0.00,15.81,0.00];
//     //Little width
//     w_little = 7.91;
//     
//     /*[ Thumb Configuration ] */
//     //Thumb bone lengths
//     bl_thumb = [39.80,50.62,43.86,19.67];
//     //Thumb joint diameters
//     jd_thumb = [12.38,11.14,10.03];
//     //Thumb origin
//     o_thumb = [-3.00,4.50,11.45];
//     //Middle angle
//     a_thumb = [0.00,-89.86,0.00];
//     //Thumb width
//     w_thumb = 12.38;


//------------------------------camera setup------------------------//
$vpr = [ 85.10, 0.00, 8.90 ];
$vpt = [ 2.93, -42.38, 87.58 ];
$vpd = 623.64;
$vpf = 22.50;


//-------------------------Generate from parameters-------------------------//
rotate([0,270,180])
//    hand();             // standard version for printing
    hand_nolig();       // non-print version only for visualisation
//    hand_2thumb();      // alternate version needed for opposition tendons
//    single_finger();    // just generate index finger



echo(version());