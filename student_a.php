<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include("conn.php");
    
    $crse_number = "";
    $result = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {


        $crse_number = $_POST["course_number"];

        $query = 
        "   SELECT cs.sect_No AS Section_Number, cs.sect_Classrm AS Classroom, cs.sect_meetDays AS Meeting_Days, cs.sect_startTime AS Start_Time, cs.sect_endTime AS End_Time, COUNT(er.er_Student) AS Student_Count
            FROM CrSection cs
            LEFT JOIN EnrollRec er ON cs.cors_No = er.er_crseNo AND cs.sect_No = er.er_sectNo
            WHERE cs.cors_No = ?
            GROUP BY cs.sect_No, cs.sect_Classrm, cs.sect_meetDays, cs.sect_startTime, cs.sect_endTime
            ORDER BY cs.sect_No;
        ";
        
        
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param("s", $crse_number);
        $stmt->execute();
        $result_set = $stmt->get_result();

        if ($result_set->num_rows <= 0) {
            echo "Error: Course not found";
        }

        if ($result_set->num_rows > 0) {
            $result = $result_set->fetch_all(MYSQLI_ASSOC);
        }
        $stmt->close();

}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>COURSE SECTION</SECTION></title>
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


