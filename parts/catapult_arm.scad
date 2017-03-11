// Catapult Arm
// Rafi Khan

include <config.scad>;

union() {

	// payload holder
	translate([0, 0, part_width])
	difference() {
		translate([-arm_width/2, -arm_width/2, -part_width])
		cube([arm_width, arm_width, arm_height+part_width]);

		translate([0, 0, arm_width /2  - part_width])
		sphere(d=arm_inside_width);
	}

	// arm
	translate([arm_width/2, -arm_width/2/2, 0])
	union() {
		cube([arm_length, arm_width/2, arm_width/2]);
	}

	// axles
	translate([arm_width/2 + space_after, arm_width/2/2, part_width]) {
		cube([axle_width, axle_length, axle_width]);
	}

	translate([arm_width/2 + space_after + axle_width, -arm_width/2/2, part_width]) {
		rotate([0, 0, 180])
		cube([axle_width, axle_length, axle_width]);
	}
}