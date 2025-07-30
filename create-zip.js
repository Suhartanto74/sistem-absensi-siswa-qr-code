const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🚀 Membuat file zip untuk distribusi...');

// Daftar file dan folder yang akan dimasukkan ke zip
const filesToInclude = [
  // Core application files
  'src/',
  'public/',
  'scripts/',
  
  // Configuration files
  'package.json',
  'package-lock.json',
  'next.config.ts',
  'tsconfig.json',
  'postcss.config.mjs',
  'tailwind.config.ts',
  'components.json',
  'eslint.config.mjs',
  
  // Environment and deployment
  '.env.local.example',
  'vercel.json',
  
  // Database and documentation
  'database-schema.sql',
  'README.md',
  'INSTALASI.md',
  'DEPLOYMENT.md',
  
  // Git files (optional)
  '.gitignore'
];

// Files to exclude
const filesToExclude = [
  '.env.local',
  'node_modules/',
  '.next/',
  '.git/',
  'create-zip.js',
  '*.zip'
];

try {
  // Create zip using system zip command
  const zipName = 'sistem-absensi-siswa.zip';
  
  // Remove existing zip if exists
  if (fs.existsSync(zipName)) {
    fs.unlinkSync(zipName);
    console.log('📦 Menghapus zip lama...');
  }
  
  // Create zip command
  let zipCommand = `zip -r ${zipName}`;
  
  // Add files to include
  filesToInclude.forEach(file => {
    if (fs.existsSync(file)) {
      zipCommand += ` "${file}"`;
    }
  });
  
  // Add exclusions
  zipCommand += ' -x';
  filesToExclude.forEach(exclude => {
    zipCommand += ` "${exclude}"`;
  });
  
  console.log('📦 Membuat zip file...');
  execSync(zipCommand, { stdio: 'inherit' });
  
  // Check if zip was created successfully
  if (fs.existsSync(zipName)) {
    const stats = fs.statSync(zipName);
    const fileSizeInMB = (stats.size / (1024 * 1024)).toFixed(2);
    
    console.log('✅ Zip file berhasil dibuat!');
    console.log(`📁 Nama file: ${zipName}`);
    console.log(`📏 Ukuran: ${fileSizeInMB} MB`);
    console.log('');
    console.log('🎉 File siap untuk distribusi!');
    console.log('');
    console.log('📋 Cara menggunakan:');
    console.log('1. Copy file zip ke perangkat lain');
    console.log('2. Extract zip file');
    console.log('3. Ikuti panduan di INSTALASI.md');
    console.log('4. Jalankan: npm install && npm run dev');
  } else {
    throw new Error('Zip file tidak berhasil dibuat');
  }
  
} catch (error) {
  console.error('❌ Error membuat zip:', error.message);
  console.log('');
  console.log('🔧 Alternatif manual:');
  console.log('1. Copy semua file kecuali node_modules/, .next/, .git/');
  console.log('2. Buat zip manual menggunakan file explorer');
  console.log('3. Atau gunakan: tar -czf sistem-absensi-siswa.tar.gz . --exclude=node_modules --exclude=.next --exclude=.git');
}
