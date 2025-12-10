include <digits.scad>
//takes variables defined in parameters.scad and generates hand assemblies

//----------------------Finger----------------------//
module single_finger(){
    union(){
        // finger defined by first in finger list (e.g. index finger)
        rotate([0,0,-a_print])
            finger(type_finger[0],
                       bl_finger[0],
                       jd_finger[0],
                       w_finger[0],
                       lig_finger[0],
                       p_finger[0],
                       a_print);
        // wrist interface
        translate([-10,jd_finger[0][0]-8,10]) rotate([-90,0,0])
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
                finger(type_finger[i],
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
                finger(type_thumb[i],
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

//------------------Hand --- no lig------------------//
module hand_nolig(){
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
                finger_nolig(type_finger[i],
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
                finger_nolig(type_thumb[i],
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


//-----------------Hand w/ modular fingers-----------------//
//model type
palm = 0;
finger = 1;
thumb = 2;
all = 3;
module hand_modular(model=all,digit_id=0){
    union(){
        //Palm
        if(model==palm || model==all){
            difference(){
                union(){ //base palm
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
                    //{ //subtract metacarpals
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
        }
        //Finger
        if(model==finger){
            translate(o_finger[digit_id]) rotate([0,0,-a_print]) rotate(a_finger[digit_id]){
                difference(){
                    lig = digit_id<len(lig_finger)?lig_finger[digit_id]:lig_finger[0];
                    p = digit_id<len(p_finger)?p_finger[digit_id]:p_finger[0];
                    //if adjacent to a thumb, include opposition pulley location info
                    dz1 = digit_id==0 && n_thumbs>0 ? 
                                (bl_thumb[0][0]+jd_thumb[0][0]-p[0]>bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2 ? bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2.5 : bl_thumb[0][0]+jd_thumb[0][0]-p[0]):
                                0;
                    dz2 = digit_id==n_fingers-1 && n_thumbs>1 ? 
                                (bl_thumb[1][0]+jd_thumb[1][0]-p[0]>bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2 ? bl_finger[digit_id][0]-jd_finger[digit_id][1]/2-p[0]*2.5 : bl_thumb[1][0]+jd_thumb[1][0]-p[0]):
                                0;
                    finger(type_finger[digit_id],
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
            }
        }
        //Thumb
        if(model==thumb){
            translate(o_thumb[digit_id]) rotate([0,0,-a_print]) rotate(a_thumb[digit_id]){
                difference(){
                    lig = digit_id<len(lig_thumb)?lig_thumb[digit_id]:lig_thumb[0];
                    p = digit_id<len(p_thumb)?p_thumb[digit_id]:p_thumb[0];
                    //thumb reuses finger module with its own configuration defined by type
                    finger(type_thumb[digit_id],
                               bl_thumb[digit_id],
                               jd_thumb[digit_id],
                               w_thumb[digit_id],
                               lig,
                               p,
                               a_print,
                               thumb_side=digit_id);
                    finger_cut(2,thumb,digit_id);
                }
            }
        }
        //All
        if(model==all){
            union(){
                for(i=[0:1:n_fingers-1])
                    hand_modular(model=finger,digit_id=i);
                for(i=[0:1:n_thumbs-1])
                    hand_modular(model=thumb,digit_id=i);
            }
        }
    }
}
module hand_modular_old(model=all){
    print_ang = a_print;
    rotate([0,0,0]){
        if(model==palm || model==all){
            difference(){
                union(){
                    difference(){
                        //palm
                        translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),(o_thumb[2]+o_little[2])/2]) rotate([-90,0,0])
                            palm_with_skin(1+min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),30,o_thumb[2]-o_little[2]+5);
                        //index finger cut
                        union(){
                            translate(o_index) rotate([0,0,-print_ang]) rotate(a_index) 
                                finger_cut(index);
                        }
                        //middle finger cut
                        union(){
                            translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle) 
                                finger_cut(middle);
                        }
                        //ring finger cute
                        union(){
                            translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) 
                                finger_cut(ring);
                        }
                        //little finger cut
                        union(){
                            translate(o_little) rotate([0,0,-print_ang]) rotate(a_little) 
                                finger_cut(little);
                        }
                        //thumb cut
                        union(){
                            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb) 
                                finger_cut(thumb);
                        }
                    }
                    //index finger mount
                    union(){
                        translate(o_index) rotate([0,0,-print_ang]) rotate(a_index) intersection(){
                            finger(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
                            rotate([0,0,print_ang-20]) translate([0,0,0])
                                cube([40,12,30],center=true);
                        }
                    }
                    //middle finger mount
                    union(){
                        translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle) intersection(){
                            finger(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
                            rotate([0,0,print_ang-20]) translate([0,0,0])
                                cube([40,12,30],center=true);
                        }
                    }
                    //ring finger mount
                    union(){
                        translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) intersection(){
                            finger(bl_ring,jd_ring,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_ring);
                            rotate([0,0,print_ang-20]) translate([0,0,0])
                                cube([40,12,30],center=true);
                        }
                    }
                    //little finger mount
                    union(){
                        translate(o_little) rotate([0,0,-print_ang]) rotate(a_little) intersection(){
                            finger(bl_little,jd_little,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_little);
                            rotate([0,0,print_ang-20]) translate([0,0,0])
                                cube([40,12,30],center=true);
                        }
                    }
                    //thumb mount
                    union(){
                        translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb) intersection(){
                            finger(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb); 
                            rotate([0,0,print_ang-33]) translate([0,0,0])
                                cube([19,12,30],center=true);
                        }
                    }
                }
                translate(o_index) rotate([0,0,-print_ang]) rotate(a_index) union(){
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                    rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                }
                translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle) union(){
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                    rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                }
                translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) union(){
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                    rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                }
                translate(o_little) rotate([0,0,-print_ang]) rotate(a_little) union(){
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                    rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                        cylinder(5,3,3,center=true);
                }
                translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb) union(){
                    rotate([0,0,print_ang-33]) translate([3,6,3.2]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-33]) translate([3,6,-3.2]) rotate([90,0,0])
                        cylinder(30,1.5,1.5,center=true);
                    rotate([0,0,print_ang-33]) translate([3,3.75,3.2]) translate([0,-3.75,0]) rotate([90,0,0])
                        cylinder(7,3,3,center=true);
                    rotate([0,0,print_ang-33]) translate([3,3.75,-3.2]) translate([0,-3.75,0]) rotate([90,0,0])
                        cylinder(7,3,3,center=true);
                }
                    
            }
        }if(model==index || model==all){
            //index finger
            difference(){
                translate(o_index) rotate([0,0,-print_ang]) rotate(a_index) difference(){
                    finger_with_skin(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
                    rotate([0,0,print_ang-20]) translate([0,0,0]) 
                        cube([40,12,30],center=true);
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                }
                translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                    finger_cut(thumb);
            }
        }if(model==middle || model==all){
            //middle finger
            difference(){
                translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle) difference(){
                    finger_with_skin(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
                    rotate([0,0,print_ang-20]) translate([0,0,0])
                        cube([40,12,30],center=true);
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                }
                translate(o_index) rotate([0,0,-print_ang]) rotate(a_index)
                    finger_cut(index);
            }
        }if(model==ring || model==all){
            //ring finger
            difference(){
                translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) difference(){
                    finger_with_skin(bl_ring,jd_ring,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_ring);
                    rotate([0,0,print_ang-20]) translate([0,0,0])
                        cube([40,12,30],center=true);
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                }
                translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle)
                    finger_cut(middle);
            }
        }if(model==little || model==all){
            //little finger
            difference(){
                translate(o_little) rotate([0,0,-print_ang]) rotate(a_little) difference(){
                    finger_with_skin(bl_little,jd_little,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_little);
                    rotate([0,0,print_ang-20]) translate([0,0,0])
                        cube([40,12,30],center=true);
                    rotate([0,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                    rotate([0,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                }
                //ring finger
                translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) 
                    finger_cut(ring);
            }
        }if(model==thumb || model==all){
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb) difference(){
                finger_with_skin(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb);
                rotate([0,0,print_ang-33]) translate([0,0,0])
                    cube([19,12,30],center=true);
                rotate([0,0,print_ang-33]) translate([3,6,3.2]) rotate([90,0,0])
                    cylinder(50,1.4,1.4,center=true);
                rotate([0,0,print_ang-33]) translate([3,6,-3.2]) rotate([90,0,0])
                    cylinder(50,1.4,1.4,center=true);
            }
        }if(model==palm_skin || model==all_skin){
            difference(){
                translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),(o_thumb[2]+o_little[2])/2]) rotate([-90,0,0])
                    palm_only_skin(1+min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),30,o_thumb[2]-o_little[2]+5);
                union(){
                    translate(o_index) rotate([0,0,-print_ang]) rotate(a_index) 
                        finger_cut(index,palm=true);
                    //middle finger cut
                    translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle) 
                        finger_cut(middle,palm=true);
                    //ring finger cute
                    translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) 
                        finger_cut(ring,palm=true);
                    //little finger cut
                    translate(o_little) rotate([0,0,-print_ang]) rotate(a_little) 
                        finger_cut(little,palm=true);
                    //thumb cut
                    translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb) 
                        finger_cut(thumb,palm=true);
                    translate(o_index) rotate([0,0,-print_ang]) rotate(a_index) union(){
                        rotate([0,0,print_ang-20]) translate([3,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([12,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                        rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                    }
                    translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle) union(){
                        rotate([0,0,print_ang-20]) translate([3,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([12,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                        rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                    }
                    translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) union(){
                        rotate([0,0,print_ang-20]) translate([3,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([12,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                        rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                    }
                    translate(o_little) rotate([0,0,-print_ang]) rotate(a_little) union(){
                        rotate([0,0,print_ang-20]) translate([3,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([12,-6,0]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-20]) translate([3,-0.5,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                        rotate([0,0,print_ang-20]) translate([12,2.75,0]) rotate([90,0,0])
                            cylinder(5,3,3,center=true);
                    }
                    translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb) union(){
                        rotate([0,0,print_ang-33]) translate([3,-6,3.2]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-33]) translate([3,-6,-3.2]) rotate([90,0,0])
                            cylinder(30,1.5,1.5,center=true);
                        rotate([0,0,print_ang-33]) translate([3,3.75,3.2]) translate([0,-3.75,0]) rotate([90,0,0])
                            cylinder(7,3,3,center=true);
                        rotate([0,0,print_ang-33]) translate([3,3.75,-3.2]) translate([0,-3.75,0]) rotate([90,0,0])
                            cylinder(7,3,3,center=true);
                    }
                }
            }
        }if(model==index_skin || model==all_skin){
            translate(o_index) rotate([0,0,-print_ang]) rotate(a_index)
                finger_only_skin(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
        }if(model==middle_skin || model==all_skin){
            translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle) 
                finger_only_skin(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
        }if(model==ring_skin || model==all_skin){
            translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring)
                finger_only_skin(bl_ring,jd_ring,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_ring);
        }if(model==little_skin || model==all_skin){
            translate(o_little) rotate([0,0,-print_ang]) rotate(a_little)
                finger_only_skin(bl_little,jd_little,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_little);
        }if(model==thumb_skin || model==all_skin){
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                finger_only_skin(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb);
        }
    }
}




module finger_cut_old(model=index,palm=false){
    print_ang = a_print;
    if(model==index){
        difference(){
            w = w_index[0];
            w2 = w_index[1];
            l = bl_index[0];
            d1 = jd_index[0];
            d2 = jd_index[1];
            off = 0;
            rotate([0,0,print_ang])
                polyhedron(points=[[0,0,-w/2],[0,0,w/2],[0,d1+off,-w/2],[0,d1+off,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,-w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
            if(palm==false){
                rotate([0,0,print_ang-20]) translate([0,0,0])
                    cube([40,12,30],center=true);
            }
        }
    }else if(model==middle){
        difference(){
            w = w_middle[0];
            w2 = w_middle[1];
            l = bl_middle[0];
            d1 = jd_middle[0];
            d2 = jd_middle[1];
            off = 0;
            rotate([0,0,print_ang])
                polyhedron(points=[[0,0,-w/2],[0,0,w/2],[0,d1+off,-w/2],[0,d1+off,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,-w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
            if(palm==false){
                rotate([0,0,print_ang-20]) translate([0,0,0])
                    cube([40,12,30],center=true);
            }
        }
    }else if(model==ring){
        difference(){
            w = w_ring[0];
            w2 = w_ring[1];
            l = bl_ring[0];
            d1 = jd_ring[0];
            d2 = jd_ring[1];
            off = 0;
            rotate([0,0,print_ang])
                polyhedron(points=[[0,0,-w/2],[0,0,w/2],[0,d1+off,-w/2],[0,d1+off,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,-w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
            if(palm==false){
                rotate([0,0,print_ang-20]) translate([0,0,0])
                    cube([40,12,30],center=true);
            }
        }
    }else if(model==little){
        difference(){
            w = w_little[0];
            w2 = w_little[1];
            l = bl_little[0];
            d1 = jd_little[0];
            d2 = jd_little[1];
            off = 0;
            rotate([0,0,print_ang])
                polyhedron(points=[[0,0,-w/2],[0,0,w/2],[0,d1+off,-w/2],[0,d1+off,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,-w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
            if(palm==false){
                rotate([0,0,print_ang-20]) translate([0,0,0])
                    cube([40,12,30],center=true);
            }
        }
    }else if(model==thumb){
        difference(){
            w = w_thumb[0];
            w2 = w_thumb[1];
            l = bl_thumb[0];
            d1 = jd_thumb[0];
            d2 = jd_thumb[1];
            off = p_thumb[1]+1.5*p_thumb[2];
            rotate([0,0,print_ang])
                polyhedron(points=[[0,0,-w/2],[0,0,w/2],[0,d1+off,-w/2],[0,d1+off,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,-w2/2],[l-d2/2-d2*sin(10),d2*cos(10)+off,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
            if(palm==false){
                rotate([0,0,print_ang-33]) translate([0,0,0])
                    cube([19,12,30],center=true);
            }
        }
    }
}