<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

//Log in / register
$routes->get('/', 'Home::index');
$routes->post('mylogin-auth', 'MyLogIn::auth');
$routes->post('mylogout', 'MyLogIn::logout');
$routes->get('myregister', 'MyLogIn::register');
$routes->post('myregister', 'MyLogIn::register_save');

//Request - requester module (also the request page, PDF and conversation HR opens)
$routes->get('myrequest', 'MyRequest::index',['filter' => 'myauthuser']);
$routes->post('myrequest', 'MyRequest::index',['filter' => 'myauthuser']);

//Approval - requests naming you as "Noted by": sign and approve, or return
$routes->get('myapproval', 'MyApproval::index',['filter' => 'myauthuser']);
$routes->post('myapproval', 'MyApproval::index',['filter' => 'myauthuser']);

//Account - your own name, position, office and password
$routes->get('myaccount', 'MyAccount::index',['filter' => 'myauthuser']);
$routes->post('myaccount', 'MyAccount::index',['filter' => 'myauthuser']);

//HR - document editor: the Special Order prepared for a request
$routes->get('myhrdoc', 'MyHRDocument::index',['filter' => 'myauthuser']);
$routes->post('myhrdoc', 'MyHRDocument::index',['filter' => 'myauthuser']);

//HR - every request, status updates
$routes->get('myhrrequest', 'MyHRRequest::index',['filter' => 'myauthuser']);
$routes->post('myhrrequest', 'MyHRRequest::index',['filter' => 'myauthuser']);
