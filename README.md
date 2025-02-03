### 1. Persiapkan Lingkungan, clone repo dan install depedencies

install

```bash
git clone https://github.com/prinzzy/komisi-backend.git
cd komisi-backend
npm install
```

### 2. Konfigurasi Database

Buat database baru di PostgreSQL dan konfigurasi koneksi di backend. Pastikan Anda sudah menambahkan konfigurasi database di file .env di folder root proyek Anda.

Contoh file .env untuk Express.js:

DB_HOST=localhost
DB_PORT=5432
DB_USER=your-db-user
DB_PASSWORD=your-db-password
DB_NAME=your-db-name

import database sales_db.sql yang telah tersedia terlebih dahulu menggunakan PgAdmin

### 3. Jalankan Backend (Express.js)

Setelah konfigurasi selesai, jalankan server Express.js dengan perintah berikut:

```bash
npm run dev
Backend akan berjalan di http://localhost:5500.
```

### 4. Postman Collection

Import Postman Collection untuk uji coba api
