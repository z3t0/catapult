
// general
part_width = 5;

entire_length = 100;

// parameters
arm_width = 27;
arm_inside_width =22;
arm_length = 100-arm_width; //length of the extension
arm_height = 10;

// space before and after
space_after = arm_length * 0.6; // btwn holder and axle
axle_width = 3;
axle_length = 15;

// sidebar
sidebar_bottom = entire_length - (arm_width + space_after + axle_width);
sidebar_height = sidebar_bottom + 10; // 10: is a constant
sidebar_width = 30;

holder_length = 5;

// torsion
torsion_diameter = 1;
torsion_rings = 4;
torsion_thickness = 1;
torsion_depth = part_width;