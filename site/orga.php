<!doctype html>
<?php
	require_once 'Chant.php';
	$modèle = $_GET['modele'];
	$modèles = json_decode(file_get_contents(Chant::$Dossier.'/modeles.json'));
	$modèle = $modèles->$modèle;
	$paramsPréc = array_intersect_key($_GET, [ 'modele' => true, 'q' => true, 'n' => true ]);
?>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>Organisation des chants</title>
	<link rel="stylesheet" href="choix.css">
	<script src="choix.js"></script>
	<script type="text/javascript">
		{
			let hurleurs = <?php echo json_encode($paramsPréc); ?>;
			let h;
			for(h in hurleurs)
				Chants.hurleurs[h] = hurleurs[h];
		}
	</script>
</head>
<body id="orga" class="gdd">
	<div id="choix" class="g">
	<form method="post"><!-- POST pour que les case cochées ne s'ajoutent pas à l'URL -->
		<input type="hidden" value="<?php echo htmlentities($_GET['q']); ?>" id="filtre" name="filtre"/>
		<table id="liste">
			<colgroup>
				<col/>
				<col/>
				<?php
					const AFFECTATIONS_N = 2;
					foreach($modèle as $pos => $moment)
						echo '<col class="moment'.($pos % AFFECTATIONS_N).'" data-moment="'.$pos.'"/>'."\n";
				?>
			</colgroup>
			<tr>
				<th>Chant</th>
				<th>Note</th>
				<?php
					// https://css-tricks.com/rotated-table-column-headers/
					foreach($modèle as $moment)
						echo '<th class="moment"><div><span>'.htmlentities($moment).'</span></div></th>'."\n";
				?>
			</tr>
			<?php
				// On charge l'intégralité des chants, car les clés (retrouvées dans l'URL) dépendent du nombre de chants se partageant les mêmes initiales, donc si on n'a pas chargé tous les chants on peut se retrouver avec des mécorrespondances.
				$chants = [];
				foreach(Chant::TousFichiers() as $chemin)
				{
					$chant = new Chant($chemin);
					$chants[$chant->clé] = $chant;
				}
				$notes = array_map(function($clés) { return explode(',', $clés); }, $_GET['n']);
				krsort(/*&*/ $notes, SORT_NUMERIC);
				foreach($notes as $note => $clés)
					if($note > 0)
						foreach($clés as $clé)
						{
							$chant = $chants[$clé]; /* À FAIRE?: un lieu-tenant si on ne le retrouve pas? */
							echo
							'<tr data-code="'.$chant->code.'" data-cle="'.$clé.'">
								<th><a href="'.$chant->chemin.'" data-code="'.$chant->code.'">'.($chant->titre ? htmlspecialchars($chant->titre) : basename($chant->chemin, '.txt')).'</a></th>
								<td>'.$note.'</td>'."\n";
							foreach($modèle as $pos => $moment)
							{
								$courtMoment = Chant::ÉtiquettePour($moment);
								$classe = isset($chant->étiquettes[$courtMoment]) ? ' class="possible"' : '';
								echo '<td'.$classe.'><input type="radio" name="m'.$pos.'"/></td>'."\n";
							}
							echo '</tr>'."\n";
						}
			?>
		</table>
	</form>
	</div>
	<div class="d">
		<div id="chant" class="dh">
		</div>
		<div id="tdm" class="db">
			<h3>Table des matières</h3>
			<table>
			<?php
				foreach($modèle as $pos => $moment)
				{
					?>
						<tr class="moment<?php echo $pos % AFFECTATIONS_N; ?>" data-moment="<?php echo $pos; ?>">
							<td><input class="moment" type="text" value="<?php echo htmlspecialchars($moment); ?>" readonly="readonly"/></td>
							<td><input class="libre" type="text" size="64"/></td>
						</tr>
					<?php
				}
			?>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript">
	var montrer = function(ev)
	{
		Choix.montrer(ev.target);
		ev.preventDefault(true);
		ev.stopPropagation();
	};
	document.querySelectorAll('table th a').forEach(function(e)
	{
		e.addEventListener('click', montrer);
	});
	Choix.brancherRedim();
	Orga.brancher();
</script>
</html>
