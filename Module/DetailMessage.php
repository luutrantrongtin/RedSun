<?php session_start(); ?>
<?php include "include/header.php" ?>
<?php include("include/sidebar_left.php") ?>

<section>
    <?php //Nếu server có gửi POST thì bắt đầu xử lí form
    $id=$_REQUEST['id'];
    $_SESSION['messid']=$id;
    $query  = "call ViewDetailMessage($id)";
    $result = $dbc->query($query);
    $row=$result->fetch_array();
    echo "Chủ đề: ".$row[2]."<br>";
    echo "Nội dung: ".$row[3]."<br>";
    echo "Người gửi: ".$row[7]."<br>";
    $_SESSION['chude']=$row[2];
    $_SESSION['nguoigui']=$row[7];

    /*$result->free();
    $dbc->next_result();
    $query  = "call UpdateMessage($id)";
    $result = $dbc->query($query);
    $result->fetch_array();
    $dbc->close();*/
    ?>
     <a href="ReplyMessage.php"><input type="button" value="Reply"></a>

</section>
<aside id="right"></aside>

<?php include('include/footer.php') ?>
