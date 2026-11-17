<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */
$routes->get('/', 'Home::index');
$routes->group('api', static function ($routes) {
    $routes->get('umkm', '\App\Controllers\Api\UmkmController::index');
    $routes->post('umkm', '\App\Controllers\Api\UmkmController::create');
    $routes->put('umkm/(:num)', '\App\Controllers\Api\UmkmController::update/$1');
    $routes->delete('umkm/(:num)', '\App\Controllers\Api\UmkmController::delete/$1');
    $routes->options('(:any)', static function () {
        return response()->setStatusCode(200);
    });
});