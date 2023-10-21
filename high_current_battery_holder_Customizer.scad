//////////////////////////////////////////////////////////////////////
//               HIGH CURRENT 18650 BATTERY HOLDER                  //
//                          Version 1.1                             //
//                      BY JULIEN COPPOLANI                         //
//////////////////////////////////////////////////////////////////////

// This version has been edited to work with thingiverse customizer

// Designed to work with these metal contacts :
// https://fr.aliexpress.com/item/32946601230.html

/* [General Settings] */

// NUMBER OF 18650 CELLS
NbCells = 4; // [1:30]

// DISPLAYS THE POSITIVE AND NEGATIVE SIGNS ON THE HOLDER
DisplaySigns = 1; // [0, 1]

/* [Additional Settings] */

// ADD A PROTECTION ON THE BOTTOM LEFT
ProtectionBottomLeft = 0; // [0, 1]
// ADD A PROTECTION ON THE BOTTOM RIGHT
ProtectionBottomRight = 0; // [0, 1]
// ADD A PROTECTION ON THE TOP LEFT
ProtectionTopLeft = 0; // [0, 1]
// ADD A PROTECTION ON THE TOP RIGHT
ProtectionTopRight = 0; // [0, 1]


// OTHER PARAMETERS - DO NOT MODIFY
/* [Hidden] */
$fn=32;
Largeur=81;
Hauteur=19.4;
LongueurCell=Largeur-8;
LargeurCell=19;
Longueur=(LargeurCell+2)*NbCells+2;

// MAIN
difference()
{
    cube([Largeur, Longueur, Hauteur]);

    for(i=[0:1:NbCells-1])
    {
        decalage_y = 2+i*(LargeurCell+2);
        // 18650 battery location
        translate([4, decalage_y, 2])
            cube([LongueurCell, LargeurCell, Hauteur]);
        // Left side metal contact location
        translate([2, decalage_y+LargeurCell/2-2.6, 3.6])
            cube([3, 5.2, Hauteur]);
        // Right side metal contact location
        translate([Largeur-5, decalage_y+LargeurCell/2-2.6, 3.6])
            cube([3, 5.2, Hauteur]);
        // Metal contact insertion hole
        translate([-1, decalage_y+LargeurCell/2-2.5, 3.6])
            cube([Largeur+2, 5, 0.6]);
        // Hole on the bottom for ease the removal of the battery
        hull()
        {
            translate([10, decalage_y+LargeurCell/2, -1])
                cylinder(4, 5, 5);
            translate([Largeur-10, decalage_y+LargeurCell/2, -1])
                cylinder(4, 5, 5);
        }
		// Displays the positive and negative signs on the battery holder
        if (DisplaySigns==1)
        {        
            if (i%2==0)
            {
                // Minus sign on the left side
                translate([-0.6,decalage_y+LargeurCell/2-4, 11.4])
                    cube([1, 8, 2]);
                // Plus sign on the right side
                translate([Largeur-0.4,decalage_y+LargeurCell/2-4, 11.4])
                    cube([1, 8, 2]);
                translate([Largeur-0.4,decalage_y+LargeurCell/2-1, 8.4])
                    cube([1, 2, 8]);
            }
            else
            {
                // Minus sign on the right side
                translate([Largeur-0.4,decalage_y+LargeurCell/2-4, 11.4])
                    cube([1, 8, 2]);				
                // Plus sign on the left side
                translate([-0.6,decalage_y+LargeurCell/2-4, 11.4])
                    cube([1, 8, 2]);
                translate([-0.6,decalage_y+LargeurCell/2-1, 8.4])
                    cube([1, 2, 8]);
            }
        }
    }
	// Holes on the edges to lighten the battery case
	for(i=[0:1:5])
	{
		hull()
		{
			translate([12+(Largeur-24)*i/5,-1, 7])
				rotate([-90,0,0])
					cylinder(Longueur+2, 3, 3);
			translate([12+(Largeur-24)*i/5,-1,Hauteur-6])
				rotate([-90,0,0])
					cylinder(Longueur+2, 3, 3);			
		}
	}
}

// Add some protections
if (ProtectionBottomLeft==1)
    translate([-7, 0, 0]) cube([7, 7, Hauteur]);
if (ProtectionBottomRight==1)
	translate([Largeur, 0, 0]) cube([7, 7, Hauteur]);
if (ProtectionTopLeft==1)
    translate([-7, Longueur-7, 0]) cube([7, 7, Hauteur]);
if (ProtectionTopRight==1)
    translate([Largeur, Longueur-7, 0]) cube([7, 7, Hauteur]);
// THE END