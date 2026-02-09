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
	<form>
		<input type="text" name="filtre" id="filtre"></input>
		<ul>
			<?php
				error_reporting(-1);
				ini_set('display_errors', 1);
				class Chant
				{
					public $chemin;
					public $code;
					public $titre;
					
					public function __construct($chemin)
					{
						$this->chemin = $chemin;
						$this->code = htmlspecialchars(basename($chemin));
						$this->_lireInfos();
					}
					
					protected function _lireInfos()
					{
						$f = fopen($this->chemin, 'r');
						while(($l = fgets($f)) !== false && ($l = trim($l)) !== '')
							if($l[0] != '#')
							{
								$this->titre = $l;
								break;
							}
						fclose($f);
					}
				}
				foreach(glob('../*.txt') as $chant)
				{
					$chant = new Chant($chant);
					echo '<li data-code="'.$chant->code.'"><input type="checkbox" name="'.$chant->code.'"/>'.($chant->titre ? htmlspecialchars($chant->titre) : basename($chant->chemin, '.txt')).'</li>'."\n";
				}
			?>
		</ul>
	</form>
	</div>
	<div id="chant">
	</div>
</body>
<script type="text/javascript">Choix.brancher();</script>
</html>
