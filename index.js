const express = require("express");
const cors = require("cors");
require("dotenv").config();

const marketingRoutes = require("./routes/marketing");
const komisiRoutes = require("./routes/komisi");
const pembayaranRoutes = require("./routes/pembayaran");

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use("/api/marketing", marketingRoutes);
app.use("/api/komisi", komisiRoutes);
app.use("/api/pembayaran", pembayaranRoutes);

app.get("/", (req, res) => {
  res.send("Sales Commission API is running...");
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
