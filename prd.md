DeenApp - habit tracker n gamification muslim pro app 

fitur:
1. auth google
2. zikir 
    1. habis solat
    2. pagi petang
3. azan = ada waktu next waktu solat berikutnya dan jika telah memasuki waktu tersebut maka akan azan 
4. izinkan lokasi untuk mensinkronkan data waktu azan di tempat user berada
5. hadith of the day 
6. al quran 
7. donasi ke aplikasi ini jika mau 
 
silahkan tambahkan jika ada saran 
Tambahan Saran Fitur (Gamifikasi & Engagement)
Agar aspek "Gamification" benar-benar terasa dan tidak membosankan, Anda bisa menambahkan:
* XP & Leveling System: Setiap kali user menyelesaikan zikir atau salat tepat waktu, mereka mendapatkan XP. Level bisa dinamai dengan tingkatan yang memotivasi (contoh: Muhsin, Muttaqin).
* Daily Streaks: Menampilkan berapa hari berturut-turut user menyelesaikan target harian (misal: salat 5 waktu di awal waktu).
* Leaderboard (Opsional/Social): Bisa melihat peringkat teman atau global berdasarkan poin ibadah mingguan.
* Virtual Garden/Town: Semakin rajin beribadah, "kebun spiritual" di dalam aplikasi semakin hijau dan tumbuh bunga. Ini memberikan visualisasi progres yang memuaskan.
* Badges/Achievements: Medali untuk pencapaian tertentu, misal: "Khatam Al-Quran 1x", "Pejuang Tahajud 7 Hari", atau "Zikir Pagi Tak Terlewatkan".


tech stack :
fe = flutter
be= go 
auth/db = supabase

3. The "Zen Monochrome" (Nature-Inspired)
Mengambil nuansa hitam ke arah Charcoal dengan sentuhan hijau zaitun yang sangat gelap (warna identik Islam) namun tetap modern.
Elemen	Kode Warna (Hex)	Kesan
Primary Background	#121412	Hitam dengan sedikit tint hijau zaitun tua.
Secondary Surface	#1E211E	Area untuk tracking habit.
Accent Glow	#A8C69F	Sage Green pucat untuk indikator target selesai.
Text Primary	#F5F5F5	Putih bersih.


1. Tentukan "Core Aesthetic" (Visual Direction)
Karena Anda menyukai gaya minimalis hitam-putih, gunakan prinsip "OLED Dark Mode" sebagai basis utama.
* Background: Gunakan Hitam Pekat (#000000) untuk layar utama. Ini akan membuat teks putih dan elemen grafik terlihat sangat kontras dan elegan.
* Typography: Gunakan font Sans Serif yang modern dan bersih.
    * Rekomendasi: Inter, Plus Jakarta Sans, atau Satoshi.
    * Untuk teks Arab (Al-Quran/Zikir), gunakan font yang tipis dan modern seperti Amiri atau IBM Plex Sans Arabic.
* Accents: Meskipun monochrome, gunakan satu warna aksen tipis (misal: Emerald Green yang sangat gelap atau Gold redup) hanya untuk indikator penting, atau tetap setia pada gradasi abu-abu (Grey Scale).

2. Implementasi Gamifikasi dalam Minimalisme
Gamifikasi biasanya identik dengan warna-warni (seperti Duolingo). Untuk menjaga gaya Anda, lakukan cara ini:
* Progress Rings: Gunakan lingkaran progres dengan garis tipis (thin stroke). Saat target zikir tercapai, garis yang tadinya abu-abu redup berubah menjadi putih terang atau menyala (glow).
* Micro-interactions: Gunakan animasi halus saat user menekan tombol zikir (Haptic Feedback + sedikit pembesaran skala/scale up).
* Minimalist Badges: Alih-alih medali warna-warni, gunakan ikon Line Art (outline) yang elegan untuk achievements.

3. Struktur Layout (The "Zen" Layout)
Aplikasi ibadah harus menenangkan, bukan membingungkan.
* Bento Grid: Gunakan layout kotak-kotak (Bento Box) yang populer di desain modern untuk menampilkan waktu salat berikutnya, jumlah zikir, dan Hadith of the Day.
* Negative Space: Jangan buat layar penuh sesak. Berikan jarak (padding) yang luas antar elemen agar user bisa fokus (khusyuk).
* Glassmorphism: Gunakan efek kaca transparan (blur) pada card di atas latar belakang hitam untuk memberikan kedalaman (depth).

4. Moodboard & Inspirasi
Untuk mempermudah Anda, coba cari referensi desain dengan keyword ini di Dribbble atau Pinterest:
1. "Minimalist Fintech App UI" (untuk struktur angka dan grafik).
2. "Modern Monochrome Dashboard".
3. "Apple Health App Redesign" (untuk gaya tracking habit).
