$fn=50;

/*x = 48 - 15;
y = 49 - 15;*/
x = 30;
y = 30;
z = 2;

cubeStartX = 0;
cubeStartY = 0;
cubeStartZ = 1;

heightOfCylinder = 1;
diameterOfCylinder = 6;

//Because we're using minkowski sum, the outer dimensions will be greater,
//so subtract the dimentions of the cylinder.
size = [x - diameterOfCylinder, y - diameterOfCylinder, z - heightOfCylinder];

//Order is bottom left, top left, top right, bottom right
holeLocations = [
[3, 3, 0],
[cubeStartX + 3, y - 3, 0],
[x - 3, y - 3, 0],
[x - 3, cubeStartY + 3, 0]
];
rotate([0, 180, 0]) {
    difference(){
        
        minkowski(){
            translate([cubeStartX,cubeStartY,cubeStartZ])
            cube(size);
            
            //rounds the corners
            translate([3, 3, 0])
            cylinder(h=heightOfCylinder, d=diameterOfCylinder);
        }

        //minus

        for (i = [0:3]) {
            //smaller hole for middle layer
            translate(holeLocations[i] + [0, 0, 1])
            cylinder(h=1, d = 2);

            //bigger hole on top for screw
            translate(holeLocations[i] + [0, 0, 2])
            cylinder(h=1, d = 4);
        }
        
        //middle holes
        bigHoleDiameter = 6.5;
        mediumHolesDiameter = 3;
        smallerHolesDiameter = 2;
        
        translate([x/2, y/2, 1])
        cylinder(h = 2, d = bigHoleDiameter);
        
        translate([x/2, y/2 + bigHoleDiameter/2 + mediumHolesDiameter/2 + 2, 1])
        cylinder(h = 1, d = mediumHolesDiameter);
        
        translate([x/2, y/2 - bigHoleDiameter/2 - mediumHolesDiameter/2 - 2, 1])
        cylinder(h = 1, d = mediumHolesDiameter);
        
        translate([x/2, y/2 + bigHoleDiameter/2 + mediumHolesDiameter/2 + 2, 2])
        cylinder(h = 1, d = smallerHolesDiameter);
        
        translate([x/2, y/2 - bigHoleDiameter/2 - mediumHolesDiameter/2 - 2, 2])
        cylinder(h = 1, d = smallerHolesDiameter);
        
    }

    //bottom cylinders
    for (i = [0:3]) {
        difference(){
            //bottom big cylinder
            translate(holeLocations[i])
            cylinder(h=1, d = 6);
            
            //hole for bottom big cylinder
            translate(holeLocations[i])
            cylinder(h=1, d = 2);
        }
    }
}
