include <hand.scad>

//Parameter file
//Uncomment block to use various predefined examples
//Hands generated with call functions at the end of this file

//Digit type names
four_dof = 0;
four_dof_thumb = 1;
three_dof = 2;
three_dof_thumb = 3;
two_dof = 4;
two_dof_thumb = 5;

/*[ STL Configuration ] */
//Facet minimum scale
$fs = 1;  // Don't generate smaller facets than 0.1 mm
//Angle maximum
$fa = 10;    // Don't generate larger angles than 3 degrees


//////--------------------------------Human_v2---------------------------------//
/*[ Global Configurations ] */
//Number of fingers (0--?)
n_fingers = 4;
// Number of thumbs (0--2)
n_thumbs = 1;
//Print angle/hand inward curvature
a_print = 45;

/*[ Finger Configuration ] */
//Finger types
type_finger = [four_dof,
               four_dof,
               four_dof,
               four_dof];
//Finger ligament width and thickness
lig_finger = [[2.5,0.6]];
//Finger pulley length, thickness and radius
p_finger = [[5,1.5,1]];
//Finger bone lengths
bl_finger = [[80,	38, 20,	20],
             [82,	41,	20.5,	20.5],
             [79,	38,	19,	19],
             [74,	35,	17,	17]];
//Finger joint diameters
base_jd_finger = [[12.5],
                  [14],
                  [12.5],
                  [11]];
jd_finger = base_jd_finger*[[0.7, 1, 0.6, 0.5, 0.4]];
//Finger origins
o_finger = [[0,1.5,0],
            [0,0,-12],
            [0,1,-24],
            [0,3.5,-34]];
//Finger angles
a_finger = [[0,-10,0],
            [0,3,0],
            [0,16,0],
            [0,30,0]];
//Finger widths
base_w_finger = [[15],
                 [16],
                 [15],
                 [13]];
w_finger = base_w_finger*[[0.7, 1, 0.8, 0.7, 0.7]];

/*[ Thumb Configuration ] */
//Thumb types
type_thumb = [four_dof_thumb,
              four_dof_thumb];
//Thumb ligament width and thickness
lig_thumb = [[2.5,0.6]];
//Thumb pulley length, thickness and radius
p_thumb = [[5,2.2,1]];
//Thumb bone lengths
bl_thumb = [[25,	35,	25,	25],
            [25,	35,	25,	25]];
//Thumb joint diameters
base_jd_thumb = [[16],
                 [16]];
jd_thumb = base_jd_thumb*[[0.7, 1, 0.6, 0.5, 0.4]];
//Thumb origins
o_thumb = [[-3,5.5,15],
           [-3,5.5,-45]];
//Thumb angles
a_thumb = [[0,-100,0],
           [0,100,0]];
//Thumb widths
base_w_thumb = [[20],
                [20]];
w_thumb = base_w_thumb*[[0.7, 1, 0.8, 0.7, 0.7]];





//-----------------------------modular hand export------------------------//
//param1=3; //palm/digit type
//param2=0; //digit id
////palm = 0;
////finger = 1;
////thumb = 2;
////all = 3;
////openscad.com -o "palm_test.stl" -D "param1=0" -D "param2=0" parameters.scad && 
////openscad.com -o "finger0_test.stl" -D "param1=1" -D "param2=0" parameters.scad &&
////openscad.com -o "thumb0_test.stl" -D "param1=2" -D "param2=0" parameters.scad &&
//
//echo(param1);
//echo(param2);

//-----------basic verification that finger/thumb definitions exist-------//
assert(len(type_finger)>=n_fingers && len(bl_finger)>=n_fingers && len(jd_finger)>=n_fingers && len(o_finger)>=n_fingers && len(a_finger)>=n_fingers && len(w_finger)>=n_fingers, "Must be parameters defined for each of n_fingers");
assert(len(type_thumb)>=n_thumbs && len(bl_thumb)>=n_thumbs && len(jd_thumb)>=n_thumbs && len(o_thumb)>=n_thumbs && len(a_thumb)>=n_thumbs && len(w_thumb)>=n_thumbs, "Must be parameters defined for each of n_thumbs");
//-----------------------------generate from params-----------------------//
rotate([180,0,0]){
    hand();             // standard version for printing
//    hand_nolig();       // non-print version only for visualisation
//    single_finger();    // just generate index finger
//    hand_modular(model=param1,digit_id=param2);  // version where palm and fingers can be printed separately (model=all/palm/finger/thumb, digit_id=finger/thumb list index)
}
    
//---------------------------------camera setup---------------------------//
//$vpr = [ 85.10, 0.00, 8.90 ];
//$vpt = [ 2.93, -42.38, 87.58 ];
//$vpd = 623.64;
//$vpf = 22.50;

////for animation: fps 30, steps 360
//$vpr = [ 71.10, 0.00, 360*$t ];
//$vpt = [ 0, 0, 50 ];
//$vpd = 561.28;
//$vpf = 22.50;


echo(version());