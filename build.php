<?php
$versions = include(__DIR__ . '/src/versions.php');
$buildDir = __DIR__ . '/build';
$srcDir = __DIR__ . '/src';

$tools = array_map(function($file) {
    return pathinfo($file, PATHINFO_BASENAME);
},  array_filter(glob(__DIR__ . '/cli-tools/*'), function($file) {
    return ! is_link($file) && strpos($file, 'update-cli-tools') === false;
}));

foreach($versions as $version) {
    $extensions = [];

    foreach($version['extensions'] as $file) {
        $candidates = array_map(function($file) {
            return pathinfo($file, PATHINFO_BASENAME);
        }, array_merge(glob($srcDir . '/' . $file), glob($srcDir . '/' . "$file:*")));

        usort($candidates, 'version_compare');
        $max = $file . ':' . $version['version'];
        $max = preg_replace('#(-cli|-fpm)$#', '', $max);
        
        do {
            $candidate = array_pop($candidates);
        } while($candidate && version_compare($candidate, $max, 'gt'));

        $content = trim(file_get_contents($srcDir . '/' . $candidate), " \t\n\r\0\x0B\\");

        if ($content) {
            $extensions[$file] = $content;
        }
    }

    ob_start();
    if (preg_match('/-cli$/', $version['version'])) {
        include($srcDir . '/' . 'block.cli');
    }
    $cli = ob_get_clean();
    
    ob_start();
    include $srcDir . '/' . 'layout.base';
    $contents = ob_get_clean();

    $toDir = $buildDir . '/' . $version['version'];
    if (!file_exists($toDir)) {
        mkdir($toDir, 0755, true);
    }
    
    file_put_contents($toDir . '/Dockerfile', $contents);
    echo "$toDir created.\n";
}