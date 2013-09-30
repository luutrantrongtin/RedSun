
<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

    <section>
        <?php //Nếu server có gửi POST thì bắt đầu xử lí form
        $id=$_REQUEST['id'];
        if ($_SERVER['REQUEST_METHOD'] == "POST") {
            $empid=$_POST['empid'];
            $lname = $_POST['lname'];
            $mname = $_POST['mname'];
            $fname = $_POST['fname'];
            $workat = $_POST['workat'];
            $position = $_POST['position'];
            $status = $_POST['status'];
            $bday = $_POST['bday'];
            $bmonth = $_POST['bmonth'];
            $byear = $_POST['byear'];

            $address = $_POST['address'];
            $district = $_POST['district'];
            $city = $_POST['city'];
            $phone = $_POST['phone'];
            $avatar = $_POST['avatar'];

            $query  = "call UpdateEmployee($empid,'$lname','$mname','$fname',$workat,'$position','$status',$bday,$bmonth,$byear,'$address','$district','$city','$phone','$avatar')";
            $result = $dbc->query($query);
            //check transaction có hoạt động thành công không
            if ($dbc->affected_rows == 0) {
                //không hiểu tại sao chỗ này dù đã commit thành công nhưng vẫn trả về 0
                echo "Cập nhật thành công";
            }
            else {
                echo "Cập nhật thất bại" . "<br>" . $dbc->error;
            }
            echo "<br>" . "Số dòng affect: " . $dbc->affected_rows;
        }//end if
        else{
            $query  = "call GetEmpByID($id)";
            $result = $dbc->query($query);
            $row1 = $result->fetch_array();
            $result->free();
            $dbc->next_result();
        }
        ?>
        <form action="EditEmployee.php" method="post">
            <input type="hidden" name="empid" value="<?=$row1[0]?>"><br>
            Họ:
            <br>
            <input type="text" name="lname" width="500" value="<?=$row1[4]; ?>" />
            <br>

            Tên lót:
            <br>
            <input type="text" name="mname" width="500" value="<?=$row1[5]; ?>" />
            <br>

            Tên:
            <br>
            <input type="text" name="fname" width="500" value="<?=$row1[6]; ?>" />
            <br>
            WorkAt:
            <br>
            <input type="text" name="workat" value="<?=$row1[7]; ?>"/>
            <br>

            Chức vụ:
            <br>
            <select name="position">
                <option><?=$row1[8]; ?></option>
                <?php
                $query = "CALL ViewEmpPosition()";
                $result = $dbc->query($query);
                while ($row = $result->fetch_array()) {
                    echo "<option>".$row[1]."</option>";

                }
                $result->free();
                $dbc->next_result();
                ?>
            </select>
            <br>

            Tình trạng:
            <br>
            <select name="status">
                <option><?=$row1[9]; ?></option>
                <?php
                $query = "call ViewEmpStatus()";
                $result = $dbc->query($query);
                while ($row = $result->fetch_array()) {
                    echo "<option>" . $row[0] . "</option>";
                }
                $result->free();
                $dbc->next_result();
                ?>
            </select>
            <br>

            Ngày sinh:
            <br>
            <input type="text" name="bday" value="<?=$row1[12]; ?>"/>
            <br>

            Tháng sinh:
            <br>
            <input type="text" name="bmonth" value="<?=$row1[13]; ?>"/>
            <br>

            Năm sinh:
            <br>
            <input type="text" name="byear" value="<?=$row1[14]; ?>"/>
            <br>

            Địa chỉ:
            <br>
            <input type="text" name="address" value="<?=$row1[16]; ?>"/>
            <br>

            Huyện/Tỉnh/Thành phố:
            <br>
            <select name="city">
                <option><?=$row1[18]; ?></option>
                <<?php
                $query = "CALL ViewCity()";
                $result = mysqli_query($dbc, $query) or die(mysqli_error($dbc));
                while ($row = mysqli_fetch_array($result)) {
                    echo "<option>" . $row[0] . "</option>";
                }
                $dbc->close();
                ?>
            </select>
            <br>

            Quận:
            <br>
            <input type="text" name="district" value="<?=$row1[17]; ?>"/>
            <br>

            Số điên thoại:
            <br>
            <input type="text" name="phone" value="<?=$row1[19]; ?>"/>
            <br>

            Hình đại diện:
            <br>
            <input type="text" name="avatar" value="<?=$row1[20]; ?>"/>
            <input type="button" name="upload" value="upload"/>

            <input type="submit" name="submit" value="cập nhật"/>
        </form>
    </section>
    <aside id="right"></aside>

<?php include('include/footer.php') ?>