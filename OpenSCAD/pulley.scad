//Parametric pulley generator

/*[ STL Configuration ] */
//Facet minimum scale
$fs = 0.5;  // Don't generate smaller facets than 0.1 mm
//Angle maximum
$fa = 5;    // Don't generate larger angles than 3 degrees

//--------------------------------example---------------------------------//
/*[ Global Configurations ] */
//Stage diameters (list length always 5, set excess stages to 0 to remove)
diams = [21,19.39,18.25,18.25,15.94];
//Spacing
h = 1.5;
//Base diam
b_diam = 25;
//Left/right (0/1) handed
hand = 1;

/*[ QoL ] */
//Max base outer diam
max_b_flange = 33;
//Max base inner diam
max_b_diam = 27.5;
//Base spacing
base_h = 2;
//Anchor pattern diameter
a_diam = 10;
//Pulley cut depth
depth = 1.5;
//Min pulley diameter (anchor placement+anchor diameter+groove+wall)
min_diam = a_diam + 4 + depth + 0.5; //default 14
//Center hole diameter
hole = 5;





//--------------------------------modules---------------------------------//
/* [Hidden] */
//stage(25,1.5,anchors=6,n=0);
module stage(diam,height,anchors=6,n=0){
    union(){
        difference(){
            //basic shape
            cylinder(height, diam/2, diam/2);
            //pulley groove
            rotate([0,0,n==0?-540/anchors-asin(2/diam):0]) rotate_extrude(angle=n==0?360-12.5-asin(3/diam):360) translate([diam/2,height/2,0]) polygon([[-depth/2,-0.1],[-depth/2,0.1],[depth/2,0.1+depth/tan(55)],[depth/2,-0.1-depth/tan(55)]]);
            d = n==anchors-1?2.3:hole;
            translate([0,0,-0.1]) cylinder(height+0.2,d/2,d/2);
            if(n!=0){
                //tendon slot fillet
                rotate([0,0,(n-anchors)*360/anchors+540/anchors]) translate([diam/2-diam/6,diam/6+1.75-depth/2,0]) rotate([0,0,(diam/2-diam/5<min_diam/2-1.5)&&n!=anchors-1?-90+atan((min_diam/2-1.4-diam/2+diam/5)/(diam/5)):-90]) rotate_extrude(angle=90) translate([diam/6,height/2,0]) polygon([[-depth/2,-0.1],[-depth/2,0.1],[0,height/2-0.4],[1.5-depth/2,height/2-0.4],[1.5-depth/2,-height/2+0.4],[0,-height/2+0.4]]);
            }else{
                //tendon slot
                rotate([0,0,(n-anchors)*360/anchors-540/anchors]) translate([a_diam/2,-1,0.2]) cube([(1+diam/2-a_diam/2),2,height-0.4],center=false); 
                //tendon slot fillet
                rotate([0,0,(n-anchors)*360/anchors-540/anchors]) translate([diam/2-diam/6,diam/6+1-depth/2,0]) rotate([0,0,diam/2-diam/6<min_diam/2-1.5?-90+atan((min_diam/2-1.5-diam/2+diam/6)/(diam/6)):-90]) rotate_extrude(angle=90) translate([diam/6,height/2,0]) polygon([[-depth/2,-0.1],[-depth/2,0.1],[0,height/2-0.2],[2-depth/2,height/2-0.2],[2-depth/2,-height/2+0.2],[0,-height/2+0.2]]);
            }
            //anchors
            for(i=[0:anchors-1]){
                //anchor holes
                d = n==anchors-1&&i!=anchors-1?3.5:2;
                translate([a_diam/2*sin(i*360/anchors+90-180/anchors),a_diam/2*cos(i*360/anchors+90-180/anchors),-0.1]) cylinder(height+0.2,d/2,d/2);
                //tendon cuts
                a = n==anchors-1&&i!=anchors-1?a_diam/2:(i<n?a_diam/2+1.75:diam);
                rotate([0,0,(i-anchors)*360/anchors+900/anchors]) translate([a,0.25,-0.1]) cube([(1+diam/2-a_diam/2),1.5,height+0.2],center=false);
            }
        }
        if(n==0){
            //flange
            rotate([0,0,-540/anchors-12.5-asin(2/diam)]) rotate_extrude(angle=12.5) polygon([[diam/2-0.01,0],[diam/2-0.01,height],[max_b_flange/2,height],[max_b_flange/2,0]]);
        }    
    }
}

module pulley(){
    n_stages=diams[0]==0?0:(diams[1]==0?1:(diams[2]==0?2:(diams[3]==0?3:(diams[4]==0?4:5))));
    difference(){
        union(){
            if(hand==1){
                mirror([0,1,0]) stage(b_diam<=max_b_diam?b_diam:max_b_diam,base_h,anchors=n_stages+1,n=0);
            }else{
                stage(b_diam<=max_b_diam?b_diam:max_b_diam,base_h,anchors=n_stages+1,n=0);
            }
            if(hand==1){
                for(i=[0:n_stages-1]){
                    translate([0,0,base_h+i*h]) stage(diams[i]<=min_diam?min_diam:diams[i],h,anchors=n_stages+1,n=i+1);
                }
            }else{
                mirror([0,1,0]){
                    for(i=[0:n_stages-1]){
                        translate([0,0,base_h+i*h]) stage(diams[i]<=min_diam?min_diam:diams[i],h,anchors=n_stages+1,n=i+1);
                    }
                }
            }
        }
//        //tendon slot
//        translate([a_diam/2+1+(min_diam/2-a_diam/2-1.5)/2,0,0]) cube([min_diam/2-a_diam/2-1.5,3,30],center=true);
//        //tendon pin
//        translate([a_diam/2+3,4,2]) rotate([90,0,0])
//            cylinder(8,1,1);
//        translate([a_diam/2+2,-4,-0.1])
//            cube([2,8,2.1]);
    }
}


//--------------------------------generating---------------------------------//
pulley();