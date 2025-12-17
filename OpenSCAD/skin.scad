include <parameters.scad>



//meta = 0;
//prox = 1;
//inte = 2;
//dist = 3;
//carp = 4;
//
////2
////flex pulley type
////          0   -   none
////          1   -   joint 1 only (not implemented)
////          2   -   joint 2 only
////          3   -   both joints
////3
////ext pulley type
////          0   -   none
////          1   -   joint 1 only
////          2   -   joint 2 only
////          3   -   both joints
////4
////abd pulley type
////          0   -   none
////          1   -   joint 1 only
////          2   -   joint 2 only
////          3   -   both joints
//
////10
////opposition pulley
////          0   -   false
////          1   -   true
//dof4_config =              [[0,2,2,2,2,0,0,0,0,0,1],//metacarpal
//                            [2,1,3,3,3,1,0,0,1,0,0],//proximal
//                            [1,1,3,2,1,1,2,1,1,0,0],//intermediate
//                            [1,3,0,0,0,0,1,1,1,0,0]];//distal
//dof4_thumb_config =        [[0,2,2,2,2,0,0,0,0,0,0],//metacarpal
//                            [2,1,3,3,3,1,0,0,1,1,0],//proximal
//                            [1,1,3,2,1,1,2,1,1,0,0],//intermediate
//                            [1,3,0,0,0,0,1,1,1,0,0]];//distal
//
//config = dof4_thumb_config[1];
////tendon_negative(config,70,[10,10],[10,10],[5,1.5,1]);
//bone_skin(config,70,[10,10],[10,10],[2.5,0.6],[5,1.5,1],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=1);

//skin_hand_pads();
//hand_skin();
//hand();
palm = 0;
finger = 1;
thumb = 2;
all = 3;
param1=1; //palm/digit type
param2=0; //digit id
param3=1; //0 for skeleton, 1 for skin
////openscad.com -o "palm_skel_test.stl" -D "param1=0" -D "param2=0" -D "param3=0" skin.scad && 
////openscad.com -o "fingeri_skel_test.stl" -D "param1=1" -D "param2=i" -D "param3=0" skin.scad &&
////openscad.com -o "thumbi_skel_test.stl" -D "param1=2" -D "param2=i" -D "param3=0" skin.scad &&
////openscad.com -o "palm_skin_test.stl" -D "param1=0" -D "param2=0" -D "param3=1" skin.scad && 
////openscad.com -o "fingeri_skin_test.stl" -D "param1=1" -D "param2=i" -D "param3=1" skin.scad &&
////openscad.com -o "thumbi_skin_test.stl" -D "param1=2" -D "param2=i" -D "param3=1" skin.scad &&
hand_modular_skin(param1,param2,param3);
#hand_modular_skin(param1,param2,0);

module hand_modular_skin(model=all,digit_id=0,skin=1){
    echo(model);
    union(){
        //Palm
        if(model==palm || model==all){
            //scale to max width (both thumbs if they exist, or first/last finger)
            y_mask = [[0],
                      [1],
                      [0]];
            base_mask = [[1],
                      [0],
                      [0],
                      [0],
                      [0]];
            min_x = n_thumbs>1 ? o_thumb[1][2]:o_finger[n_fingers-1][2];
            max_x = n_thumbs>0 ? o_thumb[0][2]:o_finger[0][2];
            min_y = n_thumbs>0 && n_fingers>0 ? max(max(o_finger*y_mask)[0],max(o_thumb*y_mask)[0]-5):
                                       (n_thumbs>0 ? max(o_thumb*y_mask)[0]-5:max(o_finger*y_mask)[0]);
            max_y = n_thumbs>0 && n_fingers>0 ? 1+min(min(jd_finger*base_mask+o_finger*y_mask)[0],min(jd_thumb*base_mask+o_thumb*y_mask)[0]):
                                        (n_thumbs>0 ? 1+min(jd_thumb*base_mask+o_thumb*y_mask)[0]:1+min(jd_finger*base_mask+o_finger*y_mask)[0]);
            if(skin==0){
                difference(){
                    union(){ //base palm
                        palm_skin(min_x-2.5,max_x+2.5,min_y,max_y);  
                        //metacarpal mounts
                        for(i=[0:1:n_fingers-1]){
                            translate(o_finger[i]) rotate([0,0,-a_print]) rotate(a_finger[i])
                                finger_cut(1,1,i);
                        }
                        for(i=[0:1:n_thumbs-1]){
                            translate(o_thumb[i]) rotate([0,0,-a_print]) rotate(a_thumb[i])
                                finger_cut(1,2,i);
                        }  
                    }
                    //{ //subtract metacarpals
                    for(i=[0:1:n_fingers-1]){
                        translate(o_finger[i]) rotate([0,0,-a_print]) rotate(a_finger[i])
                            finger_cut(0,1,i);
                    }
                    for(i=[0:1:n_thumbs-1]){
                        translate(o_thumb[i]) rotate([0,0,-a_print]) rotate(a_thumb[i])
                            finger_cut(0,2,i);
                    }
                }
            }else{
                difference(){
                    skin_palm_pad(min_x-2.5,max_x+2.5,min_y,max_y);
                    palm_skin(min_x-2.5,max_x+2.5,min_y,max_y);
                    for(i=[0:1:n_fingers-1]){
                        translate(o_finger[i]) rotate([0,0,-a_print]) rotate(a_finger[i]) rotate([0,0,a_print]){
//                            echo([w_finger[i]]);
                            nested_bone(0,[[for(j=[0:1:len(dof4_config[0])-1]) 0]],bl_finger[i],jd_finger[i],w_finger[i]);
                            }
                    }
                    for(i=[0:1:n_thumbs-1]){
                        translate(o_thumb[i]) rotate([0,0,-a_print]) rotate(a_thumb[i]) rotate([0,0,a_print]){
                            nested_bone(0,[[for(j=[0:1:len(dof4_config[0])-1]) 0]],bl_thumb[i],jd_thumb[i],w_thumb[i]);
                        }
                    } 
                }
            }
        }
        //Finger
        if(model==finger){
            translate(o_finger[digit_id]) rotate([0,0,-a_print]) rotate(a_finger[digit_id]){
                lig = digit_id<len(lig_finger)?lig_finger[digit_id]:lig_finger[0];
                p = digit_id<len(p_finger)?p_finger[digit_id]:p_finger[0];
                //if adjacent to a thumb, include opposition pulley location info
                dz1 = digit_id==0 && n_thumbs>0 ? 
                            (bl_thumb[0][0]+jd_thumb[0][0]-p[0]>bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2 ? bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2.5 : bl_thumb[0][0]+jd_thumb[0][0]-p[0]):
                            0;
                dz2 = digit_id==n_fingers-1 && n_thumbs>1 ? 
                            (bl_thumb[1][0]+jd_thumb[1][0]-p[0]>bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2 ? bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2.5 : bl_thumb[1][0]+jd_thumb[1][0]-p[0]):
                            0;
                if(skin==0){
                    difference(){
                        finger_skin(type_finger[digit_id],
                               bl_finger[digit_id],
                               jd_finger[digit_id],
                               w_finger[digit_id],
                               lig,
                               p,
                               a_print,
                               thumb_adj1=dz1,
                               thumb_adj2=dz2,
                               thumb_side = n_fingers==1? 2:digit_id==0?0:1);
                        finger_cut(2,finger,digit_id);
                    }
                }else{
                    skin_finger_pads(type_finger[digit_id],
                           bl_finger[digit_id],
                           jd_finger[digit_id],
                           w_finger[digit_id],
                           lig,
                           p,
                           a_print,
                           thumb_adj1=dz1,
                           thumb_adj2=dz2,
                           thumb_side = n_fingers==1? 2:digit_id==0?0:1);
                }
            }
        }
        //Thumb
        if(model==thumb){
            translate(o_thumb[digit_id]) rotate([0,0,-a_print]) rotate(a_thumb[digit_id]){
                lig = digit_id<len(lig_thumb)?lig_thumb[digit_id]:lig_thumb[0];
                p = digit_id<len(p_thumb)?p_thumb[digit_id]:p_thumb[0];
                //thumb reuses finger module with its own configuration defined by type
                if(skin==0){
                    difference(){
                        finger_skin(type_thumb[digit_id],
                                   bl_thumb[digit_id],
                                   jd_thumb[digit_id],
                                   w_thumb[digit_id],
                                   lig,
                                   p,
                                   a_print,
                                   thumb_side=digit_id);
                        finger_cut(2,thumb,digit_id);
                    }
                }else{
                    skin_finger_pads(type_thumb[digit_id],
                               bl_thumb[digit_id],
                               jd_thumb[digit_id],
                               w_thumb[digit_id],
                               lig,
                               p,
                               a_print,
                               thumb_side=digit_id); 
                }
            }
        }
        //All
        if(model==all){
            echo("test");
            union(){
                for(i=[0:1:n_fingers-1])
                    hand_modular_skin(finger,i,skin);
                for(i=[0:1:n_thumbs-1])
                    hand_modular_skin(thumb,i,skin);
            }
        }
    }
}

module skin_hand_pads(){
    union(){
        // Fingers
        for(i=[0:1:n_fingers-1]){
            //if setting gloabl finger/thumb ligament/pulley params
            lig = i<len(lig_finger)?lig_finger[i]:lig_finger[0];
            p = i<len(p_finger)?p_finger[i]:p_finger[0];
            //if adjacent to a thumb, include opposition pulley location info
            dz1 = i==0 && n_thumbs>0 ? 
                        (bl_thumb[0][0]+jd_thumb[0][0]-p[0]>bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2 ? bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2.5 : bl_thumb[0][0]+jd_thumb[0][0]-p[0]):
                        0;
            dz2 = i==n_fingers-1 && n_thumbs>1 ? 
                        (bl_thumb[1][0]+jd_thumb[1][0]-p[0]>bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2 ? bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2.5 : bl_thumb[1][0]+jd_thumb[1][0]-p[0]):
                        0;
            //generate finger from parameters and configuration given by type (see digits.scad/bone_config(type))
            translate(o_finger[i]) rotate([0,0,-a_print]) rotate(a_finger[i])
                skin_finger_pads(type_finger[i],
                       bl_finger[i],
                       jd_finger[i],
                       w_finger[i],
                       lig,
                       p,
                       a_print,
                       thumb_adj1=dz1,
                       thumb_adj2=dz2,
                       thumb_side = n_fingers==1? 2:i==0?0:1);
        }
        // Thumbs
        for(i=[0:1:n_thumbs-1]){
            //if setting gloabl finger/thumb ligament/pulley params
            lig = i<len(lig_thumb)?lig_thumb[i]:lig_thumb[0];
            p = i<len(p_thumb)?p_thumb[i]:p_thumb[0];
            //thumb reuses finger module with its own configuration defined by type
            translate(o_thumb[i]) rotate([0,0,-a_print]) rotate(a_thumb[i])
                skin_finger_pads(type_thumb[i],
                       bl_thumb[i],
                       jd_thumb[i],
                       w_thumb[i],
                       lig,
                       p,
                       a_print,
                       thumb_side=i);
        }
        // Palm
        {
        //scale to max width (both thumbs if they exist, or first/last finger)
        y_mask = [[0],
                  [1],
                  [0]];
        base_mask = [[1],
                  [0],
                  [0],
                  [0],
                  [0]];
        min_x = n_thumbs>1 ? o_thumb[1][2]:o_finger[n_fingers-1][2];
        max_x = n_thumbs>0 ? o_thumb[0][2]:o_finger[0][2];
        min_y = n_thumbs>0 && n_fingers>0 ? max(max(o_finger*y_mask)[0],max(o_thumb*y_mask)[0]-5):
                                   (n_thumbs>0 ? max(o_thumb*y_mask)[0]-5:max(o_finger*y_mask)[0]);
        max_y = n_thumbs>0 && n_fingers>0 ? 1+min(min(jd_finger*base_mask+o_finger*y_mask)[0],min(jd_thumb*base_mask+o_thumb*y_mask)[0]):
                                    (n_thumbs>0 ? 1+min(jd_thumb*base_mask+o_thumb*y_mask)[0]:1+min(jd_finger*base_mask+o_finger*y_mask)[0]);
        palm(min_x-2.5,max_x+2.5,min_y,max_y);                
        }
    }
}

module skin_finger_pads(type,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    config_list = bone_configs(type);
    rotate([0,0,ang]){
        union()
            nested_skin_pads(0,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
    }
}
// (private) recursive function for staggered bone offsets
module nested_skin_pads(level,config_list,bl_list,jd_list,w_list,lig=[2.5,0.6],p=[5,1,1.5],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    mcp_ang=30;
    dr=(w_list[level]-w_list[level]*sin(acos((w_list[level]/2-lig[0])/w_list[level])))/jd_list[level];
    trans = level == 0 ? [0,0,0]:
                        config_list[level][0]==2 ? [bl_list[level-1]+(-1+(0.5+dr)*cos(mcp_ang))*jd_list[level]+sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*cos(ang),lig[1]+(-0.5-(0.5+dr)*sin(mcp_ang))*jd_list[level]-sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*sin(ang)-2*lig[1]*sin(ang)*sin(ang),0]:
                                            [bl_list[level-1]-jd_list[level]+(0.5*PI*jd_list[level]+lig[1])*cos(ang),-jd_list[level]+lig[1]+0.2-(0.5*PI*jd_list[level]+lig[1])*sin(ang),0];
    translate(trans){
        skin_pad(config_list[level],bl_list[level],[jd_list[level],jd_list[level+1]],[w_list[level],w_list[level+1]],lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        if(level<len(config_list)-1){
            nested_skin_pads(level+1,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        }
    }
}

module hand_skin(){
    union(){
        // Fingers
        for(i=[0:1:n_fingers-1]){
            //if setting gloabl finger/thumb ligament/pulley params
            lig = i<len(lig_finger)?lig_finger[i]:lig_finger[0];
            p = i<len(p_finger)?p_finger[i]:p_finger[0];
            //if adjacent to a thumb, include opposition pulley location info
            dz1 = i==0 && n_thumbs>0 ? 
                        (bl_thumb[0][0]+jd_thumb[0][0]-p[0]>bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2 ? bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2.5 : bl_thumb[0][0]+jd_thumb[0][0]-p[0]):
                        0;
            dz2 = i==n_fingers-1 && n_thumbs>1 ? 
                        (bl_thumb[1][0]+jd_thumb[1][0]-p[0]>bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2 ? bl_finger[i][0]-jd_finger[i][1]/2-p[0]*2.5 : bl_thumb[1][0]+jd_thumb[1][0]-p[0]):
                        0;
            //generate finger from parameters and configuration given by type (see digits.scad/bone_config(type))
            translate(o_finger[i]) rotate([0,0,-a_print]) rotate(a_finger[i])
                finger_skin(type_finger[i],
                       bl_finger[i],
                       jd_finger[i],
                       w_finger[i],
                       lig,
                       p,
                       a_print,
                       thumb_adj1=dz1,
                       thumb_adj2=dz2,
                       thumb_side = n_fingers==1? 2:i==0?0:1);
        }
        // Thumbs
        for(i=[0:1:n_thumbs-1]){
            //if setting gloabl finger/thumb ligament/pulley params
            lig = i<len(lig_thumb)?lig_thumb[i]:lig_thumb[0];
            p = i<len(p_thumb)?p_thumb[i]:p_thumb[0];
            //thumb reuses finger module with its own configuration defined by type
            translate(o_thumb[i]) rotate([0,0,-a_print]) rotate(a_thumb[i])
                finger_skin(type_thumb[i],
                       bl_thumb[i],
                       jd_thumb[i],
                       w_thumb[i],
                       lig,
                       p,
                       a_print,
                       thumb_side=i);
        }
        // Palm
        {
        //scale to max width (both thumbs if they exist, or first/last finger)
        y_mask = [[0],
                  [1],
                  [0]];
        base_mask = [[1],
                  [0],
                  [0],
                  [0],
                  [0]];
        min_x = n_thumbs>1 ? o_thumb[1][2]:o_finger[n_fingers-1][2];
        max_x = n_thumbs>0 ? o_thumb[0][2]:o_finger[0][2];
        min_y = n_thumbs>0 && n_fingers>0 ? max(max(o_finger*y_mask)[0],max(o_thumb*y_mask)[0]-5):
                                   (n_thumbs>0 ? max(o_thumb*y_mask)[0]-5:max(o_finger*y_mask)[0]);
        max_y = n_thumbs>0 && n_fingers>0 ? 1+min(min(jd_finger*base_mask+o_finger*y_mask)[0],min(jd_thumb*base_mask+o_thumb*y_mask)[0]):
                                    (n_thumbs>0 ? 1+min(jd_thumb*base_mask+o_thumb*y_mask)[0]:1+min(jd_finger*base_mask+o_finger*y_mask)[0]);
        palm_skin(min_x-2.5,max_x+2.5,min_y,max_y);                
        }
    }
}

module palm_skin(min_x,max_x,min_y,max_y){
    dz = 30;
    difference(){
        translate([0,min_y,(max_x+min_x)/2]) rotate([-90,0,0]){
            union(){
                // palm-finger connection
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
        //skin mechanical interface
        if((max_y-min_y)<10){
            translate([-0.125*dz,(max_y-9)-0.1,max_x-0.75*(max_x-min_x)]) rotate([-90,0,0])
                cylinder(10+0.2,2,2);
            translate([-0.125*dz,(max_y-9)-0.1,min_x+0.1*(max_x-min_x)]) rotate([-90,0,0])
                cylinder(10+0.2,2,2);
        }else{
            translate([-0.125*dz,min_y-1-0.1,max_x-0.25*(max_x-min_x)]) rotate([-90,0,0])
                cylinder(max_y-min_y+2.2,2,2);
            translate([-0.125*dz,min_y-1-0.1,min_x+0.25*(max_x-min_x)]) rotate([-90,0,0])
                cylinder(max_y-min_y+2.2,2,2);
        }
    }
}

module skin_palm_pad(min_x,max_x,min_y,max_y){
    dz=30;
    difference(){
        translate([0.125*dz,min_y+1*(max_y-min_y),-0.25*(max_x-min_x)+0.5*(max_x+min_x)])
            resize([1.25*dz,3.5*(max_y-min_y),0.7*(max_x-min_x)]) sphere(1.25*dz);
        palm_skin(min_x,max_x,min_y,max_y);
    }
}

module finger_skin(type,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    config_list = bone_configs(type);
    rotate([0,0,ang]){
        union()
            nested_bone_skin(0,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
    }
}
// (private) recursive function for staggered bone offsets
module nested_bone_skin(level,config_list,bl_list,jd_list,w_list,lig=[2.5,0.6],p=[5,1,1.5],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    mcp_ang=30;
    dr=(w_list[level]-w_list[level]*sin(acos((w_list[level]/2-lig[0])/w_list[level])))/jd_list[level];
    trans = level == 0 ? [0,0,0]:
                        config_list[level][0]==2 ? [bl_list[level-1]+(-1+(0.5+dr)*cos(mcp_ang))*jd_list[level]+sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*cos(ang),lig[1]+(-0.5-(0.5+dr)*sin(mcp_ang))*jd_list[level]-sqrt((0.5*jd_list[level]*(1+(1+dr)*sin(mcp_ang)))^2+(jd_list[level]*(1-(0.5+dr/2)*cos(mcp_ang)))^2)*sin(ang)-2*lig[1]*sin(ang)*sin(ang),0]:
                                            [bl_list[level-1]-jd_list[level]+(0.5*PI*jd_list[level]+lig[1])*cos(ang),-jd_list[level]+lig[1]+0.2-(0.5*PI*jd_list[level]+lig[1])*sin(ang),0];
    translate(trans){
        modular_bone_skin(config_list[level],bl_list[level],[jd_list[level],jd_list[level+1]],[w_list[level],w_list[level+1]],lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        if(level<len(config_list)-1){
            nested_bone_skin(level+1,config_list,bl_list,jd_list,w_list,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        }
    }
}

module modular_bone_skin(config,bl,jd,w,lig=[2.5,0.6],p=[5,1.5,1],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    difference(){
        modular_bone(config,bl,jd,w,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        mech_negative(config,bl,jd,w,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
    }
}

module skin_pad(config,bl,jd,w,lig=[2.5,0.6],p=[5,1.5,1],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    difference(){
        //----------------------------soft pad---------------------------------//
        if(config[0]==0 && config[1]==2){ //metacarpal
            if(bl-(jd[0]+jd[1])/2<1.5*jd[1]){
                translate([(bl+(jd[0]-jd[1])/2)/2,(jd[0]+jd[1])/4,0])
                    resize([bl-(jd[0]+jd[1])/2,1*(jd[0]+jd[1]),0.75*(w[0]+w[1])]) sphere(d=jd[0]);
            }else{
                translate([bl-1.25*jd[1],0,0]) rotate([0, 0, 10]) translate([0,jd[1]/2,0])
                    resize([1.5*jd[1],1.5*jd[1],1.5*w[1]]) sphere(d=jd[0]);
            }
        }else if((config[0]==2 && config[1]==1)||(config[0]==1 && config[1]==1)){ //proximal or intermediate
            translate([(bl+(jd[0]-jd[1])/2)/2,(jd[0]+jd[1])/4,0])
                resize([(bl-(jd[0]+jd[1])/2),1*(jd[0]+jd[1]),0.75*(w[0]+w[1])]) sphere(d=jd[0]);
        }else if(config[0]==1 && config[1]==3){
            translate([(bl+(jd[0]+jd[1])/2)/2,(jd[0]+jd[1])/4,0])
                resize([(bl-(jd[0]-jd[1])/2),1*(jd[0]+jd[1]),0.75*(w[0]+w[1])]) sphere(d=jd[0]);
        }
        difference(){
            //----------------------bone negative------------------------------//
            bone_negative(config,bl,jd,w,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
            //------------bone positive (mechanical interface)-----------------//
            mech_negative(config,bl,jd,w,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        }
        //-------------------------tendon clearance----------------------------//
        tendon_negative(config,bl,jd,w,p);
    }
}

module bone_negative(config,bl,jd,w,lig=[2.5,0.6],p=[5,1.5,1],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    //flexor pulley offsets defined by stability criteria (Gilday 2025)
    f1=0.5*1;
    f2=0.5*0.5;
    //pulley settings
    of=false;
    //turn off pulleys, ligaments, anchors
    pulley_filter_matrix = [for(i=[0:1:len(config)-1]) [for(j=[0:1:len(config)-1]) i==j && (i!=2 && i!=3 && i!=4 && i!=6 && i!=7 && i!=8 && i!=9 && i!=10 && i!=11) ? 1:0]];
    config_nop = config*pulley_filter_matrix;
    union(){
        //reuse modular_bone with switched off parts
        modular_bone(config_nop,bl,jd,w,lig,p,ang,thumb_adj1,thumb_adj2,thumb_side);
        //----------------------------------pulleys-----------------------//
        //flexors
        if(config[2]==1){ //empty
            
        }else if(config[2]==2){ //only joint 2
            translate([0,jd[0],0]) rotate([0,0,-atan2(jd[0]-jd[1],bl-jd[1]/2)]) translate([bl-(0.5+f1)*jd[1]-1.5*p[0],0,0])
                pulley_negative(1.5*p[0]+(0.5+f1)*jd[0],1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }else if(config[2]==3){ //default flexor
            translate([0,jd[0],0]) rotate([0,0,-atan2(jd[0]-jd[1],bl-(jd[0]+jd[1])/2)]) translate([0,0,0])
                pulley_negative(bl,1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }
        //extensors
        if(config[3]==1 || config[3]==3){ //joint 1
            translate([0,0,0]) rotate([180,0,0])
                pulley_negative(p[0]+jd[0]/2,1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }if(config[3]==2 || config[3]==3){ //joint 2
            translate([bl-jd[1]/2-p[0],0,0]) rotate([180,0,0])
                pulley_negative(p[0]+jd[1]/2,1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }
        //abductors
        if(config[4]==1 || config[4]==3){ //joint 1
            translate([0,jd[0]/2,w[0]/2]) rotate([90,0,0])
                pulley_negative(0.75*p[0]+jd[0]/2-p[2],p[2],p[1],o_fillet=of,t_fillet=true);
            translate([0,jd[0]/2,-w[0]/2]) rotate([270,0,0])
                    pulley_negative(0.75*p[0]+jd[0]/2-p[2],p[2],p[1],o_fillet=of,t_fillet=true);
        }if(config[4]==2 || config[4]==3){ //joint 2
            trans1 = config[1]==2 ? [bl-jd[1]/2+p[2]-p[0],jd[1]/2,w[1]/2]:[bl-jd[1]/2-0.75*p[0]+p[2],jd[1]/2,w[1]/2];
            pl = config[1]==2 ? p[0]+jd[0]/2-p[2]:0.75*p[0]+jd[0]/2-p[2];
            translate(trans1) rotate([90,0,0])
                pulley_negative(pl,p[2],p[1],o_fillet=of,t_fillet=true);
            trans2 = config[1]==2 ? [bl-jd[1]/2+p[2]-p[0],jd[1]/2,-w[1]/2]:[bl-jd[1]/2-0.75*p[0]+p[2],jd[1]/2,-w[1]/2];
            translate(trans2) rotate([270,0,0])
                pulley_negative(pl,p[2],p[1],o_fillet=of,t_fillet=true);
        }
        //opposors
        if(config[10]==1){ //index side pulleys
            if(thumb_adj1!=0){ //only generate if adjacent to thumb
                translate([thumb_adj1,jd[1]/2,(w[0]+w[1])/4]) rotate([90,0,0])
                    pulley_negative(p[0],p[2],1.2*p[1],o_fillet=of,t_fillet=true);
            }if(thumb_adj2!=0){
                translate([thumb_adj2,jd[1]/2,-(w[0]+w[1])/4]) rotate([270,0,0])
                    pulley_negative(p[0],p[2],1.2*p[1],o_fillet=of,t_fillet=true);
            }
        }
        if(config[9]==1){ //thumb side pulleys
            if(thumb_side==0){
                translate([bl/2-p[0]/2,jd[0]/2,-(w[0]+w[1])/4]) rotate([270,0,0])
                    pulley_negative(0.75*p[0],p[2],p[1],o_fillet=of,t_fillet=true);
            }else{
                translate([bl/2-p[0]/2,jd[0]/2,(w[0]+w[1])/4]) rotate([90,0,0])
                    pulley_negative(0.75*p[0],p[2],p[1],o_fillet=of,t_fillet=true);
            }
        }
        //--------------------------anchors-----------------------//
        //flexor anchors
        if(config[6]==1){ //joint 1 anchor
            translate([jd[0]/2,jd[0],0]) rotate([0,0,-atan2(jd[0]-jd[1],bl-(jd[0]+jd[1])/2)]) translate([f2*jd[0]+2,0.1,0]) rotate([90,0,0]){
                cylinder(4.5,1,1);
                chamfer(2);
            }
        }else if(config[6]==2){ //joint 2 anchor
            translate([jd[0]/2,jd[0],0]) rotate([0,0,-atan2(jd[0]-jd[1],bl-(jd[0]+jd[1])/2)]) translate([bl-jd[0]/2-jd[1]/2-2,0.1,0]) rotate([90,0,0]){
                cylinder(4.5,1,1);
                chamfer(2);
            }
        }
        //extensor anchors
        if(config[7]==1){ //joint 1 anchor
            translate([jd[0]/2,-0.1,0]) rotate([-90,0,0]){
                cylinder(4.5,1,1);
                chamfer(2);
            }
        }else if(config[7]==2){ //empty
            
        }
        //opposition anchors
        if(config[9]==1){
            if(thumb_side==0){
                translate([bl/2+p[0]/2+0.5,jd[0]/2,-(w[0]+w[1])/4-10]) rotate([0,0,0]){
                    cylinder(14.5,2,2);
                }
                translate([bl/2-p[0]/2-1.5,jd[0]/2,-(w[0]+w[1])/4-10]) rotate([0,0,0]){
                    cylinder(14.5,2,2);
                }
            }else{
                translate([bl/2+p[0]/2+0.5,jd[0]/2,(w[0]+w[1])/4+10]) rotate([180,0,0]){
                    cylinder(14.5,2,2);
                }
            }
        }
        //-------------------------support holes------------------------//
        translate([bl-jd[1]/2,jd[1]/2,w[1]/2-1.5]) rotate([-90,0,-ang]) cylinder(10,1.5,1.5);
        translate([bl-jd[1]/2,jd[1]/2,-w[1]/2+1.5]) rotate([-90,0,-ang]) cylinder(10,1.5,1.5);
    }
}

module mech_negative(config,bl,jd,w,lig=[2.5,0.6],p=[5,1.5,1],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    f1=0.5*1;
    f2=0.5*0.5;
    //------------------------------metacarpal------------------------------//
    if(config[0]==0 && config[1]==2){
        union(){
        }
    //------------------------------proximal------------------------------//
    }else if(config[0]==2 && config[1]==1){
        union(){
            //mech interface
            mod=thumb_side!=0 ? 2:0;
            translate([0.5*(jd[0]+bl-(jd[0]+jd[1])/2)+p[2],(jd[0]+jd[1])/4+p[2]-mod,-(w[0]+w[1])/2]) cylinder(w[0]+w[1],1.5*p[2],1.5*p[2]);
        }
    //------------------------------intermediate------------------------------//
    }else if(config[0]==1 && config[1]==1){
        union(){
            //mech interface
            translate([0.5*(jd[0]+bl-(jd[0]+jd[1])/2)+p[2],(jd[0]+jd[1])/4+p[2],-(w[0]+w[1])/2]) cylinder(w[0]+w[1],1.5*p[2],1.5*p[2]);  
        }
    //------------------------------distal------------------------------//
    }else if(config[0]==1 && config[1]==3){
        union(){
            //mech interface
            translate([0.5*(jd[0]+bl-(jd[0]-jd[1])/2),(jd[0]+jd[1])/4,-(w[0]+w[1])/2]) cylinder(w[0]+w[1],1.5*p[2],1.5*p[2]);
            ang1=atan2((jd[0]+jd[1])/4-jd[1]/2,bl-jd[1]/2-0.5*(jd[0]+bl-(jd[0]-jd[1])/2));
            translate([0.5*(jd[0]+bl-(jd[0]-jd[1])/2),(jd[0]+jd[1])/4,0]) rotate([0,90,-ang1]) cylinder(bl,1.5*p[2],1.5*p[2]);
        }
    //------------------------------carpal------------------------------//
    }//else if(bone_type==4){}
}

module pulley_negative(l, r, t, o_fillet=true, t_fillet=true, center=true, ext=true){
    or=0.4;
    tr=1.5;
    translate([0,0,center ? 0 : r+t]) rotate([0,90,0])
        difference(){
            union(){
                cylinder(l,r+t,r+t);
                if(o_fillet==true){
                    translate([sqrt((r+t)*(r+t)+2*(r+t)*or),or,0]) rotate([0,0,180+asin(or/(r+t))]) rotate_extrude(angle=90-asin(or/(r+t)),convexity = 10) translate([or, 0, 0])
                        square([t,l]);
                    translate([-sqrt((r+t)*(r+t)+2*(r+t)*or),or,0]) rotate([0,0,270]) rotate_extrude(angle=90-asin(or/(r+t)),convexity = 10) translate([or, 0, 0])
                        square([t,l]);
                }
            }
//            translate([0,0,-0.1]) cylinder(l+0.2,r,r);
            translate([-r-t-or-0.1,ext ? -r-t-1:-r-t-0.1,-0.1])
            cube([2*(r+t+or+0.1),r+t+0.1,l+0.2]);
        }
}

module tendon_negative(config,bl,jd,w,p,f2=0.25){
    // create a network
    // flex so far no crossing, 0 means its a distal bone (cut on joint 1), 1 doesn't exist yet, 2 and 3 have full cuts but different starting points
    // ext/abd coupled, 0/0 means distal (cut joint 1), 1/x doesn't exist yet, 2/1 is intermediate (cut tip to sides), 2/2 is meta (cut all straight), 3/3 is prox (cut both crossings)
    if(config[0]==0 && config[2]==2){ //metacarpal bone
        p1=[0,jd[0]/2,w[0]/2];
        p2=[bl-jd[1]/2-jd[1]*tan(10),jd[1]/2,w[1]/2];
        p3=[0,jd[0]/2,-w[0]/2];
        p4=[bl-jd[1]/2-jd[1]*tan(10),jd[1]/2,-w[1]/2];
        p5=[0,0,0];
        p6=[bl-jd[1]/2-p[0]/2,0,0];
        cyl_between(p1,p2,2*p[2]);
        cyl_between(p3,p4,2*p[2]);
        cyl_between(p5,p6,2*p[2]);
    }else if(config[3]==3 && config[4]==3){ //prox bone
        ang1=atan2((w[1]-w[0])/2,bl-(jd[0]+jd[1])/2);
        p1=[jd[0]/2+0.75*p[0]-p[2],jd[0]/2,w[0]/2+(0.75*p[0]-p[2])*sin(ang1)];
        p2=[jd[0]/2+0.5*(bl-(jd[0]+jd[1])/2),0,(w[0]+w[1])/4];
        p1b=[jd[0]/2+0.75*p[0]-p[2],jd[0]/2,-w[0]/2-(0.75*p[0]-p[2])*sin(ang1)];
        p2b=[jd[0]/2+0.5*(bl-(jd[0]+jd[1])/2),0,-(w[0]+w[1])/4];
        p3=[bl-jd[1]/2-p[0],0,0];
        p4=[jd[0]/2+p[0],0,0];
        p5=[bl-(jd[1]/2+0.75*p[0]-p[2]),jd[1]/2,w[1]/2-(0.75*p[0]-p[2])*sin(ang1)];
        p5b=[bl-(jd[1]/2+0.75*p[0]-p[2]),jd[1]/2,-w[1]/2+(0.75*p[0]-p[2])*sin(ang1)];
        translate(p1) sphere(2*p[2]);
        translate(p2) sphere(2*p[2]);
        translate(p1b) sphere(2*p[2]);
        translate(p2b) sphere(2*p[2]);
        translate(p3) sphere(2*p[2]);
        translate(p4) sphere(2*p[2]);
        translate(p5) sphere(2*p[2]);
        translate(p5b) sphere(2*p[2]);
        cyl_between(p1,p2,2*p[2]);
        cyl_between(p2,p3,2*p[2]);
        cyl_between(p1b,p2b,2*p[2]);
        cyl_between(p2b,p3,2*p[2]);
        cyl_between(p4,p2,2*p[2]);
        cyl_between(p2,p5,2*p[2]);
        cyl_between(p4,p2b,2*p[2]);
        cyl_between(p2b,p5b,2*p[2]);
    }else if(config[3]==2 && config[4]==1){ //inte bone
        ang1=atan2((w[1]-w[0])/2,bl-(jd[0]+jd[1])/2);
        p1=[jd[0]/2+0.75*p[0]-p[2],jd[0]/2,w[0]/2+(0.75*p[0]-p[2])*sin(ang1)];
        p2=[jd[0]/2+0.5*(bl-(jd[0]+jd[1])/2),0,(w[0]+w[1])/4];
        p1b=[jd[0]/2+0.75*p[0]-p[2],jd[0]/2,-w[0]/2-(0.75*p[0]-p[2])*sin(ang1)];
        p2b=[jd[0]/2+0.5*(bl-(jd[0]+jd[1])/2),0,-(w[0]+w[1])/4];
        p3=[bl-jd[1]/2-p[0],0,0];
        translate(p1) sphere(2*p[2]);
        translate(p2) sphere(2*p[2]);
        translate(p1b) sphere(2*p[2]);
        translate(p2b) sphere(2*p[2]);
        translate(p3) sphere(2*p[2]);
        cyl_between(p1,p2,2*p[2]);
        cyl_between(p2,p3,2*p[2]);
        cyl_between(p1b,p2b,2*p[2]);
        cyl_between(p2b,p3,2*p[2]);
    }else if(config[3]==0 && config[4]==0){
        ang1=atan2(jd[1]-jd[0],bl-(jd[0]+jd[1])/2);
        p1=[jd[0]/2,jd[0],0];
        p2=[jd[0]/2+(f2*jd[0]+2)*cos(ang1),jd[0]+(f2*jd[0]+2)*sin(ang1),0];
        translate(p1) sphere(2*p[2]);
        translate(p2) sphere(2*p[2]);
        cyl_between(p1,p2,2*p[2]);
    }
}

function transpose(A) = [for (j = [0:len(A[0])-1]) [for(i = [0:len(A)-1]) A[i][j]]];
    
module cyl_between(P, Q, r){
    v = Q - P;    
    L = norm(v);  
    c = v / L;    
    is_c_vertical = ( 1 - abs(c * [0, 0, 1]) < 1e-6); 
    u = is_c_vertical ? [1, 0, 0] : cross([0, 0, 1], c); 
    a = u / norm(u); 
    b = cross(c, a);     
    MT = [a, b, c, P]; 
    M = transpose(MT); 
    multmatrix(M) cylinder(h=L, r=r);
}