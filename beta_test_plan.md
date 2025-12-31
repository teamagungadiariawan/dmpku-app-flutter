# Rencana Pengujian Beta - Aplikasi DMPKU

Dokumen ini menjelaskan skenario pengujian dan langkah-langkah yang perlu dilakukan oleh beta tester untuk memverifikasi fungsionalitas aplikasi DMPKU.

## Tujuan

- Mengidentifikasi dan melaporkan bug, error, atau perilaku tak terduga.
- Memastikan semua fitur berfungsi sesuai dengan yang diharapkan.
- Memberikan masukan mengenai pengalaman pengguna (UX) dan antarmuka pengguna (UI).

## Cara Mengisi Laporan

Untuk setiap skenario uji, mohon ikuti langkah-langkah yang diberikan dan catat hasilnya.

- **Hasil Aktual:** Jelaskan apa yang sebenarnya terjadi saat Anda melakukan langkah-langkah tersebut.
- **Status:** Beri tanda **Pass** jika Hasil Aktual sesuai dengan Hasil yang Diharapkan. Beri tanda **Fail** jika tidak, dan berikan penjelasan singkat di kolom Hasil Aktual.
- **Screenshot:** Jika memungkinkan, lampirkan screenshot untuk kasus **Fail**.

---

## Modul: Akun Anggota (`MemberAkunPage`)

Halaman ini adalah pusat untuk semua pengaturan dan informasi terkait akun pengguna.

| Fitur | Skenario Uji | Langkah-langkah | Hasil yang Diharapkan | Hasil Aktual | Status (Pass/Fail) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Tampilan & Data** | Memverifikasi tampilan awal halaman Akun | 1. Login ke aplikasi sebagai anggota.<br>2. Tekan ikon "Akun" di bilah navigasi bawah.<br>3. Perhatikan seluruh halaman. | - Halaman Akun ditampilkan dengan header, kartu saldo, dan beberapa bagian menu.<br>- Nama dan level pengguna (misal: "Mitra DMPKU") ditampilkan dengan benar di header. | | |
| **Saldo** | Menyembunyikan dan menampilkan saldo | 1. Di halaman Akun, cari kartu saldo.<br>2. Tekan ikon mata (atau tombol "Lihat").<br>3. Tekan lagi ikon mata tersebut. | - Saldo awalnya terlihat.<br>- Setelah menekan ikon mata, saldo berubah menjadi "Rp ••••••••".<br>- Menekan lagi akan menampilkan kembali jumlah saldo yang benar. | | |
| **Saldo** | Memperbarui saldo dengan tombol segarkan | 1. Di kartu saldo, tekan ikon segarkan (refresh). | - Ikon segarkan berputar (menandakan loading).<br>- Saldo diperbarui sesuai dengan data terbaru dari server. | | |
| **Saldo** | Memperbarui saldo dengan tarik-ke-bawah (pull-to-refresh) | 1. Di halaman Akun, scroll ke atas hingga muncul indikator refresh.<br>2. Tarik ke bawah dan lepaskan. | - Indikator refresh muncul dan berputar.<br>- Saldo dan informasi profil lainnya diperbarui. | | |
| **Navigasi** | Memulai alur "Isi Saldo" | 1. Di kartu saldo, tekan tombol "Isi Saldo". | - Pengguna dinavigasikan ke halaman "Isi Stok". | | |
| **Navigasi Menu** | Membuka "Detail Akun" | 1. Di bawah "General", tekan menu "Detail Akun". | - Pengguna dinavigasikan ke halaman Detail Akun. | | |
| **Navigasi Menu** | Membuka "Detail Device" | 1. Di bawah "General", tekan menu "Detail Device". | - Pengguna dinavigasikan ke halaman Daftar Device. | | |
| **Navigasi Menu** | Membuka "Daftar Favorit" | 1. Di bawah "General", tekan menu "Daftar Favorit". | - Pengguna dinavigasikan ke halaman Daftar Favorit. | | |
| **Tautan Eksternal** | Membuka laman "Beri Penilaian" | 1. Di bawah "General", tekan menu "Beri Penilaian". | - Aplikasi membuka browser atau Google Play Store ke halaman aplikasi DMPKU. | | |
| **Tautan Eksternal** | Menghubungi Customer Service | 1. Tekan kartu "Punya Pertanyaan?". | - Aplikasi membuka WhatsApp untuk chat dengan Customer Service. | | |
| **Keamanan** | Membuka dialog "Ganti PIN" | 1. Di bawah "Keamanan Akun", tekan menu "Ganti PIN". | - Sebuah dialog (modal sheet) muncul dari bawah untuk mengganti PIN. | | |
| **Dialog Ganti PIN** | Validasi input kosong | 1. Buka dialog Ganti PIN.<br>2. Jangan isi field apapun.<br>3. Tekan tombol "Ganti Pin". | - Pesan error muncul di bawah setiap field yang menyatakan "tidak boleh kosong". | | |
| **Dialog Ganti PIN** | Validasi panjang PIN | 1. Buka dialog Ganti PIN.<br>2. Isi field "Pin Lama" dengan kurang dari 6 digit (misal: "123").<br>3. Tekan "Ganti Pin". | - Pesan error muncul: "PIN lama harus terdiri dari 6 digit". | | |
| **Dialog Ganti PIN** | Validasi PIN baru tidak sama dengan PIN lama | 1. Buka dialog Ganti PIN.<br>2. Isi "Pin Lama" dengan PIN Anda saat ini.<br>3. Isi "Pin Baru" dengan PIN yang sama.<br>4. Tekan "Ganti Pin". | - Pesan error muncul: "PIN baru tidak boleh sama dengan PIN lama". | | |
| **Dialog Ganti PIN**| Validasi konfirmasi PIN baru | 1. Buka dialog Ganti PIN.<br>2. Isi semua field dengan benar, namun isi "Konfirmasi Pin Baru" berbeda dari "Pin Baru".<br>3. Tekan "Ganti Pin". | - Pesan error muncul: "Konfirmasi PIN baru tidak sesuai dengan PIN baru". | | |
| **Dialog Ganti PIN** | Ganti PIN Sukses | 1. Buka dialog Ganti PIN.<br>2. Isi semua field dengan data yang valid dan benar.<br>3. Tekan "Ganti Pin". | - Indikator loading muncul di tombol.<br>- Dialog tertutup dan muncul notifikasi sukses.<br>- PIN berhasil diganti (bisa diuji saat transaksi berikutnya). | | |
| **Dialog Ganti PIN** | Ganti PIN Gagal (PIN lama salah) | 1. Buka dialog Ganti PIN.<br>2. Isi "Pin Lama" dengan PIN yang salah.<br>3. Isi field lainnya dengan data valid.<br>4. Tekan "Ganti Pin". | - Indikator loading muncul.<br>- Muncul pesan error dari server yang menyatakan PIN lama salah. Dialog tidak tertutup. | | |
| **Keamanan** | Membuka dialog "Reset PIN" | 1. Di bawah "Keamanan Akun", tekan menu "Reset/Lupa PIN". | - Dialog konfirmasi untuk reset PIN muncul. | | |
| **Dialog Reset PIN**| Membatalkan Reset PIN | 1. Buka dialog Reset PIN.<br>2. Tekan tombol "Batal". | - Dialog tertutup tanpa ada perubahan. | | |
| **Dialog Reset PIN**| Konfirmasi Reset PIN | 1. Buka dialog Reset PIN.<br>2. Tekan tombol "Reset Pin". | - Indikator loading muncul.<br>- Dialog tertutup dan muncul notifikasi bahwa PIN baru telah dikirim via WhatsApp. | | |
| **Tautan Eksternal** | Membuka laman "Hapus Akun" | 1. Di bawah "Akun", tekan menu "Hapus Akun". | - Aplikasi membuka browser ke halaman web untuk penghapusan akun. | | |
| **Logout** | Membuka dialog konfirmasi Logout | 1. Di halaman Akun, tekan tombol "Logout". | - Dialog konfirmasi untuk logout muncul. | | |
| **Dialog Logout** | Membatalkan Logout | 1. Buka dialog Logout.<br>2. Tekan tombol "Batal". | - Dialog tertutup dan pengguna tetap login. | | |
| **Dialog Logout** | Konfirmasi Logout | 1. Buka dialog Logout.<br>2. Tekan tombol "Logout". | - Indikator loading muncul.<br>- Pengguna berhasil logout dan diarahkan ke halaman login. | | |
