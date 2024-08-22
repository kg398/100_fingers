include <hand.scad>

//Parameter file
//Uncomment block to use various predefined examples
//Hands generated with call functions at the end of this file

/*[ STL Configuration ] */
//Facet minimum scale
$fs = 1;  // Don't generate smaller facets than 0.1 mm
//Angle maximum
$fa = 5;    // Don't generate larger angles than 3 degrees


//----------------------------------Human---------------------------------//
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
bl_index = [70.34038861,	31.45565209, 19.39689333,	19.70641476];
//Index joint diameters
jd_index = [10.76135651,	9.685220862,	8.716698775];
//Index origin
o_index = [0,1.5,0];
//Index angle
a_index = [0,-12.80426607,0];
//Index width
w_index = 10.76135651-1;

/*[ Middle finger Configuration ] */
//Middle bone lengths
bl_middle = [74.18573228,	33.25815526,	20.7852194,	21.47806005];
//Middle joint diameters
jd_middle = [11.43187067,	10.2886836,	9.259815242];
//Middle origin
o_middle = [0,0,-7.448036952-3];
//Middle angle
a_middle = [0,-2.140901366,0];
//Middle width
w_middle = 11.43187067-1;

/*[ Ring finger Configuration ] */
//Ring bone lengths
bl_ring = [71.42394053,	30.98477567,	19.9905839,	21.0177524];
//Ring joint diameters
jd_ring = [10.76135651,	9.685220862,	8.716698775];
//Ring origin
o_ring = [0,1,-14.8960739-8];
//Ring angle
a_ring = [0,6.12537194,0];
//ring width
w_ring = 9.76135651-1;

/*[ Little finger Configuration ] */
//Little bone lengths
bl_little = [59.76629115,	27.64859576,	17.98718936,	16.80406398];
//Little joint diameters
jd_little = [9.410908342,	8.469817508,	7.622835757];
//Little origin
o_little = [0,3.5,-22.34411085-11];
//Little angle
a_little = [0,15.80854318,0];
//Little width
w_little = 8.910908342-1;

/*[ Thumb Configuration ] */
//Thumb bone lengths
bl_thumb = [13.70441601+5,	38.75265286,	26.99856966,	22.34343949];
//Thumb joint diameters
jd_thumb = [12.37937763,	11.14143987,	10.02729588];
//Thumb origin
o_thumb = [-3,4.5,7.448036952+4];
//Middle angle
a_thumb = [0,-73.85566122-16,0];
//Thumb width
w_thumb = 12.37937763;



////----------------------------------Pan----------------------------------//
///*[ Global Configurations ] */
////Pulley length, thickness and radius
//p_index = [5,1.5,1.2];
////Print angle
//a_print = 45;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [78.5814874,	22.70714519,	15.45515503,	16.37773101];
////Index joint diameters
//jd_index = [10.38261892,	9.344357027,	8.409921324];
////Index origin
//o_index = [0,0,0];
////Index angle
//a_index = [0,-3.962210676,0];
////Index width
//w_index = 10.38261892-1;
//
///*[ Middle finger Configuration ] */
////Middle bone lengths
//bl_middle = [78.42010484,	30.55995004,	19.68325792,	21.71945701];
////Middle joint diameters
//jd_middle = [11.19909502,	10.07918552,	9.071266968];
////Middle origin
//o_middle = [0,0,-8.994813313-3];
////Middle angle
//a_middle = [0,-1.487867529,0];
////Middle width
//w_middle = 11.19909502-1;
//
///*[ Ring finger Configuration ] */
////Ring bone lengths
//bl_ring = [76.40571628,	28.89601759,	20.09439549,	20.38742755];
////Ring joint diameters
//jd_ring = [10.95475954,	9.859283588,	8.873355229];
////Ring origin
//o_ring = [0,0,-17.98962663-6];
////Ring angle
//a_ring = [0,2.036325455,0];
////ring width
//w_ring = 10.95475954-1;
//
///*[ Little finger Configuration ] */
////Little bone lengths
//bl_little = [71.99450876,	19.11329571,	14.62823217,	14.2897081];
////Little joint diameters
//jd_little = [9.841628959,	8.857466063,	7.971719457];
////Little origin
//o_little = [0,0,-26.98443994-9];
////Little angle
//a_little = [0,5.952459438,0];
////Little width
//w_little = 9.841628959-1;
//
///*[ Thumb Configuration ] */
////Thumb bone lengths
//bl_thumb = [9.131419036,	25.77845568,	16.30725852,	18.43856702];
////Thumb joint diameters
//jd_thumb = [11.72166247,	10.54949622,	9.494546601];
////Thumb origin
//o_thumb = [0,0,8.994813313+3];
////Middle angle
//a_thumb = [0,-48.0127875,0];
////Thumb width
//w_thumb = 11.72166247;


////------------------------------Daubentonia------------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [1.6,0.6];
////Pulley length, thickness and radius
//p_index = [3,1.2,0.8];
//p_thumb = [3,1.5,0.8];
////Print angle
//a_print = 45;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [44.95165397,	22.76539796,	17.60131558,	13.05569054];
////Index joint diameters
//jd_index = [6.43902691,	5.795124219,	5.215611797];
////Index origin
//o_index = [0,0,0];
////Index angle
//a_index = [0,-4.763641691,0];
////Index width
//w_index = 6.43902691;
//
///*[ Middle finger Configuration ] */
////Middle bone lengths
//bl_middle = [50.92307371,	51.24883862,	25.16351798,	14.65183245];
////Middle joint diameters
//jd_middle = [4.763236034,	4.286912431,	3.858221188];
////Middle origin
//o_middle = [0,0.8,-5.00566-3.5];
////Middle angle
//a_middle = [0,-1.527525442,0];
////Middle width
//w_middle = 4.763236034;
//
///*[ Ring finger Configuration ] */
////Ring bone lengths
//bl_ring = [50.92307371,	48.02365961,	34.67688176,	17.49301896];
////Ring joint diameters
//jd_ring = [7.325916226,	6.593324603,	5.933992143];
////Ring origin
//o_ring = [0,-0.3,-10.0113-7];
////Ring angle
//a_ring = [0,1.527525+1.5,0];
////ring width
//w_ring = 7.325916226;
//
///*[ Little finger Configuration ] */
////Little bone lengths
//bl_little = [39.27865058,	27.06860172,	24.24749413,	15.95383612];
////Little joint diameters
//jd_little = [7.466063348,	6.719457014,	6.047511312];
////Little origin
//o_little = [0,0.1,-15.01696833-10.5];
////Little angle
//a_little = [0,9.950626688,0];
////Little width
//w_little = 7.466063348;
//
///*[ Thumb Configuration ] */
////Thumb bone lengths
//bl_thumb = [7.812803914+6,	20.14591233,	20.14591233,	15.93577857];
////Thumb joint diameters
//jd_thumb = [9.131419036,	8.218277133,	7.39644942];
////Thumb origin
//o_thumb = [0,-1,5.005656109+3];
////Middle angle
//a_thumb = [0,-34.38034472-15,0];
////Thumb width
//w_thumb = 9.131419036;



////------------------------------Human 2 thumb-----------------------------//
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
//bl_index = [58.34038861,	28.45565209, 18.39689333,	18.70641476];
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
//bl_middle = [62.18573228,	30.25815526,	19.7852194,	20.47806005];
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
//bl_thumb = [13.70441601+5,	33.75265286,	23.99856966,	20.34343949];
////Thumb joint diameters
//jd_thumb = [12.37937763,	11.14143987,	10.02729588];
////Thumb origin
//o_thumb = [-3,6,7.448036952+1];
////Middle angle
//a_thumb = [0,-73.85566122-9,0];
////Thumb width
//w_thumb = 12.37937763;





//-------------------------Generate from parameters-------------------------//
rotate([180,0,0])
    hand();             // standard version for printing
//    hand_nolig();       // non-print version only for visualisation
//    hand_2thumb();      // alternate version needed for opposition tendons
//    single_finger();    // just generate index finger


echo(version());