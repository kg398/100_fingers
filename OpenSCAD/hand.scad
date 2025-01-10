include <digits.scad>

//bl_index = [20,40,35,25];
//jd_index = [12,16,10,8];
//a_print=45;
//lig_index=[2.5,0.6];
//p_index=[5,1.5,1];
//w_index=[10,14,10,10,10];
//single_finger();

//----------------------Finger----------------------//
module single_finger(){
    union(){
        print_ang = a_print;
        rotate([0,0,-print_ang])
            finger(bl_index,jd_index,ang=print_ang,index=0,pulley=p_index,bone_width=w_index);
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
                finger(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
            //middle finger
            translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle)
                finger(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
            //ring finger
            translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring)
                finger(bl_ring,jd_ring,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_ring);
            //little finger
            translate(o_little) rotate([0,0,-print_ang]) rotate(a_little)
                finger(bl_little,jd_little,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_little);
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                finger(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb); 
            //palm
            translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),(o_thumb[2]+o_little[2])/2]) rotate([-90,0,0])
                palm(1+min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),30,o_thumb[2]-o_little[2]+5);
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
                finger_nolig(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
            //middle finger
            translate(o_middle) rotate([0,0,-print_ang]) rotate(a_middle)
                finger_nolig(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
            //ring finger
            translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring)
                finger_nolig(bl_ring,jd_ring,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_ring);
            //little finger
            translate(o_little) rotate([0,0,-print_ang]) rotate(a_little)
                finger_nolig(bl_little,jd_little,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_little);
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                finger_nolig(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb); 
            //palm
            translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]),(o_thumb[2]+o_little[2])/2]) rotate([-90,0,0])
                palm(1+min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),30,o_thumb[2]-o_little[2]+5);
        }
    }
}

//-------------------Hand w/ 2 thumbs-------------------//
module hand_2thumb(){
    union(){
        print_ang = a_print;
        rotate([0,0,0]){
            //index finger
            translate(o_index) rotate([0,0,-print_ang]) rotate(a_index)
                finger(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
            //middle finger
            translate(o_middle) rotate([0,0,-print_ang]) rotate(0)
                finger(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                finger(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb);
            //reflected digits 
            mirror([0,0,1]){
                //index
                translate(o_index) translate(-2*o_middle) rotate([0,0,-print_ang]) rotate(a_index)
                    finger(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
                //thumb
                translate(o_thumb) translate(-2*o_middle) rotate([0,0,-print_ang]) rotate(a_thumb)
                    finger(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb);
            }
            //palm
            translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]),o_middle[2]]) rotate([-90,0,0])
                palm(1+min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),30,o_thumb[2]-o_little[2]+5);
        }
    }
}

//------------------Hand w/ 2 thumbs --- no lig------------------//
module hand_2thumb_nolig(){
    union(){
        print_ang = a_print;
        rotate([0,0,0]){
            //index finger
            translate(o_index) rotate([0,0,-print_ang]) rotate(a_index)
                finger_nolig(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
            //middle finger
            translate(o_middle) rotate([0,0,-print_ang]) rotate(0)
                finger_nolig(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb)
                finger_nolig(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb);
           
           //reflected digits 
            mirror([0,0,1]){
                //index
                translate(o_index) translate(-2*o_middle) rotate([0,0,-print_ang]) rotate(a_index)
                    finger_nolig(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
                //thumb
                translate(o_thumb) translate(-2*o_middle) rotate([0,0,-print_ang]) rotate(a_thumb)
                    finger_nolig(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb);
            }
            
            //palm
            translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]),o_middle[2]]) rotate([-90,0,0])
                palm(1+min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),30,o_thumb[2]-o_little[2]+5);
        }
    }
}

//-----------------Hand w/ modular fingers-----------------//
//model
palm = 0;
index = 1;
middle = 2;
ring = 3;
little = 4;
thumb = 5;
all = 6;
module hand_modular(model=all){
    print_ang = a_print;
    rotate([0,0,0]){
        if(model==palm || model==all){
            difference(){
                union(){
                    difference(){
                        //palm
                        translate([0,max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),(o_thumb[2]+o_little[2])/2]) rotate([-90,0,0])
                            palm(1+min(jd_index[0],o_middle[1]+jd_middle[0],o_ring[1]+jd_ring[0],o_little[1]+jd_little[0],o_thumb[1]+jd_thumb[0])-max(o_index[1],o_middle[1],o_ring[1],o_little[1],o_thumb[1]-5),30,o_thumb[2]-o_little[2]+5);
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
                    finger(bl_index,jd_index,ang=print_ang,index=bl_thumb[0]+jd_thumb[0]-p_index[0],lig=lig_index,pulley=p_index,bone_width=w_index);
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
                    finger(bl_middle,jd_middle,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_middle);
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
                    finger(bl_ring,jd_ring,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_ring);
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
                    finger(bl_little,jd_little,ang=print_ang,lig=lig_index,pulley=p_index,bone_width=w_little);
                    rotate([0,0,print_ang-20]) translate([0,0,0])
                        cube([40,12,30],center=true);
                    rotate([90,0,print_ang-20]) translate([3,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                    rotate([90,0,print_ang-20]) translate([12,0,0]) rotate([90,0,0])
                        cylinder(50,1.4,1.4,center=true);
                }
                //ring finger
                translate(o_ring) rotate([0,0,-print_ang]) rotate(a_ring) 
                    finger_cut(ring);
            }
        }if(model==thumb || model==all){
            //thumb
            translate(o_thumb) rotate([0,0,-print_ang]) rotate(a_thumb) difference(){
                finger(bl_thumb,jd_thumb,ang=print_ang,thumb=1,lig=lig_index,pulley=p_thumb,bone_width=w_thumb);
                rotate([0,0,print_ang-33]) translate([0,0,0])
                    cube([19,12,30],center=true);
                rotate([0,0,print_ang-33]) translate([3,6,3.2]) rotate([90,0,0])
                    cylinder(50,1.4,1.4,center=true);
                rotate([0,0,print_ang-33]) translate([3,6,-3.2]) rotate([90,0,0])
                    cylinder(50,1.4,1.4,center=true);
            }
        }
    }
}

module finger_cut(model=index){
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
            rotate([0,0,print_ang-20]) translate([0,0,0])
                cube([40,12,30],center=true);
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
            rotate([0,0,print_ang-20]) translate([0,0,0])
                cube([40,12,30],center=true);
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
            rotate([0,0,print_ang-20]) translate([0,0,0])
                cube([40,12,30],center=true);
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
            rotate([0,0,print_ang-20]) translate([0,0,0])
                cube([40,12,30],center=true);
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
            rotate([0,0,print_ang-33]) translate([0,0,0])
                cube([19,12,30],center=true);
        }
    }
}