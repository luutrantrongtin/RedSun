<?php
class C_Dish{
    function Add($dishName,$avatar,$price,$time,$serving){
        include ("../include/header.php");
        $query  = "call AddDish('$dishName','$avatar','$price','$time','$serving')";
        $result = $dbc->query($query);
        return $result;
    }
}
?>