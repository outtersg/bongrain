<!doctype html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>Choix des chants</title>
	<link rel="stylesheet" href="choix.css">
	<script src="choix.js"></script>
</head>
<body>
	<div id="choix">
	<form method="post"><!-- POST pour que les case cochées ne s'ajoutent pas à l'URL -->
		<input type="text" name="filtre" id="filtre" autofocus="autofocus"></input>
		<ul>
			<?php
				require_once 'Chant.php';
				foreach(Chant::TousFichiers() as $chant)
				{
					/* À FAIRE: distinguer code de chemin. Le code peut être les initiales du titre du chant (avec un suffixe numérique en cas de plusieurs). Cela permettra des codes plus courts (mais toujours intelligibles, et avec peu de risques d'écrasement sauf à insérer un Jamais Vraiment Vécu Dignement avant Je Veux Voir Dieu…) qui pourront être passés plus nombreux en paramètres GET. */
					$chant = new Chant($chant);
					echo '<li data-code="'.$chant->code.'"><input type="checkbox" name="'.$chant->code.'"/>'.($chant->titre ? htmlspecialchars($chant->titre) : basename($chant->chemin, '.txt')).'</li>'."\n";
				}
				echo '<li id="telech">Télécharger</li>'."\n";
			?>
		</ul>
	</form>
	</div>
	<div id="chant">
	</div>
</body>
<script type="text/javascript">Choix.brancher();</script>
</html>
