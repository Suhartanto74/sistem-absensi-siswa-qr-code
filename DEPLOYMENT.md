# Panduan Deployment Sistem Absensi Siswa

## 🚀 Deployment ke Vercel + Supabase

### 1. Persiapan Supabase

1. **Buat Project Supabase**
   ```bash
   # Kunjungi https://supabase.com
   # Klik "New Project"
   # Pilih organization dan isi detail project
   ```

2. **Setup Database**
   - Buka SQL Editor di dashboard Supabase
   - Copy seluruh isi file `database-schema.sql`
   - Paste dan jalankan di SQL Editor
   - Pastikan semua tabel berhasil dibuat

3. **Dapatkan Kredensial**
   - Buka Settings → API
   - Copy `Project URL` dan `anon public key`

### 2. Deployment ke Vercel

1. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **Login ke Vercel**
   ```bash
   vercel login
   ```

3. **Deploy Project**
   ```bash
   vercel
   ```
   
   Ikuti instruksi:
   - Link to existing project? → No
   - Project name → sistem-absensi-siswa (atau nama lain)
   - Directory → ./
   - Override settings? → No

4. **Set Environment Variables**
   ```bash
   vercel env add NEXT_PUBLIC_SUPABASE_URL
   # Paste URL Supabase Anda
   
   vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY
   # Paste anon key Supabase Anda
   ```

5. **Deploy Ulang**
   ```bash
   vercel --prod
   ```

### 3. Konfigurasi Domain (Opsional)

1. **Custom Domain**
   - Buka dashboard Vercel
   - Pilih project → Settings → Domains
   - Tambahkan domain custom
   - Update DNS records sesuai instruksi

2. **SSL Certificate**
   - Otomatis dihandle oleh Vercel
   - Tunggu beberapa menit untuk aktivasi

### 4. Testing Deployment

1. **Test Basic Functionality**
   ```bash
   curl https://your-app.vercel.app/api/attendance
   ```

2. **Test Authentication**
   - Buka aplikasi di browser
   - Coba registrasi akun baru
   - Test login/logout

3. **Test QR Scanner**
   - Pastikan menggunakan HTTPS (required untuk camera access)
   - Test di mobile browser

## 📱 Setup PWA

### Android
1. Buka aplikasi di Chrome
2. Tap menu (3 titik) → "Add to Home screen"
3. Aplikasi akan muncul di home screen

### iOS
1. Buka aplikasi di Safari
2. Tap Share button → "Add to Home Screen"
3. Aplikasi akan muncul di home screen

## 🔧 Environment Variables

Pastikan environment variables berikut sudah diset di Vercel:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
```

## 🔒 Security Checklist

- [ ] RLS (Row Level Security) enabled di Supabase
- [ ] Environment variables tidak ter-commit ke git
- [ ] HTTPS enabled (otomatis di Vercel)
- [ ] Authentication policies configured
- [ ] API rate limiting (built-in di Vercel)

## 📊 Monitoring

### Vercel Analytics
- Otomatis tersedia di dashboard Vercel
- Monitor performance dan usage

### Supabase Monitoring
- Dashboard → Settings → Usage
- Monitor database usage dan API calls

## 🐛 Troubleshooting

### Common Issues

1. **QR Scanner tidak berfungsi**
   - Pastikan menggunakan HTTPS
   - Check browser permissions untuk camera
   - Test di browser yang berbeda

2. **Database connection error**
   - Verify environment variables
   - Check Supabase project status
   - Verify RLS policies

3. **Build errors**
   ```bash
   # Local testing
   npm run build
   npm run start
   ```

4. **API errors**
   ```bash
   # Check Vercel function logs
   vercel logs
   ```

### Debug Commands

```bash
# Check environment variables
vercel env ls

# View deployment logs
vercel logs --follow

# Local development with production env
vercel dev
```

## 🔄 Updates dan Maintenance

### Update Dependencies
```bash
npm update
npm audit fix
vercel --prod
```

### Database Migrations
- Buat backup database di Supabase
- Test perubahan di development
- Apply ke production via SQL Editor

### Monitoring Checklist
- [ ] Check Vercel analytics weekly
- [ ] Monitor Supabase usage monthly
- [ ] Update dependencies monthly
- [ ] Backup database monthly

## 📞 Support

Jika mengalami masalah deployment:

1. Check Vercel deployment logs
2. Verify Supabase connection
3. Test API endpoints dengan curl
4. Check browser console untuk client errors

## 🎯 Production Checklist

Sebelum go-live:

- [ ] Database schema deployed
- [ ] Environment variables configured
- [ ] Custom domain setup (jika ada)
- [ ] SSL certificate active
- [ ] PWA manifest working
- [ ] QR scanner tested on mobile
- [ ] Excel upload/download tested
- [ ] Authentication flow tested
- [ ] Reports generation tested
- [ ] Mobile responsiveness verified
- [ ] Performance optimization done

---

**Selamat! Aplikasi Absensi Siswa Anda sudah siap digunakan! 🎉**
