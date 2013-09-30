<?php include ("../include/header.php"); ?>
<?php include("../include/sidebar_left.php"); ?>

    <section>
        <form action="../Controller/Dish.php" method="post">
            Tên món ăn:
            <br>
            <input type="text" name="dishName" width="500" maxlength="50" value="<?php
            if (isset($_POST['dishName'])) {
                echo strip_tags($_POST['dishName']);
            }
            ?>"/>
            <br>

            Giá cả:
            <br>
            <input type="text" name="price" width="500" maxlength="10" value="<?php
            if (isset($_POST['price'])) {
                echo strip_tags($_POST['price']);
            }
            ?>"/>
            <br>

            Thời gian nấu:
            <br>
            <input type="text" name="time" value="<?php
            if (isset($_POST['time'])) {
                echo strip_tags($_POST['time']);
            }
            ?>"/>
            <br>

            Khẩu phần ăn:
            <br>
            <input type="text" name="serving" value="<?php
            if (isset($_POST['serving'])) {
                echo strip_tags($_POST['serving']);
            }
            ?>"/>
            <br>

            <input type="submit" name="submit"/>
        </form>
    </section>
    <aside id="right"></aside>

<?php include('../include/footer.php') ?>