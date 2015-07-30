include <plywood.scad>;


module vanecutter(length, material, count,edge, offset = 0) {
	margin = 0.03;

	jump = 0;
	step = (length - offset) / (count*2+1);

	for ( i = [0 : count-edge] ) {
		if ( edge == 0 ) {
			translate([ jump * (step - offset) + i * (step+offset) - margin, -0.005,0]) {
				cube([step + margin*2 + offset,material+0.01,material+0.01]);
			}
			jump = i;
		}
		if ( edge == 1 ) {
			jump = i+1;
			translate([ jump * (step + offset) + i * (step-offset) - margin, -0.005,0]) {
				cube([step + margin*2 - offset,material+0.01,material+0.01]);
			}
		}
	}

}


module side(width, height, cuts, sidecut = 0, material = 4.2) {
	difference() {
		plywoodcube(width,height,-1,sidecut,1,sidecut);

		for ( i = [0:cuts-2] ) {
			translate([(i-(cuts/2-1))*(width-material)/cuts,0,0]) {
				difference() {
					translate([4.2/2, -height/2,-0.01])
						rotate(90,[0,0,1])
							vanecutter(height, 4.3, 1, 0, offset=-9);
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
	
	for ( i = [1:cutw-1] ) {
		translate([0,0, (i) * (width-material) / cutw]){
			difference() {
				plywoodcube(depth, height, [0,0,0,0]);
				translate([-depth/2 + material,-height/2, -0.01])
					rotate(90,[0,0,1])
						vanecutter(height, 4.3,1,1, offset=-9);
				translate([depth/2,-height/2, -0.01])
					rotate(90,[0,0,1])
						vanecutter(height, 4.3,1,1, offset=-9);

				for( i = [1:cutd-1] ) {
					translate([-depth / 2 + i*((depth-material)/cutd),-height / 2,-0.04]) {
						cube([material,height/2,material + 0.1]);
					}
				}
				
				translate([-depth/2,-height/2,0])
					vanecutter(depth, material + 0.1, 5,1, offset=-depth/22);
			}
		}
	}

	side(depth,height,cutd,sidecut=1, material = material);
	translate([0,0,width-material])
		side(depth,height,cutd,sidecut=1, material = material);


	for ( i = [1:cutd-1] ) {
		translate([0 - depth/2 + i * (depth-material)/cutd ,0,width/2]){
			rotate(90,[0,1,0])
			difference() {
				plywoodcube(width, height, [0,0,0,0]);
				translate([-width/2 + material,-height/2, -0.01])
					rotate(90,[0,0,1])
						vanecutter(height, 4.3,1,1, offset=-9);
				translate([width/2,-height/2, -0.01])
					rotate(90,[0,0,1])
						vanecutter(height, 4.3,1,1, offset=-9);

				for( i = [1:cutd-1] ) {
					translate([-width / 2 + i*(width - material)/cutw ,0,-0.04]) {
						cube([material,height/2,material + 0.1]);
					}
				}
				
				translate([-width/2,-height/2,0])
					vanecutter(width, material + 0.1, 5,1, offset=-width/22);
			}
		}
	}


	translate([0, -height/2 + material,width/2])
	difference() {
		rotate(90, [0,1,0])
			rotate(90, [1,0,0])
				plywoodcube(width, depth, 0,0,0,0);
		translate([-depth/2,-material, 0]) {
			for( i = [1:cutw-1] ) {
				translate([0,0,-width / 2 + i * (width-material)/cutw])
				vanecutter(depth, material + 0.1, 5,0, offset=-width/22);
			}
			for( i = [1:cutd-1] ) {
				translate([ i * (depth-material)/cutd,0,width/2])
				rotate(90,[0,1,0])
				vanecutter(width, material + 0.1, 5,0, offset=-width/22);
			}
		}
	}

}

box(width = 391, height = 55, depth=331, cutw=3, cutd=2);
