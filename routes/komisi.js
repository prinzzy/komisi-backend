const express = require("express");
const router = express.Router();
const pool = require("../db");

const calculateCommission = (omzet) => {
  if (omzet >= 500000000) return 0.1;
  if (omzet >= 200000000) return 0.05;
  if (omzet >= 100000000) return 0.025;
  return 0;
};


router.get("/", async (req, res) => {
  try {
    const currentYear = 2023; 
    const year = req.query.year || currentYear; 

    console.log("Fetching transactions for year:", year);


    const query = `
      SELECT 
        m.name AS marketing,
        p.transaction_number, 
        TO_CHAR(p.date, 'YYYY-MM-DD') AS tanggal_transaksi,
        p.total_balance AS omzet
      FROM penjualan p
      JOIN marketing m ON p.marketing_id = m.id
      WHERE EXTRACT(YEAR FROM p.date) = $1
      ORDER BY m.name, p.date;
    `;

    console.log("Executing Query:", query);

    const result = await pool.query(query, [year]);

    console.log("Query Result:", result.rows);


    const commissionsData = {};

    result.rows.forEach((row) => {
      const omzet = parseFloat(row.omzet);
      if (isNaN(omzet)) return;

      const komisiPersen = calculateCommission(omzet);
      const komisiNominal = omzet * komisiPersen;

      if (!commissionsData[row.marketing]) {
        commissionsData[row.marketing] = [];
      }

      commissionsData[row.marketing].push({
        transaction_number: row.transaction_number, 
        tanggal_transaksi: row.tanggal_transaksi,
        omzet: omzet,
        komisi_persen: komisiPersen * 100,
        komisi_nominal: komisiNominal,
      });
    });

    console.log("Final Data:", commissionsData);

  
    const data = Object.keys(commissionsData).map((marketing) => ({
      marketing,
      transactions: commissionsData[marketing],
    }));

    res.json(data);
  } catch (err) {
    console.error("Error:", err.message);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
