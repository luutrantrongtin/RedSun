<?php session_start(); ?>
<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

    <section>
        <?php //Nếu server có gửi POST thì bắt đầu xử lí form
        $sendid=$_SESSION['empid'];

        if ($_SERVER['REQUEST_METHOD'] == "POST") {
            $receiverid      = $_POST['receiverid'];
            $subject     = $_POST['subject'];
            $content   = $_POST['content'];

            $query  = "call SendMessage($sendid,$receiverid,'$subject','$content')";
            $result = $dbc->query($query);
            //check transaction có hoạt động thành công không
            if ($dbc->affected_rows == 0) {
                //không hiểu tại sao chỗ này dù đã commit thành công nhưng vẫn trả về 0
                echo "Gửi thành công";
            }
            else {
                echo "Gửi thất bại" . "<br>" . $dbc->error;
            }
            echo "<br>" . "Số dòng affect: " . $dbc->affected_rows;
        }//end if
        ?>
        <form action="SendMessage.php" method="post">
            Tên người nhận:
            <br>
            <input type="text" name="receiverid" style="width: 50%" maxlength="50" value="<?php
            if (isset($_POST['reply'])) {
                echo strip_tags($_POST['reply']);
            }
            ?>"/>
            <br>

            Chủ đề:
            <br>
            <input type="text" name="subject" style="width: 50%" value="<?php
            if (isset($_POST['subject'])) {
                echo strip_tags($_POST['subject']);
            }
            ?>"/>
            <br>

            Nội dung:
            <br>
            <textarea style="width: 50%" name="content" rows="10" ><?php
                if (isset($_POST['content'])) {
                    echo strip_tags($_POST['content']);
                }
                ?></textarea>
            <br>
            <input type="submit" name="submit" value="Gửi"/>
        </form>
    </section>
    <aside id="right"></aside>

<?php include('include/footer.php') ?>