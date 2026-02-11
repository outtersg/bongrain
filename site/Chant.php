<?php

class Chant
{
	public static $Dossier = 'chants';
	public static $Clés = [];
	
	public $chemin;
	public $code;
	public $clé; // Le code permet de retrouver le fichier (sans reparcourir l'ensemble). La clé est plus courte mais à sens unique (on déduit la clé du fichier, non l'inverse).
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
	
	public static function Clé($chant)
	{
		if(!isset(Chant::$_UConv))
			Chant::$_UConv = Transliterator::create('Latin-ASCII');
		$clé =
			$chant->titre
			? strtolower(preg_replace('/(\w)\w*\W*/', '\1', Chant::$_UConv->transliterate($chant->titre)))
			: basename($chant->chemin)
		;
		for($suffixe = 1; isset(Chant::$Clés[$essaiClé = $clé.($suffixe > 1 ? $suffixe : '')]); ++$suffixe)
			if(Chant::$Clés[$essaiClé] == $chant->chemin)
				return $essaiClé;
		Chant::$Clés[$essaiClé] = $chant->chemin;
		return $essaiClé;
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
		$this->clé = Chant::Clé($this);
		fclose($f);
	}
	
	protected static $_UConv;
}

?>
