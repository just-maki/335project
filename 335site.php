<html>
    <body>
        <?php
            // username and password need to be replaced by your username and password
            // dbname is the same as your username
            $hostName = 'mariadbl';
            $userName = 'cs332c24';
            $password = 'UwJjjxA8';
            $dbName = 'cs332c24';

            $link = mysqli_connect($hostName, $userName, $password, $dbName)
            or die("Unable to connect to host $hostName");
            
            echo 'Connected successfully<p>';

            $query = "SELECT * FROM STUDENT WHERE ssn=" . $_POST["sno"];
            $result = $link->query($query);
            $row=$result->fetch_assoc();
            printf("SSN: %s<br>\n", $row["ssn"]);
            printf("First NAME: %s<br>\n", $row["fname"]);
            printf("Last NAME: %s<br>\n", $row["lname"]);
            $result->free_result();
            $link->close();
        ?>
    </body>
</html>
