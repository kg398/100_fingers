include <primitives.scad>

//bone_lengths = [50,40,35,25];
//joint_diams = [12,10,8];

//finger(bl_index,jd_index,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_index);
//finger module
//bone_lengths -> length of each bone [meta,prox,inte,dist]
//joint_diams -> diameter of each joint [mcp,pip,dip]
//bone_width -> overall width
//jt -> joint types unused {0}->{default}
//ang -> ligament angle, use for printing bones in different orientations
//index -> enable extra pulley on index finger for thumb adduction
module finger(bone_lengths, joint_diams, bone_width=10, jt=0, ang=0, index=0, lig=[2.5, 0.6], pulley=[5,1.5,1]){
    rotate([0,0,ang]){
        union(){
            //metacarpal
            bone(bone_lengths[0],joint_diams[0],joint_diams[0],bone_width,bone_type=meta,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
            //relative translate from mcp geometry
            translate([bone_lengths[0]-joint_diams[0]+(0.5*PI*joint_diams[0]+lig[1])*cos(ang),-joint_diams[0]+lig[1]+0.2-(0.5*PI*joint_diams[0]+lig[1])*sin(ang),0]){
                //proximal
                bone(bone_lengths[1],joint_diams[0],joint_diams[1],bone_width,bone_type=prox,joint_type=1,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                //relative translate from pip geometry
                translate([bone_lengths[1]-joint_diams[1]+(0.5*PI*joint_diams[1]+lig[1])*cos(ang),-joint_diams[1]+lig[1]+0.2-(0.5*PI*joint_diams[1]+lig[1])*sin(ang),0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[1],joint_diams[2],bone_width,bone_type=inte,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]-joint_diams[2]+(0.5*PI*joint_diams[2]+lig[1])*cos(ang),-joint_diams[2]+lig[1]+0.2-(0.5*PI*joint_diams[2]+lig[1])*sin(ang),0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[2],0.8*joint_diams[2],bone_width,bone_type=dist,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                    }
                }
            }
            if(index!=0){
                //abd1
                translate([index,joint_diams[0]/2,bone_width/2]) rotate([90,0,0])
                    pulley(5,1,2,o_fillet=false,t_fillet=true);
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
module thumb(bone_lengths, joint_diams, bone_width=15, jt=0, ang=0, thumb=1, lig=[2.5, 0.6], pulley=[5,2.2,1]){
    rotate([0,0,ang]){
        union(){
            //carpal
            bone(bone_lengths[0],joint_diams[0],joint_diams[0],bone_width,bone_type=carp,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
            //relative translate from mcp geometry
            translate([bone_lengths[0]-joint_diams[0]+(0.5*PI*joint_diams[0]+lig[1])*cos(ang),-joint_diams[0]+lig[1]+0.2-(0.5*PI*joint_diams[0]+lig[1])*sin(ang),0]){
                //proximal
                difference(){
                    bone(bone_lengths[1],joint_diams[0],joint_diams[1],bone_width,bone_type=prox,joint_type=1,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                    if(thumb!=0){
                        translate([bone_lengths[1]/2+pulley[0]/2+0.5,joint_diams[0]/2,-bone_width/2]){ rotate([0,0,0])
                            cylinder(4.5,1,1);
                            chamfer(2,h=1);
                        }
                    }
                }
                if(thumb!=0){
                    //abd1
                    translate([bone_lengths[1]/2-pulley[0]/2,joint_diams[0]/2,-bone_width/2]) rotate([-90,0,0])
                        pulley(0.75*pulley[0],pulley[2],pulley[1],o_fillet=false,t_fillet=true);
                }
                //relative translate from pip geometry
                translate([bone_lengths[1]-joint_diams[1]+(0.5*PI*joint_diams[1]+lig[1])*cos(ang),-joint_diams[1]+lig[1]+0.2-(0.5*PI*joint_diams[1]+lig[1])*sin(ang),0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[1],joint_diams[2],bone_width,bone_type=inte,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]-joint_diams[2]+(0.5*PI*joint_diams[2]+lig[1])*cos(ang),-joint_diams[2]+lig[1]+0.2-(0.5*PI*joint_diams[2]+lig[1])*sin(ang),0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[2],joint_diams[2],bone_width,bone_type=dist,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
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

//finger_nolig(bone_lengths,joint_diams,ang=45,index=false);
//finger module
module finger_nolig(bone_lengths, joint_diams, bone_width=10, jt=0, ang=0, index=0, lig=[2.5,0.6], pulley=[5,1.5,1]){
    rotate([0,0,ang]){
        union(){
            //metacarpal
            bone(bone_lengths[0],joint_diams[0],joint_diams[0],bone_width,bone_type=meta,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2]);
            //relative translate from mcp geometry
            translate([bone_lengths[0]+lig[1],0,0]){
                //proximal
                bone(bone_lengths[1],joint_diams[0],joint_diams[1],bone_width,bone_type=prox,joint_type=1,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2],lig_type=1);
                //relative translate from pip geometry
                translate([bone_lengths[1]+lig[1],0,0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[1],joint_diams[2],bone_width,bone_type=inte,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2],lig_type=1);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]+lig[1],0,0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[2],0.8*joint_diams[2],bone_width,bone_type=dist,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2],lig_type=1);
                    }
                }
            }
            if(index!=0){
                //abd1
                translate([index,joint_diams[0]/2,bone_width/2]) rotate([90,0,0])
                    pulley(5,1,2,o_fillet=false,t_fillet=true);
            }
        }
    }
}

//thumb_nolig(bone_lengths,joint_diams,ang=0,index=true);
//thumb module
module thumb_nolig(bone_lengths, joint_diams, bone_width=15, jt=0, ang=0, thumb=1, lig=[2.5,0.6], pulley=[5,2.2,1]){
    rotate([0,0,ang]){
        union(){
            //carpal
            bone(bone_lengths[0],joint_diams[0],joint_diams[0],bone_width,bone_type=carp,joint_type=jt,lig_ang=ang,pl=pulley[0],pt=pulley[1],pr=pulley[2]);
            //relative translate from mcp geometry
            translate([bone_lengths[0]+lig[1],0,0]){
                //proximal
                difference(){
                    bone(bone_lengths[1],joint_diams[0],joint_diams[1],bone_width,bone_type=prox,joint_type=1,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2],lig_type=1);
                    if(thumb!=0){
                        translate([bone_lengths[1]/2+pulley[0]/2+2,joint_diams[0]/2,-bone_width/2]){ rotate([0,0,0])
                            cylinder(4.5,1,1);
                            chamfer(2);
                        }
                    }
                }
                if(thumb!=0){
                    //abd1
                    translate([bone_lengths[1]/2-pulley[0]/2,joint_diams[0]/2,-bone_width/2]) rotate([-90,0,0])
                        pulley(pulley[0],pulley[2],pulley[1],o_fillet=false,t_fillet=true);
                }
                //relative translate from pip geometry
                translate([bone_lengths[1]+lig[1],0,0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[1],joint_diams[2],bone_width,bone_type=inte,joint_type=jt,lig_ang=ang,pl=pulley[0],pt=pulley[1],pr=pulley[2],lig_type=1);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]+lig[1],0,0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[2],joint_diams[2],bone_width,bone_type=dist,joint_type=jt,lig_ang=ang,pl=pulley[0],pt=pulley[1],pr=pulley[2],lig_type=1);
                    }
                }
            }
        }
    }
}