// sidebar
// Rafi Khan

include <config.scad>;

union() {

	// side
	cube([sidebar_width, part_width, sidebar_height]);

	//holder
	translate([sidebar_width/2 - axle_width/2, part_width, sidebar_bottom])
	cube([axle_width, holder_length, axle_width]);

}