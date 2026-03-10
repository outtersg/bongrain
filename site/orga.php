<!doctype html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>Organisation des chants</title>
	<link rel="stylesheet" href="choix.css">
	<script src="choix.js"></script>
</head>
<body>
	<div id="choix">
	<form method="post"><!-- POST pour que les case cochées ne s'ajoutent pas à l'URL -->
		<table>
			<tr>
				<th>Chant</th>
				<th>Note</th>
			</tr>
			<?php
				require_once 'Chant.php';
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
							'<tr>
								<th><a href="'.$chant->chemin.'" data-code="'.$chant->code.'">'.($chant->titre ? htmlspecialchars($chant->titre) : basename($chant->chemin, '.txt')).'</a></th>
								<td>'.$note.'</td>
							</tr>'."\n";
						}
			?>
		</table>
	</form>
	</div>
	<div id="chant">
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
</script>
</html>
