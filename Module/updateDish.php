<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

    <section>
        <?php
        $id=$_REQUEST['id'];

        //Nếu server có gửi POST thì bắt đầu xử lí form
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $dishid=$_POST['dishid'];
            $name = $_POST['name'];
            $avatar = $_POST['avatar'];
            $time = $_POST['time'];
            $price = $_POST['price'];
            $serving = $_POST['serving'];

            $query  = "call UpdateDish($dishid,'$name','$avatar','$time','$price','$serving')";
            $result = $dbc->query($query);
            //check transaction có hoạt động thành công không
            if ($dbc->affected_rows >= 0) {
                //không hiểu tại sao chỗ này dù đã commit thành công nhưng vẫn trả về 0
                echo "Cập nhật thành công";
            }
            else {
                echo "Cập nhật thất bại" . "<br>" . $dbc->error;
            }
            echo "<br>" . "Số dòng affect: " . $dbc->affected_rows;

        }//end if
        else
        {
            $query = "CALL GetDishByID($id)";
            $result = $dbc->query($query);
            $row = $result->fetch_row();
            $dbc->close();
        }
        ?>

        <form action="updateDish.php" method="post">

            <input type="hidden" name="dishid" value="<?=$id; ?>"><br>
            Tên:
            <br>
            <input type="text" name="name" width="500" value="<?=$row[2]; ?>" />
            <br>
            Hình ảnh:
            <br>
            <input type="text" name="avatar" value="<?=$row[3]; ?>"/>
            <br>

            Giá:
            <br>
            <input type="text" name="price" value="<?=$row[4]; ?>"/>
            <br>

            Thời gian:
            <br>
            <input type="text" name="time" value="<?=$row[5]; ?>"/>
            <br>
            Khẩu phần:
            <br>
            <input type="text" name="serving" value="<?=$row[6]; ?>"/>
            <br>
            <input type="submit" name="submit" value="Cập nhật"/>
        </form>
    </section>
    <aside id="right"></aside>

<?php include('include/footer.php') ?>