<?php
/**
 * @param $a
 * @param $b
 *
 * @return string
 */
function sumBig($a, $b)
{
    $a = (string)$a;
    $b = (string)$b;
    $sa = strlen($a);
    $sb = strlen($b);

    $maxLength = ($sa>$sb) ? $sa : $sb;
    if ($sa < $maxLength) {
        $a = sprintf('%0' . $maxLength . 'd', $a);
    }
    if ($sb < $maxLength) {
        $b = sprintf('%0' . $maxLength . 'd', $b);
    }

    $append = 0;
    //Двигаемся с конца строк к началу
    for ($i = $maxLength - 1; $i >= 0; $i--) {
        $append += (int)$a[$i] + (int)$b[$i];
        $a[$i] = (string)($append % 10);
        $append = (int)($append / 10);
    }
    if ($append > 0) {
        $a = (string)$append . $a;
    }

    return $a;
}
