const express = require("express");
const router = express.Router();
const pool = require("../db");


router.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM pembayaran");
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});


router.post("/", async (req, res) => {
  const { transaction_id, amount, payment_date } = req.body;


  if (!transaction_id || !amount || !payment_date) {
    return res.status(400).json({ message: "All fields are required." });
  }

  try {

    await pool.query(
      "INSERT INTO pembayaran (transaction_id, amount, payment_date) VALUES ($1, $2, $3)",
      [transaction_id, amount, payment_date]
    );

    res.json({ message: "Payment recorded successfully" });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
