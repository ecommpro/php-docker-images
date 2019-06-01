<?php
return [
    [
        'version' => '5.6-cli',
        'from' => 'php:5.6-cli-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '5.6-fpm',
        'from' => 'php:5.6-fpm-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.0-cli',
        'from' => 'php:7.0-cli-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.0-fpm',
        'from' => 'php:7.0-fpm-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.1-cli',
        'from' => 'php:7.1-cli-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.1-fpm',
        'from' => 'php:7.1-fpm-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.2-cli',
        'from' => 'php:7.2-cli-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.2-fpm',
        'from' => 'php:7.2-fpm-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.3-cli',
        'from' => 'php:7.3-cli-alpine',
        'extensions' => include('extensions.php')
    ],
    [
        'version' => '7.3-fpm',
        'from' => 'php:7.3-fpm-alpine',
        'extensions' => include('extensions.php')
    ],
];
