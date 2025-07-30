const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

// Create template data
const templateData = [
  {
    'NISN': '1234567890',
    'Nama Siswa': 'Contoh Nama Siswa 1',
    'Kelas': 'X-A',
    'Jam Masuk': '07:30',
    'Jam Keluar': '15:00'
  },
  {
    'NISN': '1234567891',
    'Nama Siswa': 'Contoh Nama Siswa 2',
    'Kelas': 'X-A',
    'Jam Masuk': '07:45',
    'Jam Keluar': '15:00'
  },
  {
    'NISN': '1234567892',
    'Nama Siswa': 'Contoh Nama Siswa 3',
    'Kelas': 'X-B',
    'Jam Masuk': '08:00',
    'Jam Keluar': '15:00'
  }
];

// Create worksheet
const worksheet = XLSX.utils.json_to_sheet(templateData);

// Set column widths
worksheet['!cols'] = [
  { width: 15 }, // NISN
  { width: 25 }, // Nama Siswa
  { width: 10 }, // Kelas
  { width: 12 }, // Jam Masuk
  { width: 12 }  // Jam Keluar
];

// Add header styling (basic)
const range = XLSX.utils.decode_range(worksheet['!ref']);
for (let C = range.s.c; C <= range.e.c; ++C) {
  const address = XLSX.utils.encode_cell({ r: 0, c: C });
  if (!worksheet[address]) continue;
  worksheet[address].s = {
    font: { bold: true },
    fill: { fgColor: { rgb: "EEEEEE" } }
  };
}

// Create workbook
const workbook = XLSX.utils.book_new();
XLSX.utils.book_append_sheet(workbook, worksheet, 'Template Absensi');

// Ensure public directory exists
const publicDir = path.join(__dirname, '..', 'public');
if (!fs.existsSync(publicDir)) {
  fs.mkdirSync(publicDir, { recursive: true });
}

// Write file
const filePath = path.join(publicDir, 'template_absensi.xlsx');
XLSX.writeFile(workbook, filePath);

console.log('Template Excel berhasil dibuat di:', filePath);
