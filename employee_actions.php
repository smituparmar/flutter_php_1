<?php

$servername = "localhost";
$username = "id14473820_employee";
$password = "AlanTuring@123";
$dbname = "id14473820_employeedb";
$table = "Employees";  // create this table;

//we will get action from the app to do operations in the database.
$action =  "CREATE_TABLE";

//create connection

$conn = new mysqli($servername,$username,$password, $dbname);

if($conn->connect_error)
{
     die("Connection Failed: " . $conn->connect_error);
     return;
}


//if connection is OK.

//if the app sends an action to create the table
if("CREATE_TABLE" == $action)
{
    $sql = "CREATE TABLE IF NOT EXISTS $table ( 
        id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        first_name  VARCHAR(30) NOT NULL,
        last_name VARCHAR(30) NOT NULL)";

    if($conn->query($sql) == TRUE)
    {
        //send back success
        echo "success";
    }
    else{
        echo "error2";
    }
        $conn->close();
        return; 
}

//next action to get all employee records from database
if("GET_ALL" == $action)
{
    $db_data = array();
    $sql = "SELECT * FROM $table ORDER BY id DESC";
    $result = $conn->query($sql);
    if($result->num_rows > 0)
    {
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        //send back records as json 
        echo json_encode($db_data);
    } 
    else
    {
        echo "error";
    }
    $conn->close();
    return; 
}

//add employees
if("ADD_EMP" == $action)
{
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $sql = "INSERT INTO $table (first_name, last_name) VALUES ('$first_name', '$last_name')";
    $result = $conn->query($sql);
    echo "success";
}

//Update an employee
if("UPDATE_EMP" == $action)
{
    $emp_id = $_POST["emp_id"];
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $sql = "UPDATE $table SET first_name = '$first_name', last_name='$last_name' WHERE id = '$emp_id'";
    if($$conn->query($sql) == TRUE)
    {
        echo "success";
    }
    else{
        echo "error";
    }
    $conn->close();
    return;
}

//DELETE EMPLOYEE
if("DELETE_EMP" == $action)
{
    $emp_id = $_POST["emp_id"];
    $sql = "DELETE FROM $table WHERE id = $emp_id";
    if($conn->query($sql) == TRUE)
    {
        echo "success";
    }
    else{
        echo "error";
    }
    $conn->close();
    return;
}

?>