const express = require("express");
const router = express.Router();
const pool = require("../db");

const calculateCommission = (omzet) => {
  if (omzet >= 500000000) return 0.1;
  if (omzet >= 200000000) return 0.05;
  if (omzet >= 100000000) return 0.025;
  return 0;
};

// Get the commission data per transaction for each marketing
router.get("/", async (req, res) => {
  try {
    const currentYear = 2023; // Hardcode tahun 2023 karena data di database hanya untuk tahun tersebut
    const year = req.query.year || currentYear; // Gunakan parameter query atau default ke tahun 2023

    console.log("Fetching transactions for year:", year);

    // Query untuk mengambil semua transaksi per marketing dalam tahun tertentu
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

    // Struktur data untuk hasil akhir
    const commissionsData = {};

    result.rows.forEach((row) => {
      const omzet = parseFloat(row.omzet);
      if (isNaN(omzet)) return;

      const komisiPersen = calculateCommission(omzet);
      const komisiNominal = omzet * komisiPersen;

      // Jika marketing belum ada di object, inisialisasi
      if (!commissionsData[row.marketing]) {
        commissionsData[row.marketing] = [];
      }

      // Tambahkan transaksi ke dalam array marketing terkait
      commissionsData[row.marketing].push({
        transaction_number: row.transaction_number, // Ganti invoice_id dengan transaction_number
        tanggal_transaksi: row.tanggal_transaksi,
        omzet: omzet,
        komisi_persen: komisiPersen * 100, // Konversi ke persen
        komisi_nominal: komisiNominal,
      });
    });

    console.log("Final Data:", commissionsData);

    // Format data untuk response
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
