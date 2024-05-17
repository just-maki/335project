<?php

    // username and password need to be replaced by your username and password
    // dbname is the same as your username
    $hostName = 'mariadb';
    $userName = 'cs332c24';
    $password = 'UwJjjxA8';
    $dbName = 'cs332c24';

    $mysqli = sqli_connect($hostName, $userName, $password, $dbName);
    if (!$mysqli) {
        die("Unable to connect to host $hostName");
    }
    
    echo 'Connected successfully<p>';
    $query = "SELECT c.crse_Title AS Course_Title, 
        cs.sect_Classrm AS Classroom, 
        cs.sect_meetDays AS Meeting_Days, 
        cs.sect_startTime AS Start_Time,
        cs.sect_endTime AS End_Time
    FROM Professors p
    JOIN CrSection cs ON p.pssn = cs.sect_Prof
    JOIN Course c ON cs.cors_No = c.crse_No
    WHERE p.pssn = sno; // Replace '123456789' with the actual SSN of the professor

    $query = "SELECT * FROM STUDENT WHERE ssn=" . $_POST["sno"];
    $result = $link->query($query);
    $row=$result->fetch_assoc();
    printf("SSN: %s<br>\n", $row["ssn"});
    printf("First NAME: %s<br>\n", $row["FName"]);
    printf("Last NAME: %s<br>\n", $row["LName"]);
    $result->free_results();
    $link->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professor SSN</title>
</head>
    <body>
        <h2>Sections for Course <?php echo $crse_number?></h2>
        <?php if ($result): ?>  
            <?php foreach ($result as $row): 
                echo "Section Number: " . $row['section_number'] . "<br>";
                echo "Classroom: " . $row['classroom'] . "<br>";
                echo "Meeting Days: " . $row['meeting_days'] . "<br>";
                echo "Time: " . $row['start_time'] . " - " . $row['end_time'] . "<br>";
                echo "Number of Students Enrolled: " . $row['num_students_enrolled'] . "<br><br>";
            endforeach; ?>
        <?php endif; ?>
    </body>
</html>
