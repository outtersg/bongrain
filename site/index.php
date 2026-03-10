<?php

error_reporting(-1);
ini_set('display_errors', 1);

function faire($req)
{
	$uriDem = $req['REQUEST_URI'];
	$uriMoi = $req['DOCUMENT_URI'];
	if(!preg_match('#^(?<racine>'.$uriMoi.')(?<uri>.*)#', $uriDem, $r))
		preg_match('#^(?<racine>'.dirname($uriMoi).')/*(?<uri>.*)#', $uriDem, $r);
	$r += parse_url($r['uri']);
	if(!isset($r['path'])) $r['path'] = '';
	if(!preg_match('/^(choix|filtre|orga)$/', $r['path']))
		$r['path'] = 'choix';
	include $r['path'].'.php';
}

faire($_SERVER);

?>
