-- Script untuk membuat user default
-- Jalankan setelah setup database schema

-- Insert default users ke auth.users (ini akan dilakukan melalui Supabase Auth)
-- Kemudian insert ke public.users table

-- Default Guru Account
-- Email: admin@sekolah.com
-- Password: Admin123456
-- Role: teacher

-- Default Siswa Account  
-- Email: siswa@sekolah.com
-- Password: Siswa123456
-- Role: student

-- Catatan: User harus dibuat melalui Supabase Auth terlebih dahulu
-- Kemudian jalankan query berikut untuk menambahkan ke tabel users:

-- INSERT INTO public.users (id, email, nama, role) VALUES 
-- ('uuid-dari-auth-users-admin', 'admin@sekolah.com', 'Administrator', 'teacher'),
-- ('uuid-dari-auth-users-siswa', 'siswa@sekolah.com', 'Siswa Demo', 'student');

-- Atau gunakan fungsi berikut untuk auto-create:
CREATE OR REPLACE FUNCTION create_default_users()
RETURNS void AS $$
BEGIN
  -- Insert default teacher if not exists
  INSERT INTO public.users (id, email, nama, role)
  SELECT 
    gen_random_uuid(),
    'admin@sekolah.com',
    'Administrator',
    'teacher'
  WHERE NOT EXISTS (
    SELECT 1 FROM public.users WHERE email = 'admin@sekolah.com'
  );

  -- Insert default student if not exists
  INSERT INTO public.users (id, email, nama, role)
  SELECT 
    gen_random_uuid(),
    'siswa@sekolah.com', 
    'Siswa Demo',
    'student'
  WHERE NOT EXISTS (
    SELECT 1 FROM public.users WHERE email = 'siswa@sekolah.com'
  );
END;
$$ LANGUAGE plpgsql;

-- Jalankan fungsi
SELECT create_default_users();
