-- Enable Row Level Security
ALTER DATABASE postgres SET "app.jwt_secret" TO 'your-jwt-secret';

-- Create users table
CREATE TABLE IF NOT EXISTS public.users (
    id UUID REFERENCES auth.users NOT NULL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    nama TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('teacher', 'student')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Create students table
CREATE TABLE IF NOT EXISTS public.students (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nisn TEXT UNIQUE NOT NULL,
    nama TEXT NOT NULL,
    kelas TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Create attendance table
CREATE TABLE IF NOT EXISTS public.attendance (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nisn TEXT NOT NULL,
    nama TEXT NOT NULL,
    kelas TEXT NOT NULL,
    jam_masuk TIME,
    jam_keluar TIME,
    tanggal DATE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    UNIQUE(nisn, tanggal)
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;

-- Create policies for users table
CREATE POLICY "Users can view own profile" ON public.users
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.users
    FOR UPDATE USING (auth.uid() = id);

-- Create policies for students table
CREATE POLICY "Authenticated users can view students" ON public.students
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Teachers can insert students" ON public.students
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.users 
            WHERE id = auth.uid() AND role = 'teacher'
        )
    );

CREATE POLICY "Teachers can update students" ON public.students
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM public.users 
            WHERE id = auth.uid() AND role = 'teacher'
        )
    );

CREATE POLICY "Teachers can delete students" ON public.students
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM public.users 
            WHERE id = auth.uid() AND role = 'teacher'
        )
    );

-- Create policies for attendance table
CREATE POLICY "Authenticated users can view attendance" ON public.attendance
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can insert attendance" ON public.attendance
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update attendance" ON public.attendance
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Teachers can delete attendance" ON public.attendance
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM public.users 
            WHERE id = auth.uid() AND role = 'teacher'
        )
    );

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_students_nisn ON public.students(nisn);
CREATE INDEX IF NOT EXISTS idx_students_kelas ON public.students(kelas);
CREATE INDEX IF NOT EXISTS idx_attendance_nisn ON public.attendance(nisn);
CREATE INDEX IF NOT EXISTS idx_attendance_tanggal ON public.attendance(tanggal);
CREATE INDEX IF NOT EXISTS idx_attendance_kelas ON public.attendance(kelas);
CREATE INDEX IF NOT EXISTS idx_attendance_nisn_tanggal ON public.attendance(nisn, tanggal);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc'::text, NOW());
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for attendance table
CREATE TRIGGER update_attendance_updated_at 
    BEFORE UPDATE ON public.attendance 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data (optional)
-- INSERT INTO public.students (nisn, nama, kelas) VALUES
-- ('1234567890', 'Ahmad Rizki', 'X-A'),
-- ('1234567891', 'Siti Nurhaliza', 'X-A'),
-- ('1234567892', 'Budi Santoso', 'X-B'),
-- ('1234567893', 'Dewi Sartika', 'X-B'),
-- ('1234567894', 'Eko Prasetyo', 'XI-A');
