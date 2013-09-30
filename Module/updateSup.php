<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

    <section>
        <?php
        $id=$_REQUEST['id'];

        //Nếu server có gửi POST thì bắt đầu xử lí form
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $suppid=$_POST['suppid'];
            $type = $_POST['type'];
            $name = $_POST['name'];



            $address = $_POST['address'];
            $district = $_POST['district'];
            $city = $_POST['city'];
            $phone = $_POST['phone'];
            $contact = $_POST['contact'];

            $query  = "call UpdateSupplier($suppid,'$type','$name','$address','$district','$city','$phone','$contact')";
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
            $query = "CALL GetSuppByID($id)";
            $result = $dbc->query($query);
            $row = $result->fetch_row();
            $result->free();
            $dbc->next_result();
        }
        ?>

        <form action="updateSup.php" method="post">

            <input type="hidden" name="suppid" value="<?=$id; ?>"><br>
            Type:
            <br>
            <label>
                <input type="text" name="type" width="500" value="<?=$row[1]; ?>"/>
            </label>
            <br>

            Tên:
            <br>
            <input type="text" name="name" width="500" value="<?=$row[2]; ?>" />
            <br>

            Địa chỉ:
            <br>
            <input type="text" name="address" value="<?=$row[3]; ?>"/>
            <br>

            Huyện/Tỉnh/Thành phố:
            <br>
            <select name="city">
                <option><?=$row[5]; ?></option>
                <<?php
                $query = "CALL ViewCity()";
                $result = mysqli_query($dbc, $query) or die(mysqli_error($dbc));
                while ($row3 = mysqli_fetch_array($result)) {
                    echo "<option>" . $row3[0] . "</option>";
                }
                $dbc->close();
                ?>
            </select>
            <br>

            Quận:
            <br>
            <input type="text" name="district" value="<?=$row[4]; ?>"/>
            <br>

            Số điên thoại:
            <br>
            <input type="text" name="phone" value="<?=$row[6]; ?>"/>
            <br>
            Contact:
            <br>
            <input type="text" name="contact" value="<?=$row[7]; ?>"/>
            <br>


            <input type="submit" name="submit" value="cập nhật"/>
        </form>
    </section>
    <aside id="right"></aside>

<?php include('include/footer.php') ?>