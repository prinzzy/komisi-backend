const express = require("express");
const router = express.Router();
const pool = require("../db");

// Get all marketing
router.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM marketing");
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
