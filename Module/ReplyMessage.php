<?php session_start(); ?>
<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

    <section>
        <?php //Nếu server có gửi POST thì bắt đầu xử lí form
        $sendid=$_SESSION['empid'];
        $nguoinhan=$_SESSION['nguoigui'];
        $chude=$_SESSION['chude'];
        $reply=$_SESSION['messid'];

        if ($_SERVER['REQUEST_METHOD'] == "POST") {
            $content=$_POST['content'];
            $query  = "call ReplyMessage($reply,$sendid,$nguoinhan,'$chude','$content')";
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
        <form action="ReplyMessage.php" method="post">
            Tên người nhận:
            <br>
            <input type="text" name="receiverid" style="width: 50%" value="<?=$nguoinhan; ?>"/>
            <br>

            Chủ đề:
            <br>
            <input type="text" name="subject" style="width: 50%" value="<?=$chude; ?>"/>
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