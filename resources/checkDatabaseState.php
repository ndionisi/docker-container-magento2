<?php
     error_reporting(E_ERROR);

     $maxAttempts = 10;
     $sleepBetweenRetries = 5;

     if (count($argv) != 4) {
         echo "Usage: checkDatabaseState.php DB_HOST DB_USER DB_PASSWORD\n";
         exit(1);
     }

     $host=$argv[1];
     $username=$argv[2];
     $password=$argv[3];

     for ($i=0; $i<$maxAttempts; $i++) {
        echo "\n";
        echo 'Checking connection to database server "' . $host . '". Attempt ' . ($i+1) . '/' . $maxAttempts . '...';
        echo "\n";

        if (mysql_connect($host, $username, $password)) {
           exit(0);
        }

        echo 'Database is not available. ';
        if ($i < $maxAttempts - 1) {
           echo  'Will try again in ' . $sleepBetweenRetries . ' seconds...';
           sleep($sleepBetweenRetries);
        }
     }

     echo "\n";
     echo 'Database not reachable after ' . $maxAttempts . ' attempts. Please check your database settings.';
     echo "\n";
     exit(1);
?>