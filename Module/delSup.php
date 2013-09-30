<?php include "include/header.php" ?>
<?php
$id=$_REQUEST['id'];
$query = "call DeleteSupplier($id)";
$dbc->query($query) or die($dbc->error);
if ($dbc->affected_rows >= 0) {
    //không hiểu tại sao chỗ này dù đã commit thành công nhưng vẫn trả về 0
    echo "Cập nhật thành công";
}
else {
    echo "Cập nhật thất bại" . "<br>" . $dbc->error;
}

?>
<meta http-equiv="refresh" content="0;URL=http://localhost/theenterprise/module/viewSupplier.php">