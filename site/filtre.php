<?php

require_once 'Chant.php';

$rés = Chant::FichiersCorrespondant(explode('|', $_GET['q']));

header('Content-Type: application/json');
echo json_encode(array_map('basename', $rés));

?>
