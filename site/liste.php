<!doctype html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>Liste des chants</title>
</head>
<body>
		<ul>
			<?php
				/* Liens vers les .txt; penser à ajouter un charset utf-8 à la config nginx. */
				/* À FAIRE: faire passer les chants par PHP, sans .txt dans l'URL? Car malgré le Content-Type: text/plain; charset=utf-8, mon Firefox 148 interprète d'office les .txt en ISO8859-1, ce n'est qu'en Ctrl-F5 qu'il réalise qu'on lui a transmis un encodage. */
				require_once 'Chant.php';
				foreach(Chant::TousFichiers() as $chant)
				{
					$chant = new Chant($chant);
					echo '<li data-code="'.$chant->code.'" data-cle="'.$chant->clé.'"><a href="'.$chant->chemin.'">'.($chant->titre ? htmlspecialchars($chant->titre) : basename($chant->chemin, '.txt')).'</a></li>'."\n";
				}
			?>
		</ul>
</body>
</html>
