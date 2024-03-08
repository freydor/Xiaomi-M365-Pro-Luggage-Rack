/************************************************************************

	rack.scad
    
	Xiaomi M365 Pro Luggage rack
    Copyright (C) 2020 Simon Inns
    
    This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
    Email: simon.inns@gmail.com
    
************************************************************************/

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/threading.scad>
use <BOSL/transforms.scad>

include <side_cover.scad>
include <m3insert.scad>

module rack_surface_attachment_sockets(surface_height)
{
        // Attachment sockets (0.2mm larger than the posts)
        // Posts are 7mm high
        // new width 144
        move([-83,78.1,surface_height - 11.5 + 8]) cuboid([11.2, 12.2, 9]);
        #move([+75,78.1,surface_height - 11.5 + 8]) cuboid([11.2, 12.2, 9]);
        move([-83,-78.1,surface_height - 11.5 + 8]) cuboid([11.2, 12.2, 9]);
        move([+45,-78.1,surface_height - 11.5 + 8]) cuboid([11.2, 12.2, 9]);

        // Attachment screw holes
        move([-83,78.1,surface_height]) cyl(h=16, d=3.2);
        move([+75,78.1,surface_height]) cyl(h=16, d=3.2);
        move([-83,-78.1,surface_height]) cyl(h=16, d=3.2);
        move([+45,-78.1,surface_height]) cyl(h=16, d=3.2);

        move([-83,78.1,surface_height + 5]) cyl(h=4, d=6.2);
        move([+75,78.1,surface_height + 5]) cyl(h=4, d=6.2);
        move([-83,-78.1,surface_height + 5]) cyl(h=4, d=6.2);
        move([+45,-78.1,surface_height + 5]) cyl(h=4, d=6.2);
}

module rack_box_fastener()
{
    difference() {
        move([0,0,0]) cyl(h=12, d=28);
        move([0,0,0]) trapezoidal_threaded_rod(d=16, l=30, pitch=2, thread_angle=15, internal = true, $fn=32);
    }
}

module rack_surface()
{
    // Rack surface (note 200x250 is max bed size on the prusa i3)
    hi3 = 150;
    yoffset = -12;

    difference() {
        // Main surface shape
        move([yoffset + 8,0,hi3]) cuboid([224,178,12], chamfer = 4, edges=EDGES_TOP+EDGES_Z_ALL);

        move([yoffset + 87,-12,hi3]) cuboid([70,70,14]);
        move([yoffset + 87,-12,hi3+9]) cuboid([70+8,70+8,14], chamfer = 4, edges=EDGES_BOTTOM+EDGES_Z_ALL);
        
        move([yoffset + 102,-67,hi3]) cuboid([60,70,14]);
        move([yoffset + 102,-67,hi3+9]) cuboid([60+8,70+8,14], chamfer = 4, edges=EDGES_BOTTOM+EDGES_Z_ALL);

        //move([yoffset + 8,83,hi3+4]) cuboid([224 - 24,28,8]); // Left drop
        //#move([yoffset -16,-83,hi3+4]) cuboid([176 - 24,28,8]); // Right drop

        rack_surface_attachment_sockets(hi3);

        // Trim edges
        move([yoffset + 120.5,17,hi3]) rotate([0,0,45]) cuboid([14,14,14]);
        move([yoffset + 125, 19+3,hi3+5]) rotate([45,0,45]) cuboid([16,18,14]);

        move([yoffset + 73,-95,hi3]) rotate([0,0,45]) cuboid([14,14,14]);
        move([yoffset + 73,-95,hi3+5]) rotate([45,0,45]) cuboid([18,18,14]);

        move([yoffset + 73,-42,hi3]) rotate([0,0,45]) cuboid([14,14,14]);
        move([yoffset + 74,-43,hi3+5]) rotate([0,45,45]) cuboid([18,18,14]);

        // Cut outs
        //#move([yoffset + 44,74,hi3]) cuboid([128,10,14]); // Left hook spacer front
        //#move([yoffset - 62,74,hi3]) cuboid([60,10,14]); // Left hook spacer back

        //#move([yoffset + 20,-74,hi3]) cuboid([80,10,14]); // Right hook spacer front
        //#move([yoffset - 62,-74,hi3]) cuboid([60,10,14]); // Right hook spacer back

        move([yoffset + 10,26.75,hi3]) cuboid([60,41.5,14]); // Middle front left
        move([yoffset + 10,-26.75,hi3]) cuboid([60,41.5,14]); // Middle front right

        move([yoffset - 62,41,hi3]) cuboid([60,13,14]); // Middle back left
        move([yoffset - 62,0,hi3]) cuboid([60,45,14]); // Middle back
        move([yoffset - 62,-41,hi3]) cuboid([60,13,14]); // Middle back right
        
        move([yoffset + 80,41,hi3]) cuboid([56,13,14]); // Front Left

        // Chamfer cutouts
        move([0,0,9]) {
            chm = 4;

            //#move([yoffset + 8,83,hi3]) cuboid([224 - 24 + chm,28 + chm,14], chamfer = chm, trimcorners = false); // Left drop
            //#move([yoffset -16,-83,hi3]) cuboid([176 - 24 + chm,28 + chm,14], chamfer = chm, trimcorners = false); // Right drop


            move([yoffset + 10,26.75,hi3]) cuboid([60 + chm,41.5 + chm,14], chamfer = chm, trimcorners = false); // Middle front left
            move([yoffset + 10,-26.75,hi3]) cuboid([60 + chm,41.5 + chm,14], chamfer = chm, trimcorners = false); // Middle front right

            move([yoffset - 62,41,hi3]) cuboid([60 + chm,13 + chm,14], chamfer = chm, trimcorners = false); // Middle back left
            move([yoffset - 62,0,hi3]) cuboid([60 + chm,45 + chm,14], chamfer = chm, trimcorners = false); // Middle back
            move([yoffset - 62,-41,hi3]) cuboid([60 + chm,13 + chm,14], chamfer = chm, trimcorners = false); // Middle back right
            
            move([yoffset + 80,41,hi3]) cuboid([56 + chm,13 + chm,14], chamfer = chm, trimcorners = false); // Front Left

            move([yoffset + 8,83 + 20,hi3 - 4]) cuboid([224 - 24,28 + chm,14], chamfer = chm / 2, trimcorners = false, edges = EDGE_BOT_FR); // Left drop
            move([yoffset -16,-83 - 20,hi3 - 4]) cuboid([176 - 24,28 + chm,14], chamfer = chm / 2, trimcorners = false, edges = EDGE_BOT_BK); // Right drop
        }

        // Fastener thread cutouts
        move([-98,0,148]) cyl(h=18, d=28);
        move([20,75,148]) cyl(h=18, d=28);
        move([20,-75,148]) cyl(h=18, d=28);

        // Inset for refective strip
        move([-116.5,0,149]) cuboid([4, 166, 8], chamfer = 1);

        // M3 Inserts for rear accessory attachment
        move([-110,28.5,144]) rotate([0,180,0]) m3insert();
        move([-110,-28.5,144]) rotate([0,180,0]) m3insert();
    }

    // Fastener threads
    move([-98,0,150]) rack_box_fastener();
    move([20,75,150]) rack_box_fastener();
    move([20,-75,150]) rack_box_fastener();
}
    
module crossbar_deco()
{
    move([8,59,100]) cuboid([12,18,8]);
    move([8,59 + 14,100]) cuboid([14,18,10], chamfer = 2, trimcorners = false);
}

module rack_frame_left()
{
    difference() {
        union() {
            // Left side stays
            difference() {
                union() {
                    rotate([0,-30,0]) move([0,+59,105]) cuboid([14, 14,132], fillet=3, edges=EDGE_BK_LF+EDGE_BK_RT); // Back
                    move([-83.5,118,74]) rotate([0,0,0]) move([0,-59,103]) cuboid([16, 14,65], fillet=3, edges=EDGE_BK_LF+EDGE_BK_RT); // Back

                    
                    move([75,0,15]) rotate([0,0,0]) move([0,+59,89]) cuboid([14, 14,200], fillet=3, edges=EDGE_BK_LF+EDGE_BK_RT); // Front
                }
                
                // Slice top edge flat
                move([0,60,213]) cuboid([220, 18,18]);
            }
            
            // Cross bar
            move([8,59,100]) cuboid([130, 14,18], fillet=3, edges=EDGE_TOP_BK+EDGE_BOT_BK);

            // Side cover
            rotate([180,0,0]) render_side_cover();

            // Attachment posts
            move([-83,58,213 - 5.5]) cuboid([11, 12, 7], chamfer=0.5, edges=EDGES_TOP+EDGE_FR_LF+EDGE_BK_LF+EDGES_TOP+EDGE_FR_RT+EDGE_BK_RT);
            move([+75,58,213 - 5.5]) cuboid([11, 12, 7], chamfer=0.5, edges=EDGES_TOP+EDGE_FR_LF+EDGE_BK_LF+EDGES_TOP+EDGE_FR_RT+EDGE_BK_RT);
        }

        // Ensure clearance for wheel nut
        rotate([180,0,0]) wheel_nut_cutout();

        // Left side stay decoration
        move([0,7.5,0]) {
            //#rotate([0,-30,0]) move([0,+59,98]) cuboid([14 - 8, 2,160], chamfer = 0.5); // Back
            move([75,0,21]) rotate([0,0,0]) move([0,+59,65]) cuboid([14 - 8, 2,140], chamfer = 0.5); // Front
        }

        // Cross bar decoration
        offset1 = 3;
        move([-40 + offset1,0,0]) crossbar_deco();  
        move([-20 + offset1,0,0]) crossbar_deco();  
        move([0 + offset1,0,0]) crossbar_deco();
        move([20 + offset1,0,0]) crossbar_deco();
        move([40 + offset1,0,0]) crossbar_deco();  

        // M3 Inserts for attachment posts
        move([-83,58,211]) m3insert();
        move([75,58,211]) m3insert();

        // M3 Inserts for accessories
//        rotate([0,180,0]) {
//            move([-66 + 5,56.5,16]) m3insert();
//            move([-23 + 5,56.5,16]) m3insert();
//        }
    }
}

module rack_frame_right()
{
    difference() {
        union() {
            // Right side stays
            difference() {
                union() {
                    rotate([0,-30,0]) move([0,-59,104]) cuboid([14, 14,132], fillet=3, edges=EDGE_FR_LF+EDGE_FR_RT); // Back
                    move([-83,0,73]) rotate([0,0,0]) move([0,-59,103]) cuboid([16, 14,65], fillet=3, edges=EDGE_FR_LF+EDGE_FR_RT); // Back
                    
                    move([45,0,15]) rotate([0,0,0]) move([0,-59,89]) cuboid([14, 14,200], fillet=3, edges=EDGE_FR_LF+EDGE_FR_RT); // Front
                }

                // Slice top edge flat
                move([0,-60,213]) cuboid([250, 18,18]);
            }
            
            // Crossbar
            move([-5,-59,100]) cuboid([104, 14,18], fillet=3, edges=EDGE_TOP_FR+EDGE_BOT_FR); 

            // Side cover
            mirror([0,0,1]) render_side_cover();

            // Attachment posts
            move([-83,-58,213 - 5.5]) cuboid([11, 12, 7], chamfer=0.5, edges=EDGES_TOP+EDGE_FR_LF+EDGE_BK_LF+EDGES_TOP+EDGE_FR_RT+EDGE_BK_RT);
            move([+45,-58,213 - 5.5]) cuboid([11, 12, 7], chamfer=0.5, edges=EDGES_TOP+EDGE_FR_LF+EDGE_BK_LF+EDGES_TOP+EDGE_FR_RT+EDGE_BK_RT);
        }

        // Ensure clearance for wheel nut
        mirror([0,0,1]) wheel_nut_cutout();

        // Right side stay decoration
        move([0,-7.5,0]) {
            //rotate([0,-30,0]) move([0,-59,98]) cuboid([14 - 8, 2,160], chamfer = 0.5); // Back
            move([45,0,21]) rotate([0,0,0]) move([0,-59,65]) cuboid([14 - 8, 2,140], chamfer = 0.5); // Front
        }

        // Cross bar decoration
        rotate([0,0,180]) {
            offset1 = 7;
            move([-40 + offset1,0,0]) crossbar_deco();  
            move([-20 + offset1,0,0]) crossbar_deco();  
            move([0 + offset1,0,0]) crossbar_deco();
            move([20 + offset1,0,0]) crossbar_deco();
        }

        // M3 Inserts for attachment posts
        move([-83,-58,211]) m3insert();
        move([45,-58,211]) m3insert();
    }  
}

module render_rack(show_surface, show_left, show_right, render_for_display)
{
    color("orange") {
        if (show_left) {
            if (render_for_display) {
                rack_frame_left();
            } else {
                rotate([90,0,0]) move([0,-52,0]) rack_frame_left();
            }
        }

        if (show_right) {
            if (render_for_display) {
                rack_frame_right();
            } else {
                rotate([-90,0,0]) move([0,52,0]) rack_frame_right();
            }
        }
        
        if (show_surface) {
            if (render_for_display) {
                rack_surface();
            } else {
                move([0,0,-144]) rack_surface();
            }
        }
    }
}

//render_rack(false, false, true, false);
render_rack(true, false, false, false);

//render_rack(false, true, false,false);

//move([0,0,-150]) rotate([180,0,0]) render_rack(false, true, false,false);
