include <primitives_v2.scad>

//bone_lengths = [50,40,35,25];
//joint_diams = [12,10,8];

//finger(bone_lengths,joint_diams,ang=45,index=false);
//finger module
//bone_lengths -> length of each bone [meta,prox,inte,dist]
//joint_diams -> diameter of each joint [mcp,pip,dip]
//bone_width -> overall width
//jt -> joint types unused {0}->{default}
//ang -> ligament angle, use for printing bones in different orientations
//index -> enable extra pulley on index finger for thumb adduction
module finger(bone_lengths, joint_diams, bone_width=10, jt=0, ang=0, index=false,pulley=[5,1.5,1]){
    lw=1.6;//default ligament width
    lt=0.6;//default ligament thickness
    rotate([0,0,ang]){
        union(){
            //metacarpal
            bone(bone_lengths[0],joint_diams[0],joint_diams[0],bone_width,bone_type=meta,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2]);
            //relative translate from mcp geometry
            translate([bone_lengths[0]-joint_diams[0]+(0.5*PI*joint_diams[0]+lt)*cos(ang),-joint_diams[0]+lt+0.2-(0.5*PI*joint_diams[0]+lt)*sin(ang),0]){
                //proximal
                bone(bone_lengths[1],joint_diams[0],joint_diams[1],bone_width,bone_type=prox,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2]);
                //relative translate from pip geometry
                translate([bone_lengths[1]-joint_diams[1]+(0.5*PI*joint_diams[1]+lt)*cos(ang),-joint_diams[1]+lt+0.2-(0.5*PI*joint_diams[1]+lt)*sin(ang),0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[1],joint_diams[2],bone_width,bone_type=inte,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2]);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]-joint_diams[2]+(0.5*PI*joint_diams[2]+lt)*cos(ang),-joint_diams[2]+lt+0.2-(0.5*PI*joint_diams[2]+lt)*sin(ang),0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[2],0.8*joint_diams[2],bone_width,bone_type=dist,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2]);
                    }
                }
            }
            if(index){
                //abd1
                translate([bone_lengths[0]/2-joint_diams[0]/2,joint_diams[0]/2,bone_width/2]) rotate([90,0,0])
                    pulley(5,1,2,o_fillet=true,t_fillet=true);
            }
        }
    }
}

//thumb(bone_lengths,joint_diams,ang=0,index=true);
//thumb module
//bone_lengths -> length of each bone [meta,prox,inte,dist]
//joint_diams -> diameter of each joint [mcp,pip,dip]
//bone_width -> overall width
//jt -> joint types unused {0}->{default}
//ang -> ligament angle, use for printing bones in different orientations
module thumb(bone_lengths, joint_diams, bone_width=15, jt=0, ang=0){
    ligament_width=1.6;//default ligament width
    ligament_thickness=0.6;//default ligament thickness
    pulley_length=5;
    pulley_thickness=2.2;
    pulley_radius=1;
    rotate([0,0,ang]){
        union(){
            //carpal
            bone(bone_lengths[0],joint_diams[0],joint_diams[0],bone_width,bone_type=carp,joint_type=jt,lig_ang=ang,lw=ligament_width,lt=ligament_thickness,pl=pulley_length,pt=pulley_thickness,pr=pulley_radius);
            //relative translate from mcp geometry
            translate([bone_lengths[0]-joint_diams[0]+(0.5*PI*joint_diams[0]+ligament_thickness)*cos(ang),-joint_diams[0]+ligament_thickness+0.2-(0.5*PI*joint_diams[0]+ligament_thickness)*sin(ang),0]){
                //proximal
                bone(bone_lengths[1],joint_diams[0],joint_diams[1],bone_width,bone_type=prox,joint_type=jt,lig_ang=ang,pl=pulley_length,pt=pulley_thickness,pr=pulley_radius);
                //relative translate from pip geometry
                translate([bone_lengths[1]-joint_diams[1]+(0.5*PI*joint_diams[1]+ligament_thickness)*cos(ang),-joint_diams[1]+ligament_thickness+0.2-(0.5*PI*joint_diams[1]+ligament_thickness)*sin(ang),0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[1],joint_diams[2],bone_width,bone_type=inte,joint_type=jt,lig_ang=ang,pl=pulley_length,pt=pulley_thickness,pr=pulley_radius);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]-joint_diams[2]+(0.5*PI*joint_diams[2]+ligament_thickness)*cos(ang),-joint_diams[2]+ligament_thickness+0.2-(0.5*PI*joint_diams[2]+ligament_thickness)*sin(ang),0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[2],joint_diams[2],bone_width,bone_type=dist,joint_type=jt,lig_ang=ang,pl=pulley_length,pt=pulley_thickness,pr=pulley_radius);
                    }
                }
            }
        }
    }
}

//palm(17,20,58);
//palm module
//h -> palm height
//r1 -> longitudinal radius
//r2 -> lateral radius
module palm(h,r1,r2){
    union(){
        resize(newsize=[r1,r2,h]) cylinder(10,5,5);
        translate([-r1/2-10,-10,h/2-4]){
            difference(){
                cube([10+0.75*r1,20,8]);
                translate([4,4,-0.1])
                    cylinder(8.2,2,2);
                translate([4,16,-0.1])
                    cylinder(8.2,2,2);
            }
        }
    }
}