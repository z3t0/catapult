// Trebuchet

$fn=100;

// Config
// Payload
payload_radius = 5;

// Arm
arm_length = 150;
arm_width = 20;
arm_height = 30;
arm_short = arm_length / 4.75;
arm_long = arm_short * 3.75;
arm_hole = 1.5;

// Base
base_distance = 30;
base_width = 20;
base_height = 100;
base_length = 100;
base_angle = atan(base_height / (base_length / 2));
base_support_height = 0.8 * base_height - base_width*2;
base_support_length = (base_height - base_width*2) / tan(base_angle) * 2;
if (base_height >= arm_long) {
	echo("BASE HEIGHT IS TOO LONG");
}


tolerance = 3; // used for hole

// Axle
axle_radius = 5;
axle_length = (base_width + base_distance) * 2  + arm_width;

// 0 : all
// 1 : payload
// 2 : arm
// 3 : base
// 4 : axle
mode = 0;

// Axle
if (mode == 0 || mode == 4) {
	if (mode == 4) {
		axle();
	}

	else if (mode == 0) { 

		difference() {
		translate([+arm_long, base_width/2 + base_distance, base_height - axle_radius/2 - base_width / 2]) {
			rotate([0, 0, 90]) {
				axle();
			}
		}
		translate([-base_width, +base_width/2, base_height - axle_radius - base_width / 2])
			cube([base_width * 3, axle_radius, axle_radius]);
			
	}
	}
}

module axle() {
	translate([-axle_length/2 + arm_width/2, arm_long]){
		rotate([0, 90, 0]){
			cylinder(r = axle_radius, h = axle_length);
		}
	}
}

// Arm
if (mode == 0 || mode == 2) {
	if(mode == 2)
	arm();

	else if (mode == 0) {
		translate([+arm_long, base_width/2 + base_distance, base_height - axle_radius/2 - base_width / 2 - arm_height/2]) {
			rotate([0, 0, 90]) {
				arm();
			}
		}
	}		
}

module arm(){
	union() {
		difference() {
			// the arm
			cube([arm_width, arm_length, arm_height]);

			// axle hole
			translate([0, arm_long, arm_height/2]){
				rotate([0, 90, 0]){
					cylinder(r = axle_radius, h = arm_width * 2);
				}
			}

			// counterweight hole
			translate([0, arm_length - arm_hole - tolerance, arm_height/2]){
				rotate([0, 90, 0]){
					cylinder(r = arm_hole, h = arm_width * 2);
				}
			}

			// payload hole
			translate([0, arm_hole + tolerance, arm_height/2]){
				rotate([0, 90, 0]){
					cylinder(r = arm_hole, h = arm_width * 2);
				}
			}
		}
	}
}

// Base
if (mode == 0 || mode == 3) {
	if (mode == 3)
	base();
	else if (mode == 0) {
		difference() {

			base();
			translate([-base_width, +base_width/2, base_height - axle_radius - base_width / 2])
			cube([base_width * 3, axle_radius, axle_radius]);

		}
		translate([0, base_distance + arm_width + base_distance], 0) {
			base();

		}
	}
}

module base() {
	difference() {
		union() {
			prism(base_width, base_length, base_height);
			mirror([1, 0, 0])
			prism(base_width, base_length, base_height);
		}
		prism(base_width, base_length - base_width, base_height - base_width);
		mirror([1, 0, 0])
		prism(base_width, base_length - base_width, base_height - base_width);

		translate([0, +base_width, base_height - axle_radius/2 - base_width / 2]) {
			rotate([90, 0, 0]) {
				cylinder(r= axle_radius+0.5, h=base_width*2);
			}
		}
	}

	translate([-base_support_length / 2 - base_width / 2, 0, base_support_height]) {
		cube([base_support_length + base_width, base_width, base_width]);
	}
}

//Draw a prism based on a 
//right angled triangle
//l - length of prism
//w - width of triangle
//h - height of triangle
module prism(l, w, h) {
	polyhedron(points=[
		[0,0,h],           // 0    front top corner
		[0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
		[0,l,h],           // 3    back top corner
		[0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
		], faces=[ // points for all faces must be ordered clockwise when looking in
		[0,2,1],    // top face
		[3,4,5],    // base face
		[0,1,4,3],  // h face
		[1,2,5,4],  // w face
		[0,3,5,2],  // hypotenuse face
		]);
}

// Payload
if(mode == 1) {
	sphere(r=payload_radius);
}