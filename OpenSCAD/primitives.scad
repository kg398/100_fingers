//bone types
meta = 0;
prox = 1;
inte = 2;
dist = 3;
carp = 4;

$fs = 0.2;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 3 degrees

//bone(55,9,9,10,bone_type=dist,joint_type=0,lig_ang=0);

//quarter_pipe(10,5,true,true);
//inverted quarter cylinder for bone fillets
//h -> height
//r -> radius
//center -> centers on height
//ext -> extend tabs for subtraction
module quarter_pipe(h,r,center=false,ext=false){
    translate([0,0,center ? -h/2 : 0])
        union(){
            difference(){
                if(ext==false){
                    cube([r, r, h]); 
                }else{
                    cube([r+0.1,r+0.1,h]);
                }
                translate([0, 0, -0.1])
                    cylinder(h+0.2, r, r);
            }
        }        
}

//quarter_cylinder(10,5,true);
//quarter cylinder for bone caps
//h -> height
//r -> radius
//center -> centers on height
module quarter_cylinder(h, r, center=false){ 
    translate([0,0,center ? -h/2 : 0])
        intersection(){
            cube([r, r, h]); 
            translate([0, 0, -0.1])
                cylinder(h+0.2, r, r);
        }         
}

//chamfer(2);
//cylinder plus cone for cutting tendon anchor chamfers
//h -> cylinder height
//r -> cone radius
module chamfer(r, h=5){
//    union(){
//        cylinder(r,r,0);
//        translate([0,0,-h])
//            cylinder(h,r,r);
//    }
    translate([0,0,-h])
        rotate_extrude()
            polygon(points=[[0,0],[0,h+r],[r,h],[r,0]]);
}

//pulley(5,1,1.5);
//pulley for tendon
//l -> length of pulley
//r -> inner radius
//t -> thickness
//o_fillet -> outer fillet for bone adhesion
//t_fillet -> tendon fillet for smooth tendon motion
//ext -> extend tabs for subtraction
module pulley(l, r, t, o_fillet=true, t_fillet=true, center=true, ext=true){
    or=0.4;
    tr=1.5;
    translate([0,0,center ? 0 : r+t])
    rotate([0,90,0])
    difference(){
        union(){
            cylinder(l,r+t,r+t);
            if(o_fillet==true){
                translate([sqrt((r+t)*(r+t)+2*(r+t)*or),or,0]) rotate([0,0,180+asin(or/(r+t))]) rotate_extrude(angle=90-asin(or/(r+t)),convexity = 10) translate([or, 0, 0])
                    square([t,l]);
                translate([-sqrt((r+t)*(r+t)+2*(r+t)*or),or,0]) rotate([0,0,270]) rotate_extrude(angle=90-asin(or/(r+t)),convexity = 10) translate([or, 0, 0])
                    square([t,l]);
                /*translate([sqrt(r*r-2*r*or),or,0]) rotate([0,0,270]) rotate_extrude(angle=90+asin(or/(r+t)),convexity = 10) translate([or, 0, 0])
                    square([t,l]);
                translate([-sqrt(r*r-2*r*or),or,0]) rotate([0,0,180-asin(or/(r+t))]) rotate_extrude(angle=90+asin(or/(r+t)),convexity = 10) translate([or, 0, 0])
                    square([t,l]);*/
            }
        }
        translate([0,0,-0.1]) cylinder(l+0.2,r,r);
        if(t_fillet==true){
            rotate_extrude(angle=360) projection() translate([r+tr,tr,0]) rotate([0,0,180]) 
                quarter_pipe(1,tr,ext=true);
            rotate_extrude(angle=360) projection() translate([r+tr,l-tr,0]) rotate([0,0,90]) 
                quarter_pipe(1,tr,ext=true);
        }
        translate([-r-t-or-0.1,ext ? -r-t-1:-r-t-0.1,-0.1])
        cube([2*(r+t+or+0.1),r+t+0.1,l+0.2]);
    }
}

//tendon(50,0.4,0.8,center=true);
//tendon with end loop
//l -> length of tendon
//t -> thickness
//w -> width
//r -> loop outer radius
//center -> center on width
module tendon(l, t, w, r=2, center=false){
    translate([0,0,center ? -w/2 : 0])
    difference(){
        union(){
            cube([l,t,w]);
            translate([l,0,w/2]) rotate([270,0,0]) 
                cylinder(t,r,r);
        }
        translate([l,-0.1,w/2]) rotate([270,0,0])
            cylinder(t+0.2,0.5,0.5);
    }
}


//bone(30,12,10,12,w2=16,bone_type=meta,joint_type=2,lig_ang=20);
//multi-bone module
//l -> length of tendon
//d1 -> proximal diameter
//d2 -> distal diameter
//w -> width
//bone_type -> which finger bone {0,1,2,3,4}->{metacarpal, proximal, intermediate, distal, carpal}
//joint_type -> interface geometry {0}->{default}
//lig_type -> unused {0}->{default}
//pulley_type -> unused {0}->{default}
//tendon_type -> deprecated {0,1}->{old, disabled}
//t1 -> tendon parameters deprecated
//nail_type -> unused
//en -> deprecated enable fillets (false for faster rendering)
module bone(l, d1, d2, w, w2=0, bone_type=0, joint_type=0, lig_type=0, lig_ang=0, pulley_type=0, tendon_type=1, tl=[100,100], nail_type=0, en=false, center=true, lw=1.6, lt=0.6, pl=5, pt=1.5, pr=1, of=false){
//    lw=1.6;//default ligament width
//    lt=0.6;//default ligament thickness
//    pl=5;//default pulley length
//    pt=1.8;//default pulley thickness
//    pr=0.75;//default pulley radius
//    of=true;//enable outer pulley fillet
    f1=0.5*1;
    f2=0.5*0.5;
    w2 = w2 ? w2 : w;
    translate([0,0,center ? 0 : w/2])
    //------------------------------metacarpal------------------------------//
    if(bone_type==0||bone_type==4){
        union(){
            //bone
            if(joint_type==0){
                difference(){
                    union(){
                        polyhedron(points=[[0,0,-w/2],[0,0,w/2],[0,d1,-w/2],[0,d1,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2,d2,-w2/2],[l-d2/2,d2,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                        intersection(){
                            translate([l-d2/2,d2/2,-w2/2])
                                cylinder(w2,d2/2,d2/2);
                            translate([l-0.1-d2/2,-1,-1-w2/2])
                                cube([1.1+d2/2,2+d2,2+w2]);
                        }
                    }
                    translate([l-w2/2+1,d2,-1]) rotate([90,90,0])
                        quarter_pipe(d2,w2/2-1,ext=true);
                    translate([l-w2/2+1,d2,1]) rotate([90,0,0])
                        quarter_pipe(d2,w2/2-1,ext=true);
                }
            }
            if(joint_type==2){
                union(){
                    polyhedron(points=[[0,0,-w/2],[0,0,w/2],[0,d1,-w/2],[0,d1,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2-d2*sin(10),d2*cos(10),-w2/2],[l-d2/2-d2*sin(10),d2*cos(10),w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                translate([l-d2/2,d2/2,0]) scale([1,1,w2*0.8/d2])
                    sphere(d=d2);
                translate([l-d2/2,0,-w2/2]) rotate([0,0,10]) translate([0,d2/2,0]) scale([0.4,1,w2/d2])
                    intersection(){
                        cylinder(d2,0.5*d2,0.5*d2);
                        translate([0,-0.55*d2,0]) cube([1.1*d2,1.1*d2,1.1*d2]);
                    }
                }
            }
            //pulleys
            if(pulley_type==0){
                //flex
                translate([0,d1,0]) rotate([0,0,-atan2(d1-d2,l-d2/2)]) translate([l-(0.5+f1)*d2-1.5*pl,0,0])
                    pulley(1.5*pl,1.5*pr,pt,o_fillet=of,t_fillet=true);
                //abd1
                translate([l-d2/2+pr-pl,d2/2,w2/2]) rotate([90,0,0])
                    pulley(pl,pr,pt,o_fillet=of,t_fillet=true);
                //abd2
                translate([l-d2/2+pr-pl,d2/2,-w2/2]) rotate([270,0,0])
                    pulley(pl,pr,pt,o_fillet=of,t_fillet=true);
                //ext
                if(joint_type==0||joint_type==2){
                    translate([l-d2/2-pl,0,0]) rotate([180,0,0])
                        pulley(pl,1.5*pr,pt,o_fillet=of,t_fillet=true);
                }
            }
        }
    //------------------------------proximal------------------------------//
    }else if(bone_type==1){
        union(){
            //bone
            difference(){
                union(){
                    if(joint_type==0||joint_type==1||joint_type==2){
                        polyhedron(points=[[d1/2,0,-w/2],[d1/2,0,w/2],[d1/2,d1,-w/2],[d1/2,d1,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2,d2,-w2/2],[l-d2/2,d2,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                        intersection(){
                            translate([d1/2,d1/2,-w/2])
                                cylinder(w,d1/2,d1/2);
                            translate([-1,-1,-1-w/2])
                                cube([1.1+d1/2,2+d1,2+w]);
                        }
                        translate([l-d2/2-0.1,0,-(w2-2*lw-0.4)/2])
                            cube([d2/2+0.1,d2/2,w2-2*lw-0.4]);
                        intersection(){
                            translate([l-d2/2,d2/2,-w2/2])
                                cylinder(w2,d2/2,d2/2);
                            translate([l-0.1-d2/2,-1,-1-w2/2])
                                cube([1.1+d2/2,2+d2,2+w2]);
                        }
                    }
                    if(joint_type==2){
                        intersection(){
                            union(){
                                translate([d1/2,d1/2,0]) rotate_extrude(angle=360) projection() translate([-w-d1/2,0,0])
                                    quarter_pipe(1,w,ext=true);
                                mirror([0,0,1]) translate([d1/2,d1/2,0]) rotate_extrude(angle=360) projection() translate([-w-d1/2,0,0])
                                    quarter_pipe(1,w,ext=true);
                            }
                            intersection(){
                                dr=w-w*sin(acos((w/2-lw)/w));
                                translate([d1/2,d1/2,-w/2])
                                    cylinder(w,d1/2+dr,d1/2+dr);
                                translate([-1-dr,0,-w/2-1])
                                    cube([d1/2+1+dr,d1,w+2]);
                            }
                        }
                    }
                }
                ang=atan2((w-w2)/2,l-d1/2-d2/2);
                translate([d1/2,(w2/2-1),-1-(l-(d1+d2)/2-2*pl)]) rotate([0,-ang,0]) translate([pl,0,l-(d1+d2)/2-2*pl-(w-w2)/2]) rotate([0,90,0]) rotate([0,0,270])
                            quarter_pipe(l-(d1+d2)/2-2*pl,w2/2-1,ext=true);
                translate([d1/2,w2/2-1,1+(l-(d1+d2)/2-2*pl)]) rotate([0,ang,0]) translate([pl,0,-(l-(d1+d2)/2-2*pl)+(w-w2)/2]) rotate([0,90,0]) rotate([0,0,180])
                            quarter_pipe(l-(d1+d2)/2-2*pl,w2/2-1,ext=true);
                if(joint_type==0){
                    translate([w/2-1,d1,-1]) rotate([90,180,0])
                        quarter_pipe(d1,w/2-1,ext=true);
                    translate([w/2-1,d1,1]) rotate([90,270,0])
                        quarter_pipe(d1,w/2-1,ext=true);
                }
            }
            //ligaments
            if(lig_type==0){
                if(joint_type==0){
                    translate([0.5*d1,d1-0.1,w/2-lw]) rotate([0,0,180-lig_ang])
                        cube([2*d1,lt,lw]);
                    translate([0.5*d1,d1-0.1,-w/2]) rotate([0,0,180-lig_ang])
                        cube([2*d1,lt,lw]);
                }else if(joint_type==2){
                    ang=30;
                    dr=w-w*sin(acos((w/2-lw)/w));
                    translate([lt+d1/2-(0.5*d1+dr)*cos(ang),d1/2+(d1/2+dr)*sin(ang),w/2-lw]) rotate([0,0,180-lig_ang])
                        cube([1*d1,lt,lw]);
                    translate([lt+d1/2-(0.5*d1+dr)*cos(ang),d1/2+(d1/2+dr)*sin(ang),,-w/2]) rotate([0,0,180-lig_ang])
                        cube([1*d1,lt,lw]);
                }
            }
            
            //pulleys
            if(pulley_type==0){
                //flex
                translate([d1/2,d1,0]) rotate([0,0,-atan2(d1-d2,l-(d1+d2)/2)]) translate([f2*d1,0,0])
                    pulley(l-(0.5+f2)*d1-(0.5+f1)*d2,1.5*pr,pt,o_fillet=of,t_fillet=true);
                //abd1
                translate([d1/2-pr,d1/2,w/2]) rotate([90,0,0])
                    pulley(0.75*pl,pr,pt,o_fillet=of,t_fillet=true);
                translate([l-d2/2-0.75*pl+pr,d2/2,w2/2]) rotate([90,0,0])
                    pulley(0.75*pl,pr,pt,o_fillet=of,t_fillet=true);
                //abd2
                translate([d1/2-pr,d1/2,-w/2]) rotate([270,0,0])
                    pulley(0.75*pl,pr,pt,o_fillet=of,t_fillet=true);
                translate([l-d2/2-0.75*pl+pr,d2/2,-w2/2]) rotate([270,0,0])
                    pulley(0.75*pl,pr,pt,o_fillet=of,t_fillet=true);
                if(joint_type==0||joint_type==1||joint_type==2){
                    translate([d1/2,0,0]) rotate([180,0,0])
                        pulley(pl,1.5*pr,pt,o_fillet=of,t_fillet=true);
                    translate([l-d2/2-pl,0,0]) rotate([180,0,0])
                        pulley(pl,1.5*pr,pt,o_fillet=of,t_fillet=true);
                }
            }
        }
    //------------------------------intermediate------------------------------//
    }else if(bone_type==2){
        union(){
            //bone
            difference(){
                union(){
                    if(joint_type==0){
                        polyhedron(points=[[d1/2,0,-w/2],[d1/2,0,w/2],[d1/2,d1,-w/2],[d1/2,d1,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2,d2,-w2/2],[l-d2/2,d2,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                        intersection(){
                            translate([d1/2,d1/2,-w/2])
                                cylinder(w,d1/2,d1/2);
                            translate([-1,-1,-1-w/2])
                                cube([1.1+d1/2,2+d1,2+w]);
                        }
                        translate([0,0,-(w-2*lw-0.4)/2])
                            cube([d1/2+0.1,d1/2,w-2*lw-0.4]);
                        translate([l-d2/2-0.1,0,-(w2-2*lw-0.4)/2])
                            cube([d2/2+0.1,d2/2,w2-2*lw-0.4]);
                        intersection(){
                            translate([l-d2/2,d2/2,-w2/2])
                                cylinder(w2,d2/2,d2/2);
                            translate([l-0.1-d2/2,-1,-1-w2/2])
                                cube([1.1+d2/2,2+d2,2+w2]);
                        }
                    }
                }
                ang=atan2((w-w2)/2,l-d1/2-d2/2);
                translate([d1/2,(w2/2-1),-1-(l-(d1+d2)/2-2*pl)]) rotate([0,-ang,0]) translate([+0.75*pl-pr,0,l-(d1+d2)/2-2*pl-(w-w2)/2]) rotate([0,90,0]) rotate([0,0,270])
                            quarter_pipe(l-(d1+d2)/2-1.75*pl+pr,w2/2-1,ext=true);
                translate([d1/2,w2/2-1,1+(l-(d1+d2)/2-2*pl)]) rotate([0,ang,0]) translate([+0.75*pl-pr,0,-(l-(d1+d2)/2-2*pl)+(w-w2)/2]) rotate([0,90,0]) rotate([0,0,180])
                            quarter_pipe(l-(d1+d2)/2-1.75*pl+pr,w2/2-1,ext=true);
                
                
                if(tendon_type==1){
                    //tendon anchors
                    translate([d1/2,d1,0]) rotate([0,0,-atan2(d1-d2,l-(d1+d2)/2)]) translate([l-d1/2-d2/2-2,0.1,0]) rotate([90,0,0]){
                        cylinder(4.5,1,1);
                        chamfer(2);
                    }
                    translate([d1/2,-0.1,0]) rotate([-90,0,0]){
                        cylinder(4.5,1,1);
                        chamfer(2);
                    }
                }
            }
            
            //ligaments
            if(lig_type==0){
                translate([0.5*d1,d1-0.1,w/2-lw]) rotate([0,0,180-lig_ang])
                    cube([2*d1,lt,lw]);
                translate([0.5*d1,d1-0.1,-w/2]) rotate([0,0,180-lig_ang])
                    cube([2*d1,lt,lw]);
            }
            
            //pulleys
            if(pulley_type==0){
                //flex
                translate([d1/2,d1,0]) rotate([0,0,-atan2(d1-d2,l-(d1+d2)/2)]) translate([f2*d1,0,0])
                    pulley(l-(0.5+f2)*d1-(0.5+f1)*d2,1.5*pr,pt,o_fillet=of,t_fillet=true);
                //abd1
                translate([d1/2-pr,d1/2,w/2]) rotate([90,0,0])
                    pulley(0.75*pl,pr,pt,o_fillet=of,t_fillet=true);
                //abd2
                translate([d1/2-pr,d1/2,-w/2]) rotate([270,0,0])
                    pulley(0.75*pl,pr,pt,o_fillet=of,t_fillet=true);
                //ext
                if(joint_type==0){
                    translate([l-d2/2-pl,0,0]) rotate([180,0,0])
                        pulley(pl,1.5*pr,pt,o_fillet=of,t_fillet=true);
                }
            }
            
            //tendons
            if(tendon_type==0){
                translate([l-r-1,r-0.6,w/2-3/2])
                    tendon(tl[0],0.6,3);
                translate([1,0,w/2+3]) rotate([0,182,0])
                    tendon(tl[1],0.6,2.5);
                translate([1,0,w/2]) rotate([0,178,0])
                    tendon(tl[1],0.6,2.5);
            }
        }
    //------------------------------distal------------------------------//
    }else if(bone_type==3){
        union(){
            //bone
            difference(){
                union(){
                    if(joint_type==0){
                        polyhedron(points=[[d1/2,0,-w/2],[d1/2,0,w/2],[d1/2,d1,-w/2],[d1/2,d1,w/2],[l-d2/2,0,-w2/2],[l-d2/2,0,w2/2],[l-d2/2,d2,-w2/2],[l-d2/2,d2,w2/2]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                        intersection(){
                            translate([d1/2,d1/2,-w/2])
                                cylinder(w,d1/2,d1/2);
                            translate([-1,-1,-1-w/2])
                                cube([1.1+d1/2,2+d1,2+w]);
                        }
                        translate([0,0,-(w-2*lw-0.4)/2])
                            cube([d1/2+0.1,d1/2,w-2*lw-0.4]);
                        intersection(){
                            translate([l-d2/2,d2/2,-w2/2])
                                cylinder(w2,d2/2,d2/2);
                            translate([l-0.1-d2/2,-1,-1-w2/2])
                                cube([1.1+d2/2,2+d2,2+w2]);
                        }
                    }
                    //nail
                    if(nail_type==0){
                        translate([l/2-d2/2,-1,-w2/2]){
                            cube([l/2,1,w2]);
                            translate([0,-2,-1]){
                                difference(){
                                    cube([l/2+3,2,w2+2]);
                                    translate([l/2+3,1.7,-0.1]) rotate([0,0,45])
                                        cube([1,1,w2+2.2]);
                                }
                            }
                        }
                    }
                }
                if(tendon_type==1){
                    //tendon anchors
                    translate([d1/2,d1,0]) rotate([0,0,-atan2(d1-d2,l-(d1+d2)/2)]) translate([f2*d1+2,0.1,0]) rotate([90,0,0]){
                        cylinder(4.5,1,1);
                        chamfer(2);
                    }
                    translate([d1/2,-0.1,0]) rotate([-90,0,0]){
                        cylinder(4.5,1,1);
                        chamfer(2);
                    }
                }
            }
                
            //ligaments
            if(lig_type==0){
                translate([0.5*d1,d1-0.1,w/2-lw]) rotate([0,0,180-lig_ang])
                    cube([2*d1,lt,lw]);
                translate([0.5*d1,d1-0.1,-w/2]) rotate([0,0,180-lig_ang])
                    cube([2*d1,lt,lw]);
            }
            
            //pulleys
            if(pulley_type==0){
            }
            
            //tendons
            if(tendon_type==0){
                translate([l-r/2-1,r-0.6,w/2-3/2])
                    tendon(tl[0],0.6,3);
                translate([1,0,w/2+3])
                    rotate([0,181,0])
                        tendon(tl[1],0.6,2.5);
                translate([1,0,w/2])
                    rotate([0,179,0])
                        tendon(tl[1],0.6,2.5);
            }
        }
    //------------------------------carpal------------------------------//
    }//else if(bone_type==4){}
}
