$fn=32;

// Reinforcing rib
module support(angle) {
    rotate([0,0,angle]) {
        hull() {
            translate([0,0.5,2])
                cube([1,1,4], center=true);
            translate([0,2,0.5])
                cube([1,4,1], center=true);
        }
    }
}

// Reinforced boss for (M3) screws. Diameter and Thickness are adjustable.
module screwpost(dia, thick) {
    translate([0,0,thick/2])
    difference() {
        union() {
            hull() {
                translate([0,0,-thick/2+1])
                    cube([1,dia*3,0.1],center=true);
                cube([1,dia,thick],center=true);
            }
            hull() {
                translate([0,0,-thick/2+1])
                    cube([dia*3,1,0.1],center=true);
                cube([dia,1,thick],center=true);
            }
            cylinder(d=dia+2, h=thick, center=true);
        }
        cylinder(d=dia, h=thick+1, center=true);
    }
}

// Screw clearance module for M3 Tapered head screws
module screwclear() {
    union() {
        translate([0,0,7.5])
            cylinder(d=3.2, h=15, center=true);
        hull() {
            translate([0,0,1.5])
                cylinder(d=3.2, h=0.1, center=true);
            cylinder(d=6, h=0.1, center=true);
        }
    }
}

module casebottom() {
    difference() {
        union() {
            translate([0,0,3]) {
                minkowski() {
                    cube([146-7,80-7,3], center=true);
                    cylinder(d=9, h=3, center=true);
                }
            }
            // Seam relief, makes imperfections in the seam less noticable
            translate([0,0,3.25]) {
                minkowski() {
                    cube([146-7.5,80-7.5,3.5], center=true);
                    cylinder(d=9, h=3, center=true);
                }
            }
        }
        translate([0,0,6]) {
            minkowski() {
                cube([146-7,80-7,4], center=true);
                cylinder(d=7, h=4, center=true);
            }
        }
    }
    
    // Reinforcing Ribs
    for(x = [-62.5:5:62.5]) {
        translate([x,41,0]) {
            support(180);
        }
        translate([x,-41,0]) {
            support(0);
        }
    }
    for(y = [-14 : -5 : -29]) {
        translate([74,y,0]) {
            support(90);
        }
        translate([-74,y,0]) {
            support(-90);
        }
    }
    for(y = [-0.5 : 5 : 29.5]) {
        translate([74,y,0]) {
            support(90);
        }
        translate([-74,y,0]) {
            support(-90);
        }
    }

    // Peak array for the 20.32mm x 20.32mm positions
    for(xa = [0 : 25.4 : 25.4*3]) {
        for(xb = [0 : 20 : 20]) {
            for(y = [0 : 20 : 20]) {
                translate([(138.43/2)-38.1-xa-xb,(-72.39/2)+29.21-5.08-y,0]) {
                    screwpost(3,5);
                }
            }
        }
    }

    // Screws thread in here
    translate([(-138.43/2),(-72.39/2),0])
        screwpost(3,5);
    translate([(-138.43/2),(72.39/2),0])
        screwpost(3,5);
    translate([(-138.43/2),(-72.39/2)+29.21,0])
        screwpost(3,5);
    translate([(138.43/2),(-72.39/2)+29.21,0])
        screwpost(3,5);
    translate([(138.43/2),(-72.39/2),0])
        screwpost(3,5);
    translate([(138.43/2),(72.39/2),0])
        screwpost(3,5);
}

module casetop() {
    difference() {
        union() {
            difference() {
                translate([0,0,4.5]) {
                    minkowski() {
                        cube([146-7,80-7,7], center=true);
                        cylinder(d=9, h=2, center=true);
                    }
                }
                translate([0,0,7]) {
                    minkowski() {
                        cube([146-7,80-7,10], center=true);
                        cylinder(d=7, h=1, center=true);
                    }
                }
            }
            
            // Reinforcing bosses / spacers for the M3 screws
            translate([(-138.43/2),(-72.39/2),0])
                screwpost(3.2,9);
            translate([(138.43/2),(-72.39/2),0])
                screwpost(3.2,9);
            translate([(-138.43/2),(72.39/2),0])
                screwpost(3.2,4);
            translate([(138.43/2),(72.39/2),0])
                screwpost(3.2,4);
            translate([(-138.43/2),(-72.39/2)+29.21,0])
                screwpost(3.2,4);
            translate([(138.43/2),(-72.39/2)+29.21,0])
                screwpost(3.2,4);
        }

        // Opening for Keys
        translate([0,(72.39/2)-21.59,0]) {
            cube([133.35+0.5,38.1+0.5,10], center=true);
        }
        // Opening for USB-C
        translate([(-145/2),(-72.39/2)+(29.21/2),7.15]) {
            cube([10,6,3.75], center=true);
        }

        // Screw reliefs on the top
        translate([(-138.43/2),(-72.39/2),0])
            screwclear();
        translate([(-138.43/2),(72.39/2),0])
            screwclear();
        translate([(-138.43/2),(-72.39/2)+29.21,0])
            screwclear();
        translate([(138.43/2),(-72.39/2)+29.21,0])
            screwclear();
        translate([(138.43/2),(-72.39/2),0])
            screwclear();
        translate([(138.43/2),(72.39/2),0])
            screwclear();
    }
    
    // Reinforcing Ribs
    for(x = [-62.5:5:62.5]) {
        translate([x,41,0]) {
            support(180);
        }
        translate([x,-41,0]) {
            support(0);
        }
    }
    for(y = [-14 : -5 : -29]) {
        translate([74,y,0]) {
            support(90);
        }
        translate([-74,y,0]) {
            support(-90);
        }
    }
    for(y = [-0.5 : 5 : 29.5]) {
        translate([74,y,0]) {
            support(90);
        }
        translate([-74,y,0]) {
            support(-90);
        }
    }

}

translate([0,-45,0])
rotate([0,0,180])
    casetop();

translate([0,45,0])
casebottom();