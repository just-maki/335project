<htmlh>
    <head>
     <title>File structures and database project</title>
    </head>
    <body>
        <?php echo "this is the website";
        $hostName = 'https://ecs.fullerton.edu/~wang/cpsc33203/qsid.php';
        $userName = 'CS332c24';
        $password = 'UwJjjxA8';
        $dbname = 'Mariadb';
        $link=mysqli_connect($hostName, $userName, $password, $dbName)
        or die("unable to connect to host $hostName")
        ?>
        <script language="PHP">
        </script>
    </body>
</html>
