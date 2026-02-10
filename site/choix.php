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
		<input type="text" name="filtre" id="filtre"></input>
		<ul>
			<?php
				error_reporting(-1);
				ini_set('display_errors', 1);
				require_once 'Chant.php';
				foreach(Chant::TousFichiers() as $chant)
				{
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
