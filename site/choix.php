<!doctype html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>Choix des chants</title>
	<link rel="stylesheet" href="choix.css">
	<script src="choix.js"></script>
</head>
<body>
	<form method="post"><!-- POST pour que les case cochées ne s'ajoutent pas à l'URL -->
	<div id="choix">
		<input type="text" name="filtre" id="filtre" autofocus="autofocus" value="<?php if(isset($_GET['q'])) echo strtr($_GET['q'], '|', ' '); ?>"></input>
		<ul>
			<?php
				require_once 'Chant.php';
				foreach(Chant::TousFichiers() as $chant)
				{
					$chant = new Chant($chant);
					echo '<li data-code="'.$chant->code.'" data-cle="'.$chant->clé.'"><input type="checkbox" name="'.$chant->code.'"/>'.($chant->titre ? htmlspecialchars($chant->titre) : basename($chant->chemin, '.txt')).'</li>'."\n";
				}
				echo '<li id="telech">Télécharger</li>'."\n";
			?>
		</ul>
	</div>
	<div id="chant">
	</div>
	</form>
</body>
<script type="text/javascript">
	Choix.brancher();
	<?php
		if(isset($_GET['n']))
		{
			$notes = array_map(function($clés) { return explode(',', $clés); }, $_GET['n']);
			echo 'Choix.noters('.json_encode($notes).');';
		}
	?>
	<?php if(isset($_GET['q'])) { ?>Choix.saisieFiltre(); <?php } ?>
</script>
</html>
