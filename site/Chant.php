<?php

class Chant
{
	public $chemin;
	public $code;
	public $titre;
	
	public static function TousFichiers()
	{
		return glob('../*.txt');
	}
	
	public static function FichiersCorrespondant($rech)
	{
		foreach($rech as $clé => $val)
			if(!preg_match('#^\w{3,}$#u', $val))
				unset($rech[$clé]);
		if(!count($rech)) return [];
		
		$rech = implode('|', $rech);
		exec("egrep -il '$rech' ../*.txt", $rés);
		
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
