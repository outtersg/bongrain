<?php

class Chant
{
	public static $Dossier = 'chants';
	
	public $chemin;
	public $code;
	public $titre;
	
	public static function TousFichiers()
	{
		return glob(Chant::$Dossier.'/*.txt');
	}
	
	public static function FichiersCorrespondant($rech)
	{
		foreach($rech as $clé => $val)
			if(!preg_match('#^\w{3,}$#u', $val))
				unset($rech[$clé]);
		if(!count($rech)) return [];
		
		$rech = implode('|', $rech);
		exec("egrep -il '$rech' ".Chant::$Dossier."/*.txt", $rés);
		
		return $rés;
	}
	
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

?>
