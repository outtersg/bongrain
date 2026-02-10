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
