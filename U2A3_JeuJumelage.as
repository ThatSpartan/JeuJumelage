/*
Nom du fichier : U2A3_JeuJumelage.as
Programmeur : Dominik Dumas
Date : 4 mars 2018
Description : Le but de cette application est de créer un jeu de jumelage.
*/

package {
	import flash.display.*;
	
	// code ajouté à la fin de la pratique 3
	import flash.events.*;
	// fin de code ajouté à la fin de pratique 3
	
	public class U2A3_JeuJumelage extends MovieClip {
		// déclarer des constantes pour régler les dimensions de la planche de jeu
		
		MovieClip(root).gotoAndStop('finPartie');
		
		private static const RANGS:int = 4;
		private static const COLONNES:int = 4;
		private static const RANG_HAUTEUR:Number = 85;
		private static const COLONNE_LARGEUR:Number = 85;
		private static const RANG_DECALAGE:Number = 60;
		private static const COLONNE_DECALAGE:Number = 10;
		
		private var cartesRestantes:int = RANGS*COLONNES;
		
		// code ajouté à la pratique 4 - première étape
		private var carteUn:Cartes;
		private var carteDeux:Cartes;
		// fin code ajouté à la pratique 4 - première étape
		
		public function U2A3_JeuJumelage():void
		{
			
			// code ajouté à la pratique2 - première étape
			
			var totalCartes:int = RANGS * COLONNES / 2;
			var paquetCartes:Array = new Array();
			
			for (var i:int = 0; i < totalCartes; i++)
			{
				paquetCartes.push(i);
				paquetCartes.push(i);
			} // fin for loop
			
			// fin code ajouté à la pratique2 - première étape
			
			// créer et afficher une planche de jeu de 4 tangées par 4 colonnes
			
			for (var c:int = 0; c < COLONNES; c++)
			{
				for (var r:int = 0; r < RANGS; r++)
				{
					var affichageCarte:Cartes = new Cartes();
					affichageCarte.stop();
					affichageCarte.x = c * COLONNE_LARGEUR + COLONNE_DECALAGE;
					affichageCarte.y = r * RANG_HAUTEUR + RANG_DECALAGE
					
					// code ajouté à la pratique2 - troisième étape
					
					var noRang = Math.floor(Math.random()*paquetCartes.length);
					affichageCarte.rectoCarte = paquetCartes[noRang];
					paquetCartes.splice(noRang, 1);
					//affichageCarte.gotoAndStop(affichageCarte.rectoCarte+2);
					
					// code ajouté à la fin de la preatique 3
					affichageCarte.addEventListener(MouseEvent.CLICK, clickSouris);
					// fin de code ajouté à la fin de pratique 3
					
					// fin code ajouté à la pratique2 - troisième étape
					
					addChild(affichageCarte)
				} // fin boucle for interieure
			} // fin boucle for extérieure
			
		} // fin function jeu jumelage
		
		private function clickSouris(event:MouseEvent)
		{
			/*
			code pour tests
			var carteChoisie:Cartes = (event.currentTarget as Cartes);
			carteChoisie.gotoAndStop(carteChoisie.rectoCarte+2);
			trace(carteChoisie.rectoCarte);
			*/
			
			// code ajouté à la pratique 4 - troisième étape
			var carteChoisie:Cartes = (event.currentTarget as Cartes);
			
			// condition 1 - première carte sélectionné
			if (carteUn == null)
			{
				// assigner à la variable la carte 1
				carteUn = carteChoisie;
				// afficher la première carte
				carteUn.gotoAndStop(carteChoisie.rectoCarte+2);
			}
			
			// vérifier si la carte un est cliqué à nouveau
			else if (carteUn == carteChoisie)
			{
				// afficher le verso de la carte
				carteUn.gotoAndStop(1);
				// réinitialiser la variable carteUn
				carteUn = null;
			} // fin de condition 1
			
			// condition 2 - deuxième carte sélectionné
			else if (carteDeux == null)
			{
				// assigner à la variable la carte 2
				carteDeux = carteChoisie;
				// afficher la deuxième carte
				carteDeux.gotoAndStop(carteChoisie.rectoCarte+2);
				
				if (carteUn.rectoCarte == carteDeux.rectoCarte)
				{
					// jumelage - suppirmer les deux cartes
					removeChild(carteUn);
					removeChild(carteDeux);
					
					// réinitialiser les deux variables
					carteUn = null;
					carteDeux = null;
					
					cartesRestantes = cartesRestantes - 2;
					if (cartesRestantes == 0)
					{
						MovieClip(root).gotoAndStop('finPartie');
					}
				}
			} // fin de condition 2
			
			// condition 3 - aucun jumelage
			else
			{
				// réinitialiser les cartes de la paire précédente
				carteUn.gotoAndStop(1);
				carteDeux.gotoAndStop(1);
				carteDeux = null;
				
				// selectionner et afficher la première carte
				carteUn = carteChoisie;
				carteUn.gotoAndStop(carteChoisie.rectoCarte+2);
			} // fin de condition 3
			
			// fin code ajouté à la pratique 4 - troisième étape
			
		} // fin fonction clickSouris
	} // fin class
} // fin package