<?php
ob_end_flush();
ob_start();
$foo = 'foo';
echo  'msg before breack point</br>';
xdebug_break();
$var = 'var';
echo  'msg after breack point';
