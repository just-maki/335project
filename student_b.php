<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include("conn.php");
    
    $stdnt_CWID = "";
    $result = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {


        $stdnt_CWID = $_POST["student_campus_id"];

        $query = 
        "   SELECT c.crse_Title AS Course_Title, c.crse_No AS Course_Number, er.er_Grade AS Grade
            FROM EnrollRec er
            JOIN CrSection cs ON er.er_crseNo = cs.cors_No AND er.er_sectNo = cs.sect_No
            JOIN Course c ON cs.cors_No = c.crse_No
            WHERE er.er_Student = ?;
        ";
        
        
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param("s", $student_campus_id);
        $stmt->execute();
        $result_set = $stmt->get_result();

        if ($result_set->num_rows <= 0) {
            echo "Error: CWID not found";
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
    <title>Professor SSN</title>
</head>
<body>
    <h2>Academic history for <?php echo $student_campus_id?></h2>
    <?php if ($result): ?>
        <?php foreach ($result as $row): 
            echo "Course Number: " . $row['course_number'] . "<br>";
            echo "Class Name: " . $row['title'] . "<br>";
            echo "Grade: " . $row['grade'] . "<br><br><br>";
         endforeach; ?>
    <?php endif; ?>
</body>
</html>


