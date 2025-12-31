# Feature Checklist

## Authentication (Auth)

- [x] Halaman Splash - Verifikasi halaman splash ditampilkan dengan benar beserta informasi versi aplikasi.
- [x] Halaman Minta OTP - Uji validasi input nomor telepon (kosong, format tidak valid, panjang).
- [x] Halaman Permintaan OTP - Uji status pemuatan tombol 'Masuk'.
- [x] Halaman Permintaan OTP - Uji tampilan pesan kesalahan saat kegagalan API.
- [x] Halaman Permintaan OTP - Uji navigasi ke halaman verifikasi jika berhasil.
- [x] Halaman Permintaan OTP - Uji tampilan penghitung waktu mundur pengiriman ulang OTP.
- [x] Halaman Verifikasi OTP - Uji validasi input OTP (6 digit).
- [x] Halaman Verifikasi OTP - Uji status pemuatan tombol 'Verifikasi'.
- [x] Halaman Verifikasi OTP - Uji penanganan kesalahan untuk OTP yang salah.
- [x] Halaman Verifikasi OTP - Uji fungsi tombol kirim ulang OTP setelah cooldown.
- [x] Halaman Verifikasi OTP - Uji login berhasil dan navigasi ke area anggota.
- [x] Halaman Verifikasi OTP - Uji fungsionalitas tombol 'Kembali'.

## Guest Experience

- [ ] Halaman Utama Tamu - Verifikasi 5 tab navigasi bawah ditampilkan: "Home", "Riwayat", "PROMO!", "Official", dan "Akun".
- [ ] Halaman Utama Tamu - Verifikasi bahwa mengetuk "Riwayat", "PROMO!", dan "Akun" akan menampilkan dialog "Belum Login".
- [ ] Halaman Utama Tamu - Verifikasi bahwa mengetuk "Home" akan menavigasi ke `DashboardPage`.
- [ ] Halaman Utama Tamu - Verifikasi bahwa mengetuk "Official" akan menavigasi ke `OfficialPage`.
- [ ] Halaman Utama Tamu - Verifikasi dialog konfirmasi keluar aplikasi ditampilkan saat menekan tombol kembali dari sistem.
- [ ] Halaman Belum Login - Verifikasi halaman menampilkan pesan "Anda belum login".
- [ ] Halaman Belum Login - Verifikasi tombol "Login" mengarah ke halaman permintaan OTP.
- [ ] Halaman Belum Login - Verifikasi tombol "Daftar" tidak melakukan apa-apa.
- [ ] Dasbor Tamu - Verifikasi menu "Penjualan" (Kasir, Catatan, dll.) menampilkan dialog "Belum Login" saat diketuk.
- [ ] Dasbor Tamu - Verifikasi setiap menu "Isi Ulang" menavigasi ke halaman produk/penyedia yang benar.
- [ ] Dasbor Tamu - Verifikasi spanduk "Paket Cuan" menavigasi ke halaman yang benar.
- [ ] Dasbor Tamu - Verifikasi tombol notifikasi membuka tautan WhatsApp.
- [ ] Dasbor Tamu - Verifikasi tombol bantuan membuka obrolan WhatsApp.
- [ ] Dasbor Tamu - Verifikasi tombol "Masuk" di header mengarah ke halaman login.

## Member Features

### Main Navigation & Dashboard
- [x] Halaman Utama Anggota - Verifikasi 5 tab navigasi bawah dan navigasi yang benar.
- [x] Halaman Utama Anggota - Verifikasi data profil, riwayat, dan promo dimuat di initState.
- [x] Halaman Utama Anggota - Verifikasi logika tombol kembali sistem.
- [x] Dasbor Anggota - Verifikasi fungsi pull-to-refresh memperbarui profil.
- [x] Dasbor Anggota - Verifikasi semua menu "Penjualan" menavigasi ke halaman yang benar (Kasir, Catatan, Kalkulator, Favorit, Banner).
- [x] Dasbor Anggota - Verifikasi semua menu "Isi Ulang" menavigasi ke halaman anggota yang benar.
- [x] Dasbor Anggota - Verifikasi semua menu "PPOB" menavigasi ke halaman anggota yang benar.
- [x] Dasbor Anggota - Verifikasi ketukan "Paket Cuan" menavigasi ke halaman paket cuan anggota.
- [x] Dasbor Anggota - Verifikasi tombol bantuan memiliki perilaku yang diharapkan (saat ini tampaknya untuk debug).

### Account (Akun)
- [x] Akun Anggota - Verifikasi visibilitas saldo dapat diubah.
- [x] Akun Anggota - Verifikasi tombol "Isi Saldo" berfungsi.
- [x] Akun Anggota - Verifikasi menu "General" menavigasi ke halaman yang benar (Detail Akun, Detail Device, Daftar Favorit).
- [x] Akun Anggota - Verifikasi menu "Beri Penilaian" membuka Play Store.
- [x] Akun Anggota - Verifikasi dialog "Ganti PIN" dan "Reset/Lupa PIN" muncul.
- [x] Akun Anggota - Verifikasi menu "Hapus Akun" membuka halaman web.
- [x] Akun Anggota - Verifikasi tombol "Logout" menampilkan dialog konfirmasi.
- [ ] Halaman Detail Akun Anggota - Analisis dan buat TODO.
- [ ] Halaman Daftar Perangkat Anggota - Analisis dan buat TODO.
- [ ] Halaman Daftar Favorit Anggota - Analisis dan buat TODO.

### Cashier (Kasir)
- [x] Kasir Anggota - Verifikasi ringkasan (Total Penjualan, Modal, Laba) dihitung dan ditampilkan dengan benar.
- [x] Kasir Anggota - Verifikasi riwayat transaksi dimuat dan ditampilkan.
- [x] Kasir Anggota - Verifikasi fungsi pull-to-refresh memuat ulang riwayat.
- [x] Kasir Anggota - Verifikasi dialog filter tanggal berfungsi dan memfilter riwayat.
- [x] Kasir Anggota - Verifikasi mengetuk transaksi akan membuka halaman detail.
- [x] Kasir Anggota - Verifikasi opsi per transaksi (Chat, Refund, Sukseskan) berfungsi sesuai status.
- [x] Kasir Anggota - Verifikasi tombol navigasi bawah (Input Penjualan, Data Produk, Data Pelanggan, Laporan Kasir) berfungsi.
- [ ] Halaman Input Penjualan Kasir - Analisis dan buat TODO.
- [ ] Halaman Produk Kasir - Analisis dan buat TODO.
- [ ] Halaman Pelanggan Kasir - Analisis dan buat TODO.
- [ ] Halaman Laporan Kasir - Analisis dan buat TODO.

### Products (Produk)

#### Isi Ulang
- [ ] Produk Isi Ulang: Aktivasi Perdana - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Aktivasi Voucher - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Cek Status Voucher - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Info Kartu - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Masa Aktif - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Paket Data - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Paket Nelpon - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Paket Streaming - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Paket TV - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Pulsa - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Token PLN - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Topup Game - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Voucher Data - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Voucher Digital - Uji alur transaksi lengkap.
- [ ] Produk Isi Ulang: Wifi ID - Uji alur transaksi lengkap.

#### PPOB (Payment Point Online Bank)
- [ ] Produk PPOB: BPJS Kesehatan - Uji alur transaksi lengkap.
- [ ] Produk PPOB: BPJS TKN - Uji alur transaksi lengkap.
- [ ] Produk PPOB: Dompet Digital - Uji alur transaksi lengkap.
- [ ] Produk PPOB: E-Commerce - Uji alur transaksi lengkap.
- [ ] Produk PPOB: E-Samsat - Uji alur transaksi lengkap.
- [ ] Produk PPOB: HP Pasca - Uji alur transaksi lengkap.
- [ ] Produk PPOB: Internet & TV - Uji alur transaksi lengkap.
- [ ] Produk PPOB: PBB - Uji alur transaksi lengkap.
- [ ] Produk PPOB: PDAM - Uji alur transaksi lengkap.
- [ ] Produk PPOB: PLN Tagihan - Uji alur transaksi lengkap.
- [ ] Produk PPOB: Tagihan Gas - Uji alur transaksi lengkap.
- [ ] Produk PPOB: Uang Elektronik - Uji alur transaksi lengkap.

#### Promo
- [ ] Halaman Promo Anggota - Verifikasi produk promo ditampilkan dan dapat ditransaksikan.

### History (Riwayat)
- [ ] Halaman Riwayat Anggota - Verifikasi navigasi tab (Hari Ini, Kemarin, Mutasi Stok, Rekap Transaksi) berfungsi.
- [ ] Halaman Riwayat Anggota - Verifikasi data yang benar ditampilkan untuk setiap tab.
- [ ] Halaman Riwayat Anggota - Verifikasi fungsi filter untuk setiap tab.
- [ ] Halaman Riwayat Anggota - Verifikasi navigasi ke detail transaksi berfungsi dari daftar riwayat.
- [ ] Halaman Riwayat Anggota - Verifikasi fungsionalitas cetak struk dari detail transaksi.

### Top Up (Isi Stok)
- [ ] Halaman Isi Stok - Verifikasi navigasi tab (Isi Stok, Riwayat) berfungsi.
- [ ] Halaman Isi Stok - Verifikasi daftar metode isi stok (Bank, Alfamart, dll.) ditampilkan.
- [ ] Halaman Isi Stok - Verifikasi setiap metode isi stok menavigasi ke alur pembuatan tiket yang benar.
- [ ] Halaman Isi Stok - Verifikasi tab Riwayat menampilkan riwayat tiket isi stok.