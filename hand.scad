include <digits.scad>
include <parameters.scad>

//----------------------Finger----------------------//
union(){
    print_ang = 45;
    rotate([0,0,-print_ang])
        finger(bl_index,jd_index,ang=print_ang,pulley=p_index);
//    difference(){
//        translate([-10,jd_index[0]-10,-5])
//            cube([10,10,10]);
//        translate([-10.1,jd_index[0]-10.1,-2.5])
//            cube([10.2,10.2,5]);
//        translate([-10/2,jd_index[0]-5-0.1,-5.1]) rotate([0,0,0])
//            cylinder(10+0.2,2.5,2.5);
//    }
    translate([-10,jd_index[0]-8,10]) rotate([-90,0,0])
        difference(){
            cube([10.1,20,8]);
            translate([4,4,-0.1])
                cylinder(8.2,2,2);
            translate([4,16,-0.1])
                cylinder(8.2,2,2);
        }
}

//-----------------------Hand-----------------------//
//union(){
//    print_ang = 45;
//    rotate([0,0,0]){
//        //index finger
//        translate(o_index) rotate([0,0,-print_ang]) rotate([0,0,0])
//            finger(bl_index,jd_index,ang=print_ang,index=true,pulley=p_index);
//        //middle finger
//        translate(ro_middle) rotate([0,0,-print_ang]) rotate([0,10,0])
//            finger(bl_middle,jd_middle,ang=print_ang,pulley=p_index);
//        //ring finger
//        translate(ro_ring) rotate([0,0,-print_ang]) rotate([0,20,0])
//            finger(bl_ring,jd_ring,ang=print_ang,pulley=p_index);
//        //little finger
//        translate(ro_little) rotate([0,0,-print_ang]) rotate([0,30,0])
//            finger(bl_little,jd_little,ang=print_ang,pulley=p_index);
//        //thumb
//        translate(ro_thumb) rotate([0,0,-print_ang]) rotate([0,-90,0])
//            thumb(bl_thumb,jd_thumb,ang=print_ang,pulley=p_index); 
//        //palm
//        translate([0,max(o_index[1],ro_middle[1],ro_ring[1],ro_little[1],ro_thumb[1]),(ro_thumb[2]+ro_little[2])/2]) rotate([-90,0,0])
//            palm(min(jd_index[0],ro_middle[1]+jd_middle[0],ro_ring[1]+jd_ring[0],ro_little[1]+jd_little[0],ro_thumb[1]+jd_thumb[0])-max(o_index[1],ro_middle[1],ro_ring[1],ro_little[1],ro_thumb[1]),30,ro_thumb[2]-ro_little[2]+5);
//    }
//}
//---------------------------------------------------//

echo(version());