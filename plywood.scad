module cutter(length, material, count,edge) {
	margin = 0.03;

	for ( i = [0 : count-edge] ) {
		translate([ (i*2+edge) * (length/(count*2+1)) - margin, -0.005,0]) {
			cube([length / (count*2+1) + margin*2,material+0.01,material+0.01]);
		}
	}

}

module plywoodcube(width, height, cut1, cut2, cut3, cut4, ratio=20, materialsize=4.2) {
	translate([-width/2, -height/2, 0]) {
		difference() {
			c1count = round(width / (ratio) - 1);
			c3count = c1count;
			c2count = round(height / ratio - 1);
			c4count = c2count;

			cube([width,height, materialsize]);

			if ( cut1 >= 0 ) 
				translate([0,height - materialsize,-materialsize*0.001])
					cutter(width,materialsize, c1count, cut1);

			if ( cut3 >= 0 )
				translate([0,0,-materialsize*0.001])
					cutter(width,materialsize, c3count, cut3);
			if ( cut2 >= 0 )
				translate([width,0,-materialsize*0.001])
					rotate(90,[0,0,1])
						cutter(height,materialsize, c2count, cut2);
			if ( cut4 >= 0 )
				translate([materialsize,0,-materialsize*0.001])
					rotate(90,[0,0,1])
						cutter(height,materialsize, c4count, cut4);
		}
	}

}

