<?php
// Database credentials
$host = 'localhost';       // or '127.0.0.1'
$db   = 'budget_manager';  // name of your database
$user = 'root';   // replace with your MySQL username
$pass = '';   // replace with your MySQL password

// Create a new MySQLi connection
$mysqli = new mysqli($host, $user, $pass, $db);

// Check connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Optional: Set character set to UTF-8 (recommended)
$mysqli->set_charset("utf8");

// Return the $mysqli object for use in other scripts
return $mysqli;
?>
