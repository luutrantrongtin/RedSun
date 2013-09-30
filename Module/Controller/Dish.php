<?php
include "../Model/Dish_Class.php";
        if ($_SERVER['REQUEST_METHOD'] == "POST") {
            $dishName      = $_POST['dishName'];
            $avatar     = $_POST['avatar'];
            $price   = $_POST['price'];
            $time     = $_POST['time'];
            $serving     = $_POST["serving"];
            $query= new C_Dish();
            //$query  = "call AddDish('$dishName','$avatar','$price','$time','$serving')";
            $query->Add($dishName,$avatar,$price,$time,$serving);
            //$result = $dbc->query($query);
            //check transaction có hoạt động thành công không
            if ($dbc->affected_rows == 0) {
                //không hiểu tại sao chỗ này dù đã commit thành công nhưng vẫn trả về 0
                echo "Thêm món ăn thành công";

            }
            else {
                echo "Thêm món ăn thất bại" . "<br>" . $dbc->error;
            }
            echo "<br>" . "Số dòng affect: " . $dbc->affected_rows;
        }//end if

?>