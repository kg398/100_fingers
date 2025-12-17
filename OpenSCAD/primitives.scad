//bone types
meta = 0;
prox = 1;
inte = 2;
dist = 3;
carp = 4;

//$fs = 0.2;  // Don't generate smaller facets than 0.1 mm
//$fa = 5;    // Don't generate larger angles than 3 degrees

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

////Bone configurations
//[joint1 type, joint2 type, flexor pulley type, extensor pulley type, abd pulley type, fillet type, flexor anchor type, extensor anchor type, opposition anchor, opposition pulley]
module modular_bone(config,bl,jd,w,lig=[2.5,0.6],p=[5,1.5,1],ang=45,thumb_adj1=0,thumb_adj2=0,thumb_side=0){
    //flexor pulley offsets defined by stability criteria (Gilday 2025)
    f1=0.5*1;
    f2=0.5*0.5;
    //pulley settings
    of=false;
    union(){
        difference(){
            union(){
                //-----------------------base polygon---------------------//
                {
                p1 = config[0] == 0 ? // if joint 1 type == base
                        [[0,0,-w[0]/2],[0,0,w[0]/2],[0,jd[0],-w[0]/2],[0,jd[0],w[0]/2]]:
                        [[jd[0]/2,0,-w[0]/2],[jd[0]/2,0,w[0]/2],[jd[0]/2,jd[0],-w[0]/2],[jd[0]/2,jd[0],w[0]/2]];
                p2 = config[1] == 2 ? // if joint 2 type == 2dof
                        [[bl-jd[1]/2,0,-w[1]/2],[bl-jd[1]/2,0,w[1]/2],[bl-jd[1]/2-jd[1]*sin(10),jd[1]*cos(10),-w[1]/2],[bl-jd[1]/2-jd[1]*sin(10),jd[1]*cos(10),w[1]/2]]:
                        [[bl-jd[1]/2,0,-w[1]/2],[bl-jd[1]/2,0,w[1]/2],[bl-jd[1]/2,jd[1],-w[1]/2],[bl-jd[1]/2,jd[1],w[1]/2]];
                
                polyhedron(points=[p1[0],p1[1],p1[2],p1[3],p2[0],p2[1],p2[2],p2[3]],faces=[[0,2,3,1],[0,1,5,4],[4,5,7,6],[2,6,7,3],[0,4,6,2],[1,3,7,5]]);
                }
                //--------------------------joints------------------------//
                //joint 1 (proximal)
                if(config[0]==0){ //empty
                }else if(config[0]==1){ //type 1dof
                    intersection(){
                        translate([jd[0]/2,jd[0]/2,-w[0]/2])
                            cylinder(w[0],jd[0]/2,jd[0]/2);
                        translate([-1,-1,-1-w[0]/2])
                            cube([1.1+jd[0]/2,2+jd[0],2+w[0]]);
                    }
                    translate([0,0,-(w[0]-2*lig[0]-0.4)/2])
                        cube([jd[0]/2+0.1,jd[0]/2,w[0]-2*lig[0]-0.4]);
                }else if(config[0]==2){ //type 2dof
                    intersection(){
                        translate([jd[0]/2,jd[0]/2,-w[0]/2])
                            cylinder(w[0],jd[0]/2,jd[0]/2);
                        translate([-1,-1,-1-w[0]/2])
                            cube([1.1+jd[0]/2,2+jd[0],2+w[0]]);
                    }
                    intersection(){
                        union(){
                            translate([jd[0]/2,jd[0]/2,0]) rotate_extrude(angle=360) projection() translate([-w[0]-jd[0]/2,0,0])
                                quarter_pipe(1,w[0],ext=true);
                            mirror([0,0,1]) translate([jd[0]/2,jd[0]/2,0]) rotate_extrude(angle=360) projection() translate([-w[0]-jd[0]/2,0,0])
                                quarter_pipe(1,w[0],ext=true);
                        }
                        intersection(){
                            dr=w[0]-w[0]*sin(acos((w[0]/2-lig[0])/w[0]));
                            translate([jd[0]/2,jd[0]/2,-w[0]/2])
                                cylinder(w[0],jd[0]/2+dr,jd[0]/2+dr);
                            translate([-1-dr,0,-w[0]/2-1])
                                cube([jd[0]/2+1+dr,jd[0],w[0]+2]);
                        }
                    }
                }else if(config[0]==3){ //empty
                }
                //joint 2 (distal)
                if(config[1]==0){ //empty
                }else if(config[1]==1){ //type 1dof
                    intersection(){
                        translate([bl-jd[1]/2,jd[1]/2,-w[1]/2])
                            cylinder(w[1],jd[1]/2,jd[1]/2);
                        translate([bl-0.1-jd[1]/2,-1,-1-w[1]/2])
                            cube([1.1+jd[1]/2,2+jd[1],2+w[1]]);
                    }
                    translate([bl-jd[1]/2-0.1,0,-(w[1]-2*lig[0]-0.4)/2])
                        cube([jd[1]/2+0.1,jd[1]/2,w[1]-2*lig[0]-0.4]);
                }else if(config[1]==2){ //type 2dof
                    translate([bl-jd[1]/2,jd[1]/2,0]) scale([1,1,w[1]*0.8/jd[1]])
                        sphere(d=jd[1]);
                    translate([bl-jd[1]/2,0,-w[1]/2]) rotate([0,0,10]) translate([0,jd[1]/2,0]) scale([0.4,1,w[1]/jd[1]])
                        intersection(){
                            cylinder(jd[1],0.5*jd[1],0.5*jd[1]);
                            translate([0,-0.55*jd[1],0]) cube([1.1*jd[1],1.1*jd[1],1.1*jd[1]]);
                        }
                }else if(config[1]==3){ //type fingertip
                    intersection(){
                        translate([bl-jd[1]/2,jd[1]/2,-w[1]/2])
                            cylinder(w[1],jd[1]/2,jd[1]/2);
                        translate([bl-0.1-jd[1]/2,-1,-1-w[1]/2])
                            cube([1.1+jd[1]/2,2+jd[1],2+w[1]]);
                    }
                    translate([bl/2-jd[1]/2,-1,-w[1]/2]){
                        translate([0,-0.1,0]) cube([bl/2,1.2,w[1]]);
                        translate([0,-2,-1]){
                            difference(){
                                cube([bl/2+3,2,w[1]+2]);
                                translate([bl/2+3,1.3,-0.1]) rotate([0,0,45])
                                    cube([1,1,w[1]+2.2]);
                            }
                        }
                    }
                }
                
            }
            union(){
                //--------------------------fillets-----------------------//
                if(config[5]==1){ //extensor side fillet
                    rad=min(w[0],w[1]);
                    ang=atan2((w[0]-w[1])/2,bl-jd[0]/2-jd[1]/2);
                    translate([jd[0]/2,rad/2-1,-w[0]/2]) rotate([0,-ang,0]) translate([p[0],0,rad/2-1]) rotate([0,90,0]) rotate([0,0,270])
                                quarter_pipe(bl-(jd[0]+jd[1])/2-2*p[0],rad/2-1,ext=true);
                    translate([jd[0]/2,rad/2-1,w[0]/2]) rotate([0,ang,0]) translate([p[0],0,-rad/2+1]) rotate([0,90,0]) rotate([0,0,180])
                                quarter_pipe(bl-(jd[0]+jd[1])/2-2*p[0],rad/2-1,ext=true);
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
                        translate([bl/2+p[0]/2+0.5,jd[0]/2,-(w[0]+w[1])/4]) rotate([0,0,0]){
                            cylinder(4.5,1,1);
                            chamfer(2,h=1);
                        }
                    }else{
                        translate([bl/2+p[0]/2+0.5,jd[0]/2,(w[0]+w[1])/4]) rotate([180,0,0]){
                            cylinder(4.5,1,1);
                            chamfer(2,h=1);
                        }
                    }
                }
                //------------------------modular base--------------------//
                
                //----------------------assembly jig holes----------------//
                if(config[11]==1){
                    translate([bl - 18,-0.1,0]) rotate([-90,0,0])
                        cylinder(h=5, d=2);
                }else if(config[11]==2){
                    translate([jd[0]/2+(bl-jd[0]/2-jd[1]/2)/2,-0.1,0]) rotate([-90,0,0])
                        cylinder(h=5, d=2);
                }else if(config[11]==3){
                    translate([jd[0]/2+0.75*p[0]-p[2]+(bl-jd[0]/2-jd[1]/2-p[0]-(0.75*p[0]-p[2]))/2,-0.1,0]) rotate([-90,0,0])
                        cylinder(h=5, d=2);
                }else if(config[11]==4){
                    translate([bl/2,-3.1,0]) rotate([-90,0,0])
                        cylinder(h=(jd[0]+jd[1])/4 +3, d=2);
                }
            }
        }
        //----------------------------------pulleys-----------------------//
        //flexors
        if(config[2]==1){ //empty
            
        }else if(config[2]==2){ //only joint 2
            translate([0,jd[0],0]) rotate([0,0,-atan2(jd[0]-jd[1],bl-jd[1]/2)]) translate([bl-(0.5+f1)*jd[1]-1.5*p[0],0,0])
                pulley(1.5*p[0],1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }else if(config[2]==3){ //default flexor
            translate([jd[0]/2,jd[0],0]) rotate([0,0,-atan2(jd[0]-jd[1],bl-(jd[0]+jd[1])/2)]) translate([f2*jd[0],0,0])
                pulley(bl-(0.5+f2)*jd[0]-(0.5+f1)*jd[1],1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }
        //extensors
        if(config[3]==1 || config[3]==3){ //joint 1
            translate([jd[0]/2,0,0]) rotate([180,0,0])
                pulley(p[0],1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }if(config[3]==2 || config[3]==3){ //joint 2
            translate([bl-jd[1]/2-p[0],0,0]) rotate([180,0,0])
                pulley(p[0],1.5*p[2],p[1],o_fillet=of,t_fillet=true);
        }
        //abductors
        if(config[4]==1 || config[4]==3){ //joint 1
            translate([jd[0]/2-p[2],jd[0]/2,w[0]/2]) rotate([90,0,0])
                pulley(0.75*p[0],p[2],p[1],o_fillet=of,t_fillet=true);
            translate([jd[0]/2-p[2],jd[0]/2,-w[0]/2]) rotate([270,0,0])
                    pulley(0.75*p[0],p[2],p[1],o_fillet=of,t_fillet=true);
        }if(config[4]==2 || config[4]==3){ //joint 2
            trans1 = config[1]==2 ? [bl-jd[1]/2+p[2]-p[0],jd[1]/2,w[1]/2]:[bl-jd[1]/2-0.75*p[0]+p[2],jd[1]/2,w[1]/2];
            pl = config[1]==2 ? p[0]:0.75*p[0];
            translate(trans1) rotate([90,0,0])
                pulley(pl,p[2],p[1],o_fillet=of,t_fillet=true);
            trans2 = config[1]==2 ? [bl-jd[1]/2+p[2]-p[0],jd[1]/2,-w[1]/2]:[bl-jd[1]/2-0.75*p[0]+p[2],jd[1]/2,-w[1]/2];
            translate(trans2) rotate([270,0,0])
                pulley(pl,p[2],p[1],o_fillet=of,t_fillet=true);
        }
        //opposors
        if(config[10]==1){ //index side pulleys
            if(thumb_adj1!=0){ //only generate if adjacent to thumb
                translate([thumb_adj1,jd[1]/2,(w[0]+w[1])/4]) rotate([90,0,0])
                    pulley(p[0],p[2],1.2*p[1],o_fillet=of,t_fillet=true);
            }if(thumb_adj2!=0){
                translate([thumb_adj2,jd[1]/2,-(w[0]+w[1])/4]) rotate([270,0,0])
                    pulley(p[0],p[2],1.2*p[1],o_fillet=of,t_fillet=true);
            }
        }
        if(config[9]==1){ //thumb side pulleys
            if(thumb_side==0){
                translate([bl/2-p[0]/2,jd[0]/2,-(w[0]+w[1])/4]) rotate([270,0,0])
                    pulley(0.75*p[0],p[2],p[1],o_fillet=of,t_fillet=true);
            }else{
                translate([bl/2-p[0]/2,jd[0]/2,(w[0]+w[1])/4]) rotate([90,0,0])
                    pulley(0.75*p[0],p[2],p[1],o_fillet=of,t_fillet=true);
            }
        }
        //---------------------------------ligaments----------------------//
        if(config[8]==1){
            if(config[0]==2){
                lig_ang=30;
                dr=w[0]-w[0]*sin(acos((w[0]/2-lig[0])/w[0]));
                translate([lig[1]+jd[0]/2-(0.5*jd[0]+dr)*cos(lig_ang),jd[0]/2+(jd[0]/2+dr)*sin(lig_ang),w[0]/2-lig[0]]) rotate([0,0,180-ang])
                    cube([1*jd[0],lig[1],lig[0]]);
                translate([lig[1]+jd[0]/2-(0.5*jd[0]+dr)*cos(lig_ang),jd[0]/2+(jd[0]/2+dr)*sin(lig_ang),-w[0]/2]) rotate([0,0,180-ang])
                    cube([1*jd[0],lig[1],lig[0]]);
            }else{
                translate([0.5*jd[0],jd[0]-0.1,w[0]/2-lig[0]]) rotate([0,0,180-ang])
                    cube([2*jd[0],lig[1],lig[0]]);
                translate([0.5*jd[0],jd[0]-0.1,-w[0]/2]) rotate([0,0,180-ang])
                    cube([2*jd[0],lig[1],lig[0]]);
            }
        }
    }
}
