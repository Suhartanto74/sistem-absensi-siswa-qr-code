# 📦 Panduan Instalasi Aplikasi Absensi Siswa

## 🚀 Cara Install di Perangkat Lain

### 1. Persiapan Sistem

**Persyaratan:**
- Node.js 18+ ([Download di nodejs.org](https://nodejs.org))
- Git (opsional)
- Browser modern (Chrome/Firefox/Safari)

### 2. Ekstrak dan Install

```bash
# 1. Ekstrak file zip
unzip sistem-absensi-siswa.zip
cd sistem-absensi-siswa

# 2. Install dependencies
npm install

# 3. Copy environment file
cp .env.local.example .env.local

# 4. Jalankan aplikasi
npm run dev
```

Aplikasi akan berjalan di: `http://localhost:8000`

### 3. Setup Database (Wajib untuk Fungsi Penuh)

**Langkah Setup Supabase:**

1. **Buat Project Supabase**
   - Kunjungi [supabase.com](https://supabase.com)
   - Klik "New Project"
   - Isi nama project dan password database

2. **Setup Database Schema**
   - Buka SQL Editor di dashboard Supabase
   - Copy seluruh isi file `database-schema.sql`
   - Paste dan jalankan (klik RUN)

3. **Dapatkan Kredensial**
   - Buka Settings → API
   - Copy `Project URL` dan `anon public key`

4. **Update Environment Variables**
   Edit file `.env.local`:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
   ```

5. **Buat Akun Default**
   - Buka Authentication → Users di dashboard Supabase
   - Klik "Add User" dan buat:
     - Email: `admin@sekolah.com`, Password: `Admin123456`
     - Email: `siswa@sekolah.com`, Password: `Siswa123456`

6. **Restart Aplikasi**
   ```bash
   # Tekan Ctrl+C untuk stop, lalu:
   npm run dev
   ```

### 4. Akses Aplikasi

1. **Buka Browser** → `http://localhost:8000`
2. **Login dengan akun default:**
   - **Guru**: admin@sekolah.com / Admin123456
   - **Siswa**: siswa@sekolah.com / Siswa123456

### 5. Install sebagai PWA (Opsional)

**Android:**
1. Buka aplikasi di Chrome
2. Tap menu (3 titik) → "Add to Home screen"
3. Aplikasi akan muncul di home screen

**iOS:**
1. Buka aplikasi di Safari
2. Tap Share → "Add to Home Screen"
3. Aplikasi akan muncul di home screen

**Desktop:**
1. Buka aplikasi di Chrome
2. Klik ikon install di address bar
3. Aplikasi akan terinstall seperti aplikasi desktop

### 6. Deploy Online (Opsional)

**Deploy ke Vercel (Gratis):**

```bash
# 1. Install Vercel CLI
npm install -g vercel

# 2. Login ke Vercel
vercel login

# 3. Deploy
vercel

# 4. Set environment variables
vercel env add NEXT_PUBLIC_SUPABASE_URL
vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY

# 5. Deploy production
vercel --prod
```

### 7. Troubleshooting

**Masalah Umum:**

1. **"Command not found: npm"**
   - Install Node.js dari nodejs.org
   - Restart terminal/command prompt

2. **"Port 8000 already in use"**
   ```bash
   # Windows
   netstat -ano | findstr :8000
   taskkill /PID <PID_NUMBER> /F
   
   # Mac/Linux
   lsof -ti:8000 | xargs kill -9
   ```

3. **"Failed to fetch" atau error Supabase**
   - Pastikan Supabase sudah dikonfigurasi
   - Cek file `.env.local` sudah benar
   - Pastikan database schema sudah dijalankan

4. **QR Scanner tidak berfungsi**
   - Gunakan HTTPS (deploy online)
   - Pastikan browser memiliki akses kamera
   - Coba browser lain (Chrome recommended)

### 8. Fitur Aplikasi

**Untuk Guru:**
- Kelola data siswa (tambah/edit/hapus)
- Generate QR code individual/massal
- Input absensi (manual/QR/Excel)
- Lihat laporan kehadiran
- Export data ke CSV

**Untuk Siswa:**
- Login dengan akun siswa
- Scan QR code untuk absen masuk/keluar
- Lihat status kehadiran

### 9. File Penting

- `README.md` - Dokumentasi lengkap
- `database-schema.sql` - Schema database
- `public/template_absensi.xlsx` - Template Excel
- `.env.local.example` - Template environment variables
- `DEPLOYMENT.md` - Panduan deployment

### 10. Support

Jika mengalami masalah:
1. Baca file `README.md` untuk dokumentasi lengkap
2. Cek console browser untuk error messages
3. Pastikan semua langkah setup sudah diikuti
4. Verifikasi environment variables sudah benar

---

**🎉 Selamat! Aplikasi Absensi Siswa siap digunakan!**

Aplikasi ini dapat diakses dari smartphone dan desktop, serta dapat diinstall sebagai PWA untuk pengalaman seperti aplikasi native.
