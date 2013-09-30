<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

    <section>
        <?php
        $query = "call ViewDish()";
        $result = $dbc->query($query) or die($dbc->error);

        if($result != false)
        {
            if($result->num_rows>0)
            {
                ?>
                <table width="600" border="1" cellspacing="0" align="center" >
                    <tr>
                        <br/><p>DANH SÁCH MÓN ĂN</p><br />
                        <th>DISHID</th>
                        <th>Tên</th>
                        <th>Hình ảnh</th>
                        <th>Giá</th>
                        <th>Thời gian</th>
                        <th>Khẩu phần</th>

                    </tr>
                    <?php
                    while($row = $result->fetch_array(MYSQL_ASSOC))
                    {
                        $dishID = $row["DishID"];

                        $name = $row["Name"];
                        $avatar = $row["AvatarURL"];
                        $price = $row["Price"];
                        $time = $row["Time"];
                        $serving = $row["Serving"];

                        ?>
                        <tr>
                            <td align="center"><?php echo($dishID);?></td>
                            <td><?php echo($name); ?></td>
                            <td><?php echo($avatar); ?></td>
                            <td><?php echo($price); ?></td>
                            <td><?php echo($time); ?></td>
                            <td><?php echo($serving); ?></td>

                            <td>
                                <a href="delDish.php">Xóa</a>
                                <a href="updateDish.php?id=<?=$dishID; ?>">Sửa</a>
                            </td>
                        </tr>
                    <?php
                    }
                    ?>
                </table>
            <?php
            }
        }
        ?>
    </section>
    <aside id="right">
        <a href="addDish.php">Thêm mới</a>
    </aside>

<?php include('include/footer.php') ?>