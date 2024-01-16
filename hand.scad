include <digits.scad>

//----------------------Finger----------------------//
module single_finger(){
    union(){
        print_ang = a_print;
        rotate([0,0,-print_ang])
            //finger(bl_index,jd_index,bone_width=bw_index,ang=print_ang,pulley=p_index);
            finger(bl_index,jd_index,ang=print_ang,index=0,pulley=p_index,bone_width=w_index);
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
}

//-----------------------Hand-----------------------//
module hand(){
    union(){
        print_ang = a_print;
        rotate([0,0,0]){
            //index finger
            translate(o_index) rotate([0,0,-print_ang]) rotate(a_index)
                finger(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],pulley=p_index,bone_width=w_index);
            //middle finger
            translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle)
                finger(bl_middle,jd_middle,ang=print_ang,pulley=p_index,bone_width=w_middle);
            //ring finger
            translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring)
                finger(bl_ring,jd_ring,ang=print_ang,pulley=p_index,bone_width=w_ring);
            //little finger
            translate(o_little) rotate([0,0,-print_ang]) rotate(a_little)
                finger(bl_little,jd_little,ang=print_ang,pulley=p_index,bone_width=w_little);
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                thumb(bl_thumb,jd_thumb,ang=print_ang,bone_width=w_thumb); 
            //palm
            translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]),(o_thumb[2]+o_little[2])/2]) rotate([-90,0,0])
                palm(min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]),30,o_thumb[2]-o_little[2]+5);
        }
    }
}

//------------------Hand --- no lig------------------//
module hand_nolig(){
    union(){
        print_ang = a_print;
        rotate([0,0,0]){
            //index finger
            translate(o_index) rotate([0,0,-print_ang]) rotate(a_index)
                finger_nolig(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],pulley=p_index,bone_width=w_index);
            //middle finger
            translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle)
                finger_nolig(bl_middle,jd_middle,ang=print_ang,pulley=p_index,bone_width=w_middle);
            //ring finger
            translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring)
                finger_nolig(bl_ring,jd_ring,ang=print_ang,pulley=p_index,bone_width=w_ring);
            //little finger
            translate(o_little) rotate([0,0,-print_ang]) rotate(a_little)
                finger_nolig(bl_little,jd_little,ang=print_ang,pulley=p_index,bone_width=w_little);
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                thumb_nolig(bl_thumb,jd_thumb,ang=print_ang,bone_width=w_thumb); 
            //palm
            translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]),(o_thumb[2]+o_little[2])/2]) rotate([-90,0,0])
                palm(min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]),30,o_thumb[2]-o_little[2]+5);
        }
    }
}
