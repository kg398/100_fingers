include <primitives.scad>

////Facet minimum scale
//$fs = 0.2;  // Don't generate smaller facets than 0.1 mm
////Angle maximum
//$fa = 5;    // Don't generate larger angles than 3 degrees

////Bone configurations
//[joint1 type, joint2 type, flexor pulley type, extensor pulley type, abd pulley type, fillet type, flexor anchor type, extensor anchor type, opposition anchor, opposition pulley]
//0
//joint 1 type:
//          0   -   base (flat)
//          1   -   1dof (hyp constrained)
//          2   -   2dof
//
//          4   -   base (modular)
//          5   -   base (modular negative)
//1
//joint 2 type:
//          0   -   none
//          1   -   1dof (hyp constrained)
//          2   -   2dof
//          3   -   tip (with nail) (joint 2 only)
//
//
//2
//flex pulley type
//          0   -   none
//          1   -   joint 1 only (not implemented)
//          2   -   joint 2 only
//          3   -   both joints
//3
//ext pulley type
//          0   -   none
//          1   -   joint 1 only
//          2   -   joint 2 only
//          3   -   both joints
//4
//abd pulley type
//          0   -   none
//          1   -   joint 1 only
//          2   -   joint 2 only
//          3   -   both joints
//5
//fillet type
//          0   -   none
//          1   -   extensor side fillet
//6
//flexor anchor type
//          0   -   none
//          1   -   joint 1 anchor
//          2   -   joint 2 anchor
//7
//extensor anchor type
//          0   -   none
//          1   -   joint 1 anchor
//          2   -   central anchor
//8
//ligament type
//          0   -   none
//          1   -   default
//9
//thumb opposition flag
//          0   -   false
//          1   -   true
//10
//opposition pulley
//          0   -   false
//          1   -   true
//assembly jig holes
//          0   -   false
//          1   -   meta-type (hole 15mm from tip)
//          2   -   prox-type (central hole)
//          3   -   inte-type (central hole offset)
//          4   -   dist-type (nail hole)



////Finger type configurations
//dof4:
dof4_config =              [[0,2,2,2,2,0,0,0,0,0,1,1],//metacarpal
                            [2,1,3,3,3,1,0,0,1,0,0,2],//proximal
                            [1,1,3,2,1,1,2,1,1,0,0,3],//intermediate
                            [1,3,0,0,0,0,1,1,1,0,0,4]];//distal
dof4_thumb_config =        [[0,2,2,2,2,0,0,0,0,0,0,1],//metacarpal
                            [2,1,3,3,3,1,0,0,1,1,0,2],//proximal
                            [1,1,3,2,1,1,2,1,1,0,0,3],//intermediate
                            [1,3,0,0,0,0,1,1,1,0,0,4]];//distal
dof3_config =              [[0,2,2,2,2,0,0,0,0,0,1,0],                
                            [2,1,3,2,1,1,0,1,1,0,0,0],
                            [1,3,0,0,0,0,1,1,1,0,0,0]];
dof3_thumb_config =        [[0,2,2,2,2,0,0,0,0,0,0,0],                
                            [2,1,3,2,1,1,0,1,1,1,0,0],
                            [1,3,0,0,0,0,1,1,1,0,0,0]];
dof2_config =              [[0,1,2,2,0,0,0,0,0,0,1,0],                
                            [1,1,3,2,0,0,0,1,1,0,0,0],
                            [1,3,0,0,0,0,1,1,1,0,0,0]];
dof2_thumb_config =        [[0,1,2,2,0,0,0,0,0,0,0,0],                
                            [1,1,3,2,0,0,0,1,1,1,0,0],
                            [1,3,0,0,0,0,1,1,1,0,0,0]];


//finger(type = 0,bl_list=[50,20,20,20],jd_list=[8,10,8,7,6],w_list=[10,12,10,9,8],lig=[2.5,0.6],p=[5,1,1.5],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side = 0);
//finger module
//type -> predefined finger type configuration id, see function bone_configs(type)
//bl_list -> list of bone lengths, size should match config
//jd_list -> diameter of each joint, size should match config+1
//w_list -> width of each joint, size should match config+1
//lig -> ligament params [width, thickness]
//p -> pulley params [length, radius, thickness]
//ang -> ligament angle, use for printing bones in different orientations
//thumb_adj -> dz for adjacent thumb opposition pulley
//thumb side -> thumb adjacent on left/right/both (0/1/2)
module finger(type,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    config_list = bone_configs(type);
    rotate([0,0,ang]){
        union()
            nested_bone(0,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
    }
}
// (private) recursive function for staggered bone offsets
module nested_bone(level,config_list,bl_list,jd_list,w_list,lig=[2.5,0.6],p=[5,1,1.5],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    mcp_ang=30;
    dr=(w_list[level]-w_list[level]*sin(acos((w_list[level]/2-lig[0])/w_list[level])))/jd_list[level];
    trans = level == 0 ? [0,0,0]:
                        config_list[level][0]==2 ? [bl_list[level-1]+(-1+(0.5+dr)*cos(mcp_ang))*jd_list[level]+sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*cos(ang),lig[1]+(-0.5-(0.5+dr)*sin(mcp_ang))*jd_list[level]-sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*sin(ang)-2*lig[1]*sin(ang)*sin(ang),0]:
                                            [bl_list[level-1]-jd_list[level]+(0.5*PI*jd_list[level]+lig[1])*cos(ang),-jd_list[level]+lig[1]+0.2-(0.5*PI*jd_list[level]+lig[1])*sin(ang),0];
    translate(trans){
        modular_bone(config_list[level],bl_list[level],[jd_list[level],jd_list[level+1]],[w_list[level],w_list[level+1]],lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        if(level<len(config_list)-1){
            nested_bone(level+1,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        }
    }
}
//load predefined bone configuration lists
function bone_configs(type) =
    type == 0 ? dof4_config:
    type == 1 ? dof4_thumb_config:
    type == 2 ? dof3_config:
    type == 3 ? dof3_thumb_config:
    type == 4 ? dof2_config:
    type == 5 ? dof2_thumb_config:0;

//palm(-36.5,17.5,2.5,10);
//palm module
//min_x -> furthest right finger/thumb coord 
//max_x -> furthest left finger/thumb coord 
//min_y -> closest on dorsal side coord
//max_y -> closest on palmar side coord
module palm(min_x,max_x,min_y,max_y){
    translate([0,min_y,(max_x+min_x)/2]) rotate([-90,0,0])
        union(){
            // palm-finger connection
            dz = 30;
            resize(newsize=[dz,max_x-min_x,max_y-min_y]) cylinder(10,5,5);
            // wrist interface
            translate([-dz/2-10,-10,(max_y-min_y)/2-4]){
                difference(){
                    cube([10+0.75*dz,20,8]);
                    translate([4,4,-0.1])
                        cylinder(8.2,2,2);
                    translate([4,16,-0.1])
                        cylinder(8.2,2,2);
                }
            }
        }
}

//finger module with no ligaments (only for visulaisation)
module finger_nolig(type,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    config_list = bone_configs(type);
    //turn off ligaments
    lig_filter_matrix = [for(i=[0:1:len(config_list[0])-1]) [for(j=[0:1:len(config_list[0])-1]) i==j && i!=8 ? 1:0]];
    config_list_nolig = config_list*lig_filter_matrix;
    rotate([0,0,ang]){
        union()
            nested_bone_nolig(0,config_list_nolig,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
    }
}
// (private) recursive function for staggered bone offsets with no ligaments
module nested_bone_nolig(level,config_list,bl_list,jd_list,w_list,lig=[2.5,0.6],p=[5,1,1.5],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    trans = level == 0 ? [0,0,0]:[bl_list[level-1]+lig[1],0,0];
    translate(trans){
        modular_bone(config_list[level],bl_list[level],[jd_list[level],jd_list[level+1]],[w_list[level],w_list[level+1]],lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        if(level<len(config_list)-1){
            nested_bone_nolig(level+1,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        }
    }
}

module finger_cut(negative,model,digit_id){
    bl = model==finger ? bl_finger[digit_id][0]:
         (model==thumb ? bl_thumb[digit_id][0]:0);
    jd = model==finger ? [jd_finger[digit_id][0],jd_finger[digit_id][1]]:
         (model==thumb ? [jd_thumb[digit_id][0],jd_thumb[digit_id][1]]:[0,0]);
    w = model==finger ? [w_finger[digit_id][0],w_finger[digit_id][1]]:
         (model==thumb ? [w_thumb[digit_id][0],w_thumb[digit_id][1]]:[0,0]);
    modular_finger_cut(negative,model,bl,jd,w,a_print);
}
module modular_finger_cut(negative,model,bl,jd,w,ang){
    if(negative==0){ //palm cutting geometry
        if(model==finger){ //load finger_id
            union(){
                difference(){
                    rotate([0,0,ang])
                        polyhedron(points=[[0,0,-w[0]/2],[0,0,w[0]/2],[0,jd[0],-w[0]/2],[0,jd[0],w[0]/2],[bl-jd[1]/2,0,-w[1]/2],[bl-jd[1]/2,0,w[1]/2],[bl-jd[1]/2-jd[1]*sin(10),jd[1]*cos(10),-w[1]/2],[bl-jd[1]/2-jd[1]*sin(10),jd[1]*cos(10),w[1]/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                    if(true){
                        rotate([0,0,ang-20]) translate([0,0,0])
                            cube([40,12,30],center=true);
                    }
                }
                rotate([0,0,ang-20]) translate([3,0,0]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
                rotate([0,0,ang-20]) translate([12,0,0]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
                rotate([0,0,ang-20]) translate([3,-3,0]) rotate([90,0,0])
                    cylinder(10,3,3,center=true);
                rotate([0,0,ang-20]) translate([12,0.25,0]) rotate([90,0,0])
                    cylinder(10,3,3,center=true);
            }
        }else if(model==thumb){ //load thumb_id
            union(){
                difference(){
                    off = p_thumb[0][1]+1.5*p_thumb[0][2];
                    rotate([0,0,ang])
                        polyhedron(points=[[0,0,-w[0]/2],[0,0,w[0]/2],[0,jd[0]+off,-w[0]/2],[0,jd[0]+off,w[0]/2],[bl-jd[1]/2,0,-w[1]/2],[bl-jd[1]/2,0,w[1]/2],[bl-jd[1]/2-jd[1]*sin(10),jd[1]*cos(10)+off,-w[1]/2],[bl-jd[1]/2-jd[1]*sin(10),jd[1]*cos(10)+off,w[1]/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                    if(true){
                        rotate([0,0,ang-33]) translate([0,0,0])
                            cube([19,12,30],center=true);
                    }
                }
                rotate([0,0,ang-33]) translate([3,6,3.2]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
                rotate([0,0,ang-33]) translate([3,6,-3.2]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
                rotate([0,0,ang-33]) translate([3,1.25,3.2]) translate([0,-3.75,0]) rotate([90,0,0])
                    cylinder(12,3,3,center=true);
                rotate([0,0,ang-33]) translate([3,1.25,-3.2]) translate([0,-3.75,0]) rotate([90,0,0])
                    cylinder(12,3,3,center=true);
            }
        }
    }else if(negative==1){ //palm mounting geometry
        if(model==finger){
            intersection(){
                config_list = [[for(i=[0:1:len(dof4_config)-1]) 0]];
                rotate([0,0,ang])
                    nested_bone(0,config_list,[bl],jd,w);
                rotate([0,0,ang-20]) translate([0,0,0])
                    cube([40,12,30],center=true);
            }
        }else if(model==thumb){
            intersection(){
                config_list = [[for(i=[0:1:len(dof4_config)-1]) 0]];
                rotate([0,0,ang])
                    nested_bone(0,config_list,[bl],jd,w);
                rotate([0,0,ang-33]) translate([0,0,0])
                    cube([19,12,30],center=true);
            }
        }
    }else if(negative==2){ //modular finger cutting geometry
        if(model==finger){ //load finger_id
            union(){
                rotate([0,0,ang-20]) translate([0,0,0])
                    cube([40,12,30],center=true);
                rotate([0,0,ang-20]) translate([3,0,0]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
                rotate([0,0,ang-20]) translate([12,0,0]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
            }
        }else if(model==thumb){ //load thumb_id
            union(){
                rotate([0,0,ang-33]) translate([0,0,0])
                    cube([19,12,30],center=true);
                rotate([0,0,ang-33]) translate([3,6,3.2]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
                rotate([0,0,ang-33]) translate([3,6,-3.2]) rotate([90,0,0])
                    cylinder(40,1.5,1.5,center=true);
            }
        }
    }
}


////finger negative model for making cuts
//module finger_negative(negative_type,type,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
//    config_list = bone_configs(type);
//    if(negative_type==0){
//        filter_matrix = [for(i=[0:1:len(config_list[0])-1]) [for(j=[0:1:len(config_list[0])-1]) i==j && i==0 ? 1:0]];
//        config_list_negative = [config_list[0]*filter_matrix];
//        rotate([0,0,ang]){
//            union()
//                nested_bone(0,config_list_negative,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
//        }
//    }
//}
//// (private) recursive function for staggered bone offsets
//module nested_bone(level,config_list,bl_list,jd_list,w_list,lig=[2.5,0.6],p=[5,1,1.5],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
//    mcp_ang=30;
//    dr=(w_list[level]-w_list[level]*sin(acos((w_list[level]/2-lig[0])/w_list[level])))/jd_list[level];
//    trans = level == 0 ? [0,0,0]:
//                        config_list[level][0]==2 ? [bl_list[level-1]+(-1+(0.5+dr)*cos(mcp_ang))*jd_list[level]+sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*cos(ang),lig[1]+(-0.5-(0.5+dr)*sin(mcp_ang))*jd_list[level]-sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*sin(ang)-2*lig[1]*sin(ang)*sin(ang),0]:
//                                            [bl_list[level-1]-jd_list[level]+(0.5*PI*jd_list[level]+lig[1])*cos(ang),-jd_list[level]+lig[1]+0.2-(0.5*PI*jd_list[level]+lig[1])*sin(ang),0];
//    translate(trans){
//        modular_bone(config_list[level],bl_list[level],[jd_list[level],jd_list[level+1]],[w_list[level],w_list[level+1]],lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
//        if(level<len(config_list)-1){
//            nested_bone(level+1,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
//        }
//    }
//}