include <config.scad>;

$fn=100;

module torsion() {
	r=torsion_diameter/2;
	thickness=torsion_thickness;
	loops=torsion_rings;


	linear_extrude(height=part_width) polygon(points= concat(
		[for(t = [90:360*loops]) 
		    [(r-thickness+t/90)*sin(t),(r-thickness+t/90)*cos(t)]],
		[for(t = [360*loops:-1:90]) 
		    [(r+t/90)*sin(t),(r+t/90)*cos(t)]]
		    ));
}

module mount() {
	cylinder(d=axle_width+2, part_width);
}

module hole() {
	cube([axle_width, axle_width, part_width*3], center=true);
}

offset1_x = 0;
offset1_y = 0;

offset2_x = 0;
offset2_y = 16;


difference() {
	union() {
		torsion();

		translate([offset1_x, offset1_y, 0]) {
			mount();
		}

		translate([offset2_x, offset2_y, 0]) {
			mount();
		}
	}	

	translate([offset1_x, offset1_y, 0]) {
		hole();
	}

	translate([offset2_x, offset2_y, 0]) {
		hole();
	}



}

