<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Budget Manager</title>
    <link rel="stylesheet" href="assets/css/styles.css">
    <script src="assets/js/script.js" defer></script>
</head>
<body>
    <h1>Budget Manager</h1>

    <!-- Subaccounts Display -->
    <?php
    // Fetch subaccounts and transactions from the database
    require 'db_connection.php';
    $subaccounts = $db->query("SELECT * FROM subaccounts");

    while ($subaccount = $subaccounts->fetch_assoc()) {
        echo "<section>";
        echo "<h2>{$subaccount['name']} - Balance: {$subaccount['balance']}</h2>";

        // Fetch transactions for each subaccount
        $subaccount_id = $subaccount['id'];
        $transactions = $db->query("SELECT * FROM transactions WHERE subaccount_id = $subaccount_id ORDER BY timestamp DESC");
        
        echo "<ul>";
        while ($transaction = $transactions->fetch_assoc()) {
            echo "<li>{$transaction['description']}: \${$transaction['amount']} on {$transaction['timestamp']}</li>";
        }
        echo "</ul>";
        echo "</section>";
    }
    ?>

    <!-- Add New Transaction Form -->
    <form id="transactionForm" action="add_transaction.php" method="post">
        <input type="text" name="description" placeholder="Description" required>
        <input type="number" name="amount" placeholder="Amount" required>
        <select name="subaccount_id">
            <?php
            // Populate dropdown with subaccounts
            $subaccounts->data_seek(0);
            while ($subaccount = $subaccounts->fetch_assoc()) {
                echo "<option value='{$subaccount['id']}'>{$subaccount['name']}</option>";
            }
            ?>
        </select>
        <button type="submit">Add Transaction</button>
    </form>
</body>
</html>
