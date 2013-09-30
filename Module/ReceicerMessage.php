<?php session_start(); ?>
<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

    <section>
        <?php //Nếu server có gửi POST thì bắt đầu xử lí form
        $sendid=$_SESSION['empid'];


            $query  = "call ViewMessage($sendid)";
            $result = $dbc->query($query);
            while($row=$result->fetch_array()){
                if($row[1]==null)
                    echo "NEW---";
                else
                    echo "REPLY----";
                echo "Chủ đề: ".$row[2];
                if($row[4]==null)
                    echo "--Chưa xem--";
                else
                    echo "--Đã xem--";
                echo '  <a href="DetailMessage.php?id='.$row[0].'"><input type="button" value="Xem chi tiết"></a><br>';
            }
        ?>
    </section>
    <aside id="right"></aside>

<?php include('include/footer.php') ?>
