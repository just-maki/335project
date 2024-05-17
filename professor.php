<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include("conn.php");

    $query = "SELECT c.crse_Title AS Course_Title, 
        cs.sect_Classrm AS Classroom, 
        cs.sect_meetDays AS Meeting_Days, 
        cs.sect_startTime AS Start_Time,
        cs.sect_endTime AS End_Time
    FROM Professors p
    JOIN CrSection cs ON p.pssn = cs.sect_Prof
    JOIN Course c ON cs.cors_No = c.crse_No
    WHERE p.pssn = sno; // Replace '123456789' with the actual SSN of the professor"
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $pssn);
    $stmt->execute();
    $result_set = $stmt->get_result();
    if ($result_set->num_rows <= 0) {
        echo "Error: professor not found";
    }
    if ($result_set->num_rows > 0) {
        $result = $result_set->fetch_all(MYSQLI_ASSOC);
    }
    $stmt->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PROFESSORS CLASSES</title>
</head>
    <body>
        <h2> <?php echo $crse_number?></h2>
        <?php if ($result): ?>  
            <?php foreach ($result as $row): 
                echo "course title:  ". $row['crse_Title'] . <br>;
                echo "Classroom: " . $row['sect_Classrm'] . <br>;
                echo "Meeting Days: " . $row['sect_meetDays'] . <br>;
                echo "Time: " . $row['sect_startTime'] . " - " . $row['sect_endTime'] . <br><br>;
            endforeach; ?>
        <?php endif; ?>
    </body>
</html>
