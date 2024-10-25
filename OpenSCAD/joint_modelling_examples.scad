include <hand.scad>

//Parameter file
//Uncomment block to use various predefined examples
//Hands generated with call functions at the end of this file


/*[ STL Configuration ] */
//Facet minimum scale
$fs = 1;  // Don't generate smaller facets than 0.1 mm
//Angle maximum
$fa = 5;    // Don't generate larger angles than 3 degrees


//---------------------------------Fingers--------------------------------//

////--------------------------------old human-------------------------------//
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
//bl_index = [70.34038861,	31.45565209*90/(31.45565209+19.39689333+19.70641476), 19.39689333*90/(31.45565209+19.39689333+19.70641476),	19.70641476*90/(31.45565209+19.39689333+19.70641476)];
////Index joint diameters
//jd_index = [10.76135651*90/(31.45565209+19.39689333+19.70641476),	9.685220862*90/(31.45565209+19.39689333+19.70641476),	8.716698775*90/(31.45565209+19.39689333+19.70641476)];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////--------------------------------mcp lowest------------------------------//
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
//bl_index = [70.34038861,	37.8, 29.7, 22.5];
////Index joint diameters
//jd_index = [6,	10,	14];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////--------------------------------pip lowest------------------------------//
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
//bl_index = [70.34038861,	20, 20, 50];
////Index joint diameters
//jd_index = [14,	6,	12];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////--------------------------------dip lowest------------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [2.5,0.6];
////Pulley length, thickness and radius
//p_index = [4,1.5,1];
//p_thumb = [5,2.2,1];
////Print angle
//a_print = 55;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [70.34038861,	22.5, 22.5, 45];
////Index joint diameters
//jd_index = [14,	10,	6];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////------------------------------------eee----------------------------------//
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
//bl_index = [70.34038861,	22.5, 29.7, 37.8];
////Index joint diameters
//jd_index = [12,	10,	8];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////------------------------------------efe----------------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [2.5,0.6];
////Pulley length, thickness and radius
//p_index = [4,1.5,1];
//p_thumb = [5,2.2,1];
////Print angle
//a_print = 55;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [70.34038861,	20, 20, 50];
////Index joint diameters
//jd_index = [7.4,	12,	6];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////------------------------------------eff----------------------------------//
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
//bl_index = [70.34038861,	37.575, 29.7, 22.5];
////Index joint diameters
//jd_index = [14,	10,	10];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////------------------------------------eef----------------------------------//
///*[ Global Configurations ] */
////Ligament width and thickness
//lig_index = [2.5,0.6];
////Pulley length, thickness and radius
//p_index = [4,1.5,1];
//p_thumb = [5,2.2,1];
////Print angle
//a_print = 55;
//
///*[ Index finger Configuration ] */
////Index bone lengths
//bl_index = [70.34038861,	20, 40, 30];
////Index joint diameters
//jd_index = [14,	6,	14];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////---------------------------------opt behav-------------------------------//
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
//bl_index = [70.34038861,	37.8, 29.7, 22.5];
////Index joint diameters
//jd_index = [14,	10,	6];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

////-----------------------------------opt stiff-------------------------------//
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
//bl_index = [70.34038861,23.203563,22.722392,44.074045];
////Index joint diameters
//jd_index = [6.629229*2,4.406876*2,3.18516 *2 ];
////Index origin
//o_index = [0,1.5,0];
////Index angle
//a_index = [0,-12.80426607,0];
////Index width
//w_index = 10.76135651-1;

//----------------------------------Hands---------------------------------//


//---------------------------------human-------------------------------//
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
//o_thumb = [-3,4.5+3,7.448036952+4];
////Middle angle
//a_thumb = [0,-73.85566122-16,0];
////Thumb width
//w_thumb = 12.37937763;


//-------------------------------opt hand------------------------------//
/*[ Global Configurations ] */
//Ligament width and thickness
lig_index = [2.5,0.6];
//Pulley length, thickness and radius
p_index = [5,1.5,1];
p_thumb = [5,2.2,1];
//Print angle
a_print = 45;

//scale factors
sf_joints = [6.629229*2,4.406876*2,3.18516 *2 ]; //input model joint diameters
sf_bones = [23.203563,22.722392,44.074045]; //input model bone lengths
tl = sf_bones[0]+sf_bones[1]+sf_bones[2];
sfj_norm = [sf_joints[0]/tl,sf_joints[1]/tl,sf_joints[2]/tl];
sfb_norm = [sf_bones[0]/tl,sf_bones[1]/tl,sf_bones[2]/tl];
echo(sfb_norm);


/*[ Index finger Configuration ] */
//Index bone lengths
bli = 31.45565209+19.39689333+19.70641476;
bl_index = [70.34038861, bli*sfb_norm[0], bli*sfb_norm[1], bli*sfb_norm[2]];
//Index joint diameters
jd_index = [bli*sfj_norm[0], bli*sfj_norm[1], bli*sfj_norm[2]];
//Index origin
o_index = [0,1.5,0];
//Index angle
a_index = [0,-12.80426607,0];
//Index width
w_index = 10.76135651-1;

/*[ Middle finger Configuration ] */
//Middle bone lengths
blm = 33.25815526+20.7852194+21.47806005;
bl_middle = [74.18573228, blm*sfb_norm[0], blm*sfb_norm[1], blm*sfb_norm[2]];
//Middle joint diameters
jd_middle = [blm*sfj_norm[0], blm*sfj_norm[1], blm*sfj_norm[2]];
//Middle origin
o_middle = [0,0,-7.448036952-3];
//Middle angle
a_middle = [0,-2.140901366,0];
//Middle width
w_middle = 11.43187067-1;

/*[ Ring finger Configuration ] */
//Ring bone lengths
blr = 30.98477567+19.9905839+21.0177524;
bl_ring = [71.42394053, blr*sfb_norm[0], blr*sfb_norm[1], blr*sfb_norm[2]];
//Ring joint diameters
jd_ring = [blr*sfj_norm[0], blr*sfj_norm[1], blr*sfj_norm[2]];
//Ring origin
o_ring = [0,1,-14.8960739-8];
//Ring angle
a_ring = [0,6.12537194,0];
//ring width
w_ring = 9.76135651-1;

/*[ Little finger Configuration ] */
//Little bone lengths
bll = 27.64859576+17.98718936+16.80406398;
bl_little = [59.76629115, bll*sfb_norm[0], bll*sfb_norm[1], bll*sfb_norm[2]];
//Little joint diameters
jd_little = [bll*sfj_norm[0], bll*sfj_norm[1], bll*sfj_norm[2]];
//Little origin
o_little = [0,3.5,-22.34411085-11];
//Little angle
a_little = [0,15.80854318,0];
//Little width
w_little = 8.910908342-1;

/*[ Thumb Configuration ] */
//Thumb bone lengths
blt = 38.75265286+26.99856966+22.34343949;
bl_thumb = [13.70441601+5, blt*sfb_norm[0], blt*sfb_norm[1], blt*sfb_norm[2]];
//Thumb joint diameters
jd_thumb = [blt*sfj_norm[0], blt*sfj_norm[1], blt*sfj_norm[2]];
//Thumb origin
o_thumb = [-3,4.5,7.448036952+4];
//Middle angle
a_thumb = [0,-73.85566122-16,0];
//Thumb width
w_thumb = 12.37937763;




//------------------------------camera setup------------------------//
//hand viewpoint
$vpr = [ 85.10, 0.00, 8.90 ];
$vpt = [ 2.93, -42.38, 87.58 ];
$vpd = 623.64;
$vpf = 22.50;

////for animation: fps 30, steps 360
//$vpr = [ 71.10, 0.00, 360*$t ];
//$vpt = [ 0, 0, 50 ];
//$vpd = 561.28;
//$vpf = 22.50;

//finger viewpoint
//$vpr = [ 180, 0.00, 90.0 ];
//$vpt = [ 77.10, 8.78, 56.06 ];
//$vpd = 454.64;
//$vpf = 22.50;




//-------------------------Generate from parameters-------------------------//
//translate([0,30,10])
//    rotate([135,0,0])
rotate([0,270,180])
    hand();             // standard version for printing
//    hand_nolig();       // non-print version only for visualisation
//    hand_2thumb();      // alternate version needed for opposition tendons
//rotate([0,0,0])
//single_finger_nolig();    // just generate index finger
//single_finger();



echo(version());