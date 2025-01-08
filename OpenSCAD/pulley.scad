//Parametric pulley generator

/*[ STL Configuration ] */
//Facet minimum scale
$fs = 1;  // Don't generate smaller facets than 0.1 mm
//Angle maximum
$fa = 7.5;    // Don't generate larger angles than 3 degrees

//--------------------------------example---------------------------------//
/*[ Global Configurations ] */
//Stage diameters (list length always 5, set excess stages to 0 to remove)
diams = [20.2,20,18,16.8,15.5];
//Spacing
h = 1.5;
//Base diam
b_diam = 25;
//Left/right (0/1) handed
hand = 0;

/*[ QoL ] */
//Max base outer diam
max_b_flange = 33;
//Max base inner diam
max_b_diam = 27.5;
//Base spacing
base_h = 2;
//Anchor pattern diameter
a_diam = 8;
//Pulley cut depth
depth = 1.5;
//Min pulley diameter (anchor placement+anchor diameter+groove+wall)
min_diam = a_diam + 4 + depth + 0.5; //default 14
//Center hole diameter
hole = 5;





//--------------------------------modules---------------------------------//
/* [Hidden] */
//stage types
base = 0;
mid  = 1;
top  = 2;
//stage(22,1.5,type=top,anchors=6,next_diam=20);
module stage(diam,height,type=0,anchors=6,next_diam=0){
    union(){
        difference(){
            //basic shape
            cylinder(height, diam/2, diam/2);
            //pulley groove
            rotate_extrude(angle=type==base?360-12.5-asin(3/diam):360) translate([diam/2,height/2,0]) polygon([[-depth/2,-0.1],[-depth/2,0.1],[depth/2,0.1+depth/tan(55)],[depth/2,-0.1-depth/tan(55)]]);
            translate([0,0,-0.1]) cylinder(height+0.2,hole/2,hole/2);
            //tendon slot
            translate([a_diam/2+2+10/2,0,height/2]) cube([10,3,height-0.8],center=true);
            //tendon hole
            translate([next_diam==0?a_diam/2+1+(1+diam/2-min_diam/2)/2:a_diam/2+1+(1+next_diam/2-min_diam/2)/2,0,height/2]) cube([next_diam==0?(1+diam/2-min_diam/2):(1+next_diam/2-min_diam/2),3,height+0.2],center=true);
            //tendon slot fillet
            translate([diam/2-diam/5,diam/5+1.5-depth/2,0]) rotate([0,0,diam/2-diam/5<min_diam/2-1.5?-90+atan((min_diam/2-1.5-diam/2+diam/5)/(diam/5)):-90]) rotate_extrude(angle=90) translate([diam/5,height/2,0]) polygon([[-depth/2,-0.1],[-depth/2,0.1],[0,height/2-0.4],[3-depth/2,height/2-0.4],[3-depth/2,-height/2+0.4],[0,-height/2+0.4]]);
            //anchors
            for(i=[0:anchors-1]){
                translate([a_diam/2*sin(i*360/anchors+90-180/anchors),a_diam/2*cos(i*360/anchors+90-180/anchors),-0.1]) cylinder(height+0.2,1,1);
                //chamfer on top stage
                if(type==top){
                    translate([a_diam/2*sin(i*360/anchors+90-180/anchors),a_diam/2*cos(i*360/anchors+90-180/anchors),height-2]) cylinder(2.1,0,2.1);
                }
            }
        }
        if(type==base){
            //flange
            rotate([0,0,-12.5-asin(3/diam)]) rotate_extrude(angle=12.5) polygon([[diam/2-0.01,0],[diam/2-0.01,height],[max_b_flange/2,height],[max_b_flange/2,0]]);
        }    
    }
}

module pulley(){
    n_stages=diams[0]==0?0:(diams[1]==0?1:(diams[2]==0?2:(diams[3]==0?3:(diams[4]==0?4:5))));
    difference(){
        union(){
            stage(b_diam<=max_b_diam?b_diam:max_b_diam,base_h,type=0,anchors=n_stages+1,next_diam=diams[0]==0?0:diams[0]);
            for(i=[0:n_stages-2]){
                translate([0,0,base_h+i*h]) stage(diams[i]<=min_diam?min_diam:diams[i],h,type=mid,anchors=n_stages+1,next_diam=diams[i+1]==0?0:diams[i+1]);
            }
            translate([0,0,base_h+(n_stages-1)*h]) stage(diams[n_stages-1]<=min_diam?min_diam:diams[n_stages-1],h,type=top,anchors=n_stages+1);
        }
        //tendon slot
        translate([a_diam/2+1+(min_diam/2-a_diam/2-1.5)/2,0,0]) cube([min_diam/2-a_diam/2-1.5,3,30],center=true);
    }
}


//--------------------------------generating---------------------------------//
if(hand==1){
    mirror([0,1,0]) pulley();
}else{
    pulley();
}