/************************************************************************

	side_cover.scad
    
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
use <BOSL/transforms.scad>

$fn=100;

module blinker_cutout(){
    difference(){
        union(){
            slot([0,0,0], [+15,0,0], r1=6.5, r2=6.5, h=24);
            rotate([-90,0,0]){
                move([17,-4,2.6]) slot([0,0,0], [+15,0,0], r1=8.25, r2=8.25, h=7.8);
                move([36,-11,2.6]) cuboid([7.8,10,7.8]);
            }
             move([27,8,-10]) rotate([0,-80,5]) cyl(h = 40, d = 10, fillet=4);
             move([21,2.5,-8]) rotate([0,0,0]) cube([10,8,8],true);
        }
        
    }
}


module render_side_cover()
{
    difference() {
        union() {
            // Align with 0 Y on inside edge and centre of rear hub
            rotate([90,0,0]) {
                move([35,0,4.5+(104/2)]) {
                    difference() {
                        union() {
                            slot([-40,0,0], [+40,0,0], r1=44/2, r2=44/2, h=9);
                            slot([-40,0,8.5], [+40,0,8.5], r1=44/2, r2=25/2, h=8);
                            move([-50,0,2]) rotate([0,0,-90]){
                                 slot([0,0,0], [+40,0,0], r1=32/2, r2=32/2, h=13);
                                 move([0,0,8]) slot([0,0,8.5], [+40,0,8.5], r1=32/2, r2=25/2, h=21);
                            }
                        }
                        move([-54,-43,19]) rotate([-90,0,90]) blinker_cutout();
                        // Front indentation (designed for 20mm wide ref)
                        move([0,0,13]) {
                            move([10,0,0]) cuboid([99 - 35,20, 2], fillet = 1, edges=EDGES_Z_ALL);
                        }

                        // Bolt sink 1
                        move([30,0,0]) {
                            move([0,0,3]) cyl(h=9+8+2, d=5); // Main screw shaft 1
                            move([0,0,4.5]) cyl(h=14, d=10);
                            move([0,0,14]) cyl(h=6, d=12, chamfer1=1);
                        }

                        // Bolt sink 2
                        move([0,0,0]) {
                            move([0,0,3]) cyl(h=9+8+2, d=5); // Main screw shaft 2
                            move([0,0,4.5]) cyl(h=14, d=10);
                            move([0,0,14]) cyl(h=6, d=12, chamfer1=1);
                        }

                        // Placement pins (4mm dia)
                        //#move([30-24,-8,-2]) cyl(h=6, d=4);
                        //move([30-24,+8,-2]) cyl(h=6, d=4);
                    }
                }
            }
        }

        wheel_nut_cutout();
    }
}

module wheel_nut_cutout()
{
    rotate([90,0,0]) {
        move([35,0,4.5+(104/2)]) {
            // Hole for the wheel nut
           move([-35.5,0,0]) {
               move([-5,0,0]) cyl(h = 20, d = 25);
               move([-10.5,-12,-3]) cube([14,24,26],true); //cyl(h = 26, d = 12);
               move([11,0,0]) cube([33,25,20],true);
               move([51,0,0]) cube([15,20,20],true);
               move([35,12,2]) rotate([0,90,-5]){
                       //cyl(h = 45, d = 10, fillet = 5);
                       move([5,0,1.1]) cuboid([20,8,45], fillet=3); //cube([10,10,45],true);
                       }
           }
           //#move([-55,-0,-5]) cube([10,10,45],true);

           
//           #move([41,0,0]){
//               difference(){
//                    cyl(h = 20, d = 20);
//                    //cylinder(h = 10, r = 10,true);
//                    move([-10,0,0]) cube([20,22,22],true);
//               }
//           }
            
           //slot([-37,0,0], [-32,0,0], r1=10, r2=10, h=10);
        }
    }
}


//blinker_cutout();
    
//render_side_cover();