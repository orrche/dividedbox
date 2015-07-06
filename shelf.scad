include <plywood.scad>;



module side(width, height, cuts, sidecut = 0, material = 4.2) {
	difference() {
		plywoodcube(width,height,-1,sidecut,1,sidecut);

		for ( i = [0:cuts-2] ) {
			translate([(i-(cuts/2-1))*(width - 4.2*2)/cuts,0,0]) {
				difference() {
					translate([4.2/2, -height/2,-0.01])
						rotate(90,[0,0,1])
							cutter(height, 4.3, 2, 0);
					translate([-15/2,-15/2,-0.01])
						cube([15,15,15]);
				}
			}
		}
	}
}

module box(width = 391, height = 55, depth=331, cutw=4, cutd = 2, material = 4.2) {
	translate([-depth/2,0,width/2]) {
		rotate(90, [0,1,0]) {
			translate([0,0,depth-material])
				side(width,height,cutw, material = material);
			side(width,height,cutw, material = material);
		}
	}
	side(depth,height,cutd,sidecut=1, material = material);
	translate([0,0,width-material])
		side(depth,height,cutd,sidecut=1, material = material);


	translate([0, -height/2 + material ,width/2])
	rotate(90, [0,1,0])
		rotate(90, [1,0,0])
			plywoodcube(width, depth, 0,0,0,0);

}

box(width = 391, height = 55, depth=331);
