///////////////////////////////////////////////////////////////////////////////////////////////////
//                             HIGH CURRENT 18650 BATTERY HOLDER                                 //
//                                     BY JULIEN COPPOLANI                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////


NB_CELLS=14;     // NUMBER OF CELLS
DISPLAY_SIGNS=1; // DISPLAYS THE POSITIVE AND NEGATIVE SIGNS ON THE HOLDER
IS_CONNECTOR=0;  // BONUS : ADD SUPPORT FOR 4MM CONNECTORS
IS_PROTECTION=1; // BONUS : ADD PROTECTIONS

// PARAMETERS - DO NOT MODIFY
$fn=24;
LARGEUR=81;
HAUTEUR=19.4;
LONGUEUR_CELL=LARGEUR-8;
LARGEUR_CELL=19;
LONGUEUR=(LARGEUR_CELL+2)*NB_CELLS+2;


// MAIN
difference()
{
    cube([LARGEUR, LONGUEUR, HAUTEUR]);

    for(i=[0:1:NB_CELLS-1])
    {
        decalage_y = 2+i*(LARGEUR_CELL+2);
        // Emplacement accu 18650
        translate([4, decalage_y, 2])
            cube([LONGUEUR_CELL, LARGEUR_CELL, HAUTEUR]);
        // Emplacement contact métallique côté Gauche
        translate([2, decalage_y+LARGEUR_CELL/2-2.6, 3.6])
            cube([3, 5.2, HAUTEUR]);
        // Emplacement contact métallique côté Droit
        translate([LARGEUR-5, decalage_y+LARGEUR_CELL/2-2.6, 3.6])
            cube([3, 5.2, HAUTEUR]);
        // Passage contact métallique
        translate([-1, decalage_y+LARGEUR_CELL/2-2.5, 3.6])
            cube([LARGEUR+2, 5, 0.6]);
        // Trous sur le dessous pour retirer les accus plus facilement et alléger la structure
        hull()
        {
            translate([10, decalage_y+LARGEUR_CELL/2, -1])
                cylinder(4, 5, 5);
            translate([LARGEUR-10, decalage_y+LARGEUR_CELL/2, -1])
                cylinder(4, 5, 5);
        }
        if (DISPLAY_SIGNS==1)
        {        
            if (i%2==0)
            {
                // Signe Moins - côté Gauche
                translate([-0.4,decalage_y+LARGEUR_CELL/2-4, 11.4])
                    cube([1, 8, 2]);
                // Signe Plus + côté Droit
				if (i != 0) {
                translate([LARGEUR-0.6,decalage_y+LARGEUR_CELL/2-4, 11.4])
                    cube([1, 8, 2]);
                translate([LARGEUR-0.6,decalage_y+LARGEUR_CELL/2-1, 8.4])
                    cube([1, 2, 8]);
				}
            }
            else
            {
                // Signe Moins - côté Droit
                translate([LARGEUR-0.6,decalage_y+LARGEUR_CELL/2-4, 11.4])
                    cube([1, 8, 2]);				
                // Signe Plus + côté Gauche
                translate([-0.4,decalage_y+LARGEUR_CELL/2-4, 11.4])
                    cube([1, 8, 2]);
                translate([-0.4,decalage_y+LARGEUR_CELL/2-1, 8.4])
                    cube([1, 2, 8]);

            }
        }
    }
	// Trous pour alléger la structure sans compromettre la rigidité
	for(i=[0:1:5])
	{
		hull()
		{
			translate([12+(LARGEUR-24)*i/5,-1, 7])
				rotate([-90,0,0])
					cylinder(LONGUEUR+2, 3, 3);
			translate([12+(LARGEUR-24)*i/5,-1,HAUTEUR-6])
				rotate([-90,0,0])
					cylinder(LONGUEUR+2, 3, 3);		
		}
	}
}


// BONUS
HAUTEUR_CONNECTEUR=14;

// Petit boitier qui accueille les 2 connecteurs femelle 4mm
if (IS_CONNECTOR==1)
{
    difference()
    {
        translate([LARGEUR, 0, HAUTEUR-HAUTEUR_CONNECTEUR])
            cube([7, 22, HAUTEUR_CONNECTEUR]);
        translate([LARGEUR+3.5, -1, 9.5])
            rotate([-90, 0, 0])
                cylinder(24, 2.5, 2.5);
        translate([LARGEUR+3.5, -1, 16.5])
            rotate([-90, 0, 0])
                cylinder(24, 2.5, 2.5);
    }
}

// Carrés sur les côtés pour protéger les contacts et soudures
if (IS_PROTECTION==1)
{
	difference()
	{		
		union()
		{
			for(i=[2:1:NB_CELLS-2])
			{
				dec_y = i*(LARGEUR_CELL+2)-2;
				if (i%2==0)
				{
					translate([-7, dec_y, 0])
						cube([7, 7, HAUTEUR]);
				}
				else
				{
					translate([LARGEUR, dec_y, 0])
						cube([7, 7, HAUTEUR]);
				}
			}
		}
		/*translate([-1.5, -1, HAUTEUR/2.4])
			rotate([-90, 0, 0])
				cylinder(LONGUEUR+2, d=3);*/
		// Trous pour faire passer le fil « moins »
		translate([LARGEUR+1.9, -1, 7.2])
			rotate([-90, 0, 0])
				cylinder(LONGUEUR+2, d=3.8, $fn=16);	
	}
	translate([-7, 0, 0])
		cube([7, 7, HAUTEUR]);
	translate([-7, LONGUEUR-7, 0])
		cube([7, 7, HAUTEUR]);
	translate([LARGEUR, LONGUEUR-7, 0])
		cube([7, 7, HAUTEUR]);
	/*if (IS_CONNECTOR==0) {
		translate([LARGEUR, 0, 0])
			cube([7, 7, HAUTEUR]);
	}*/
}
