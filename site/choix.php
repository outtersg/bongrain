<!doctype html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>Choix des chants</title>
	<link rel="stylesheet" href="choix.css">
	<script src="choix.js"></script>
</head>
<body class="gd">
	<form method="post"><!-- POST pour que les case cochées ne s'ajoutent pas à l'URL -->
	<div id="choix" class="g">
		<input type="text" name="filtre" id="filtre" autofocus="autofocus" value="<?php if(isset($_GET['q'])) echo strtr($_GET['q'], '|', ' '); ?>"></input>
		<ul>
			<?php
				require_once 'Chant.php';
				foreach(Chant::TousFichiers() as $chant)
				{
					$chant = new Chant($chant);
					echo '<li data-code="'.$chant->code.'" data-cle="'.$chant->clé.'"><input type="checkbox" name="'.$chant->code.'"/>'.($chant->titre ? htmlspecialchars($chant->titre) : basename($chant->chemin, '.txt')).'</li>'."\n";
				}
				echo '<li id="telech">Télécharger / Organiser</li>'."\n";
			?>
		</ul>
	</div>
	<div id="chant" class="d">
	</div>
	</form>
	<div id="dialogues" style="display: none;">
		<?php
			if(file_exists(Chant::$Dossier.'/modeles.json') && ($modèles = json_decode(file_get_contents(Chant::$Dossier.'/modeles.json'))))
			{
				?>
					<div id="terminer">
						<input type="submit" value="Télécharger la liste" id="telecharger"/>
						<div>ou</div>
						<input type="submit" value="Organiser les chants sur le modèle:" id="organiser"/>
						<select name="modele">
							<?php
								foreach($modèles as $modèle => $contenu)
									echo '<option value="'.htmlentities($modèle).'">'.htmlentities($modèle).'</option>'."\n";
							?>
						</select>
					</div>
				<?php
			}
		?>
	</div>
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
