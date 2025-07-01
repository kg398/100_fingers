include <primitives.scad>

////Facet minimum scale
//$fs = 0.2;  // Don't generate smaller facets than 0.1 mm
////Angle maximum
//$fa = 5;    // Don't generate larger angles than 3 degrees

////Ligament width and thickness
//lig_index = [2.5,0.6];
////Finger pulley length, thickness and radius
//p_index = [5,1.5,1];
////Print angle/hand inward curvature
//print_ang = 45;
////Index bone lengths
//bl_index = [80,	38, 20,	20];
////Index joint diameters
//base_jd_index = 12.5;
//jd_index = [base_jd_index*0.7,    base_jd_index,	base_jd_index*0.6,	base_jd_index*0.5];
////Index width
//base_w_index = 15;
//w_index = [base_w_index*0.7,base_w_index,base_w_index*0.8,base_w_index*0.7,base_w_index*0.7];

//finger(bl_index,jd_index,ang=print_ang,thumb=1,lig=lig_index,pulley=p_index,bone_width=w_index);
//finger module
//bone_lengths -> length of each bone [meta,prox,inte,dist]
//joint_diams -> diameter of each joint [mcp,pip,dip]
//bone_width -> overall width
//jt -> joint types unused {0}->{default}
//ang -> ligament angle, use for printing bones in different orientations
//index -> enable extra pulley on index finger for thumb adduction
module finger(bone_lengths, joint_diams, bone_width=[10,10,10,10,10], jt=0, ang=0, thumb=0, index=0, lig=[2.5, 0.6], pulley=[5,1.5,1]){
    rotate([0,0,ang]){
        union(){
            //metacarpal
            if(thumb==0){
                bone(bone_lengths[0],joint_diams[0],joint_diams[1],bone_width[0],w2=bone_width[1],bone_type=meta,joint_type=2,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
            }else{
                bone(bone_lengths[0],joint_diams[0],joint_diams[1],bone_width[0],w2=bone_width[1],bone_type=carp,joint_type=2,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
            }
            //relative translate from mcp geometry
            //translate([bone_lengths[0]-joint_diams[1]+(0.5*PI*joint_diams[1]+lig[1]-0.6)*cos(ang),-joint_diams[1]+lig[1]+0.2-(0.5*PI*joint_diams[1]+lig[1]-0.6)*sin(ang),0]){
            mcp_ang=30;
            dr=(bone_width[1]-bone_width[1]*sin(acos((bone_width[1]/2-lig[0])/bone_width[1])))/joint_diams[1];
            translate([bone_lengths[0]+(-1+(0.5+dr)*cos(mcp_ang))*joint_diams[1]+sqrt((0.5*joint_diams[1]*(1+(1+dr)*sin(mcp_ang)))^2+(joint_diams[1]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*cos(ang),lig[1]+(-0.5-(0.5+dr)*sin(mcp_ang))*joint_diams[1]-sqrt((0.5*joint_diams[1]*(1+(1+dr)*sin(mcp_ang)))^2+(joint_diams[1]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*sin(ang)-2*lig[1]*sin(ang)*sin(ang),0]){
                //proximal
                difference(){
                    bone(bone_lengths[1],joint_diams[1],joint_diams[2],bone_width[1],w2=bone_width[2],bone_type=prox,joint_type=2,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                    if(thumb!=0){
                        translate([bone_lengths[1]/2+pulley[0]/2+0.5,(joint_diams[1]+joint_diams[1])/4,-(bone_width[1]+bone_width[2])/4]){ rotate([0,0,0])
                            cylinder(4.5,1,1);
                            chamfer(2,h=1);
                        }
                    }
                }
                if(thumb!=0){
                    //abd1
                    translate([bone_lengths[1]/2-pulley[0]/2,(joint_diams[1]+joint_diams[1])/4,-(bone_width[1]+bone_width[2])/4]) rotate([-90,0,0])
                        pulley(0.75*pulley[0],pulley[2],pulley[1],o_fillet=false,t_fillet=true);
                }
                //relative translate from pip geometry
                translate([bone_lengths[1]-joint_diams[2]+(0.5*PI*joint_diams[2]+lig[1])*cos(ang),-joint_diams[2]+lig[1]+0.2-(0.5*PI*joint_diams[2]+lig[1])*sin(ang),0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[2],joint_diams[3],bone_width[2],w2=bone_width[3],bone_type=inte,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]-joint_diams[3]+(0.5*PI*joint_diams[3]+lig[1])*cos(ang),-joint_diams[3]+lig[1]+0.2-(0.5*PI*joint_diams[3]+lig[1])*sin(ang),0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[3],0.8*joint_diams[3],bone_width[3],w2=bone_width[4],bone_type=dist,joint_type=jt,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
                    }
                }
            }
            if(index!=0){
                //abd1
                translate([index,joint_diams[1]/2,(bone_width[0]+bone_width[1])/4]) rotate([90,0,0])
                    pulley(5,1,2,o_fillet=false,t_fillet=true);
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
module finger_nolig(bone_lengths, joint_diams, bone_width=[10,10,10,10,10], jt=0, ang=0, thumb=0, index=0, lig=[2.5,0.6], pulley=[5,1.5,1]){
    rotate([0,0,ang]){
        union(){
            //metacarpal
            if(thumb==0){
                bone(bone_lengths[0],joint_diams[0],joint_diams[1],bone_width[0],w2=bone_width[1],bone_type=meta,joint_type=2,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
            }else{
                bone(bone_lengths[0],joint_diams[0],joint_diams[1],bone_width[0],w2=bone_width[1],bone_type=carp,joint_type=2,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2]);
            }
            //relative translate from mcp geometry
            translate([bone_lengths[0]+lig[1],0,0]){
                //proximal
                difference(){
                    bone(bone_lengths[1],joint_diams[1],joint_diams[2],bone_width[1],w2=bone_width[2],bone_type=prox,joint_type=2,lig_ang=ang,lw=lig[0],lt=lig[1],pl=pulley[0],pt=pulley[1],pr=pulley[2],lig_type=1);
                    if(thumb!=0){
                        translate([bone_lengths[1]/2+pulley[0]/2+0.5,(joint_diams[1]+joint_diams[1])/4,-(bone_width[1]+bone_width[2])/4]){ rotate([0,0,0])
                            cylinder(4.5,1,1);
                            chamfer(2,h=1);
                        }
                    }
                }
                if(thumb!=0){
                    //abd1
                    translate([bone_lengths[1]/2-pulley[0]/2,(joint_diams[1]+joint_diams[1])/4,-(bone_width[1]+bone_width[2])/4]) rotate([-90,0,0])
                        pulley(0.75*pulley[0],pulley[2],pulley[1],o_fillet=false,t_fillet=true);
                }
                //relative translate from pip geometry
                translate([bone_lengths[1]+lig[1],0,0]){
                    //intemediate
                    bone(bone_lengths[2],joint_diams[2],joint_diams[3],bone_width[2],w2=bone_width[3],bone_type=inte,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2],lig_type=1);
                    //relative translate from dip geometry
                    translate([bone_lengths[2]+lig[1],0,0]){
                        //distal
                        bone(bone_lengths[3],joint_diams[3],0.8*joint_diams[3],bone_width[3],w2=bone_width[4],bone_type=dist,joint_type=jt,lig_ang=ang,pl=pulley[0], pt=pulley[1], pr=pulley[2],lig_type=1);
                    }
                }
            }
            if(index!=0){
                //abd1
                translate([index,joint_diams[1]/2,(bone_width[1]+bone_width[2])/4]) rotate([90,0,0])
                    pulley(5,1,2,o_fillet=false,t_fillet=true);
            }
        }
    }
}