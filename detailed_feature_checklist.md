# Detailed Feature Checklist

## Authentication (Auth)

- [x] **Halaman Splash**: Verifikasi halaman splash ditampilkan dengan benar beserta informasi versi aplikasi.

### OTP Login Flow
- [x] **Halaman Minta OTP**: Uji validasi input nomor telepon (kosong, format tidak valid, panjang).
- [x] **Halaman Minta OTP**: Uji status pemuatan tombol 'Masuk'.
- [x] **Halaman Minta OTP**: Uji tampilan pesan kesalahan saat kegagalan API.
- [x] **Halaman Minta OTP**: Uji navigasi ke halaman verifikasi jika berhasil.
- [x] **Halaman Minta OTP**: Uji tampilan penghitung waktu mundur pengiriman ulang OTP.
- [x] **Halaman Verifikasi OTP**: Uji validasi input OTP (6 digit).
- [x] **Halaman Verifikasi OTP**: Uji status pemuatan tombol 'Verifikasi'.
- [x] **Halaman Verifikasi OTP**: Uji penanganan kesalahan untuk OTP yang salah.
- [x] **Halaman Verifikasi OTP**: Uji fungsi tombol kirim ulang OTP setelah cooldown.
- [x] **Halaman Verifikasi OTP**: Uji login berhasil dan navigasi ke area anggota.
- [x] **Halaman Verifikasi OTP**: Uji fungsionalitas tombol 'Kembali'.

## Guest Experience

### Main Navigation
- [x] **Halaman Utama Tamu**: Verifikasi 5 tab navigasi bawah ditampilkan: "Home", "Riwayat", "PROMO!", "Official", dan "Akun".
- [x] **Halaman Utama Tamu**: Verifikasi bahwa mengetuk "Riwayat", "PROMO!", dan "Akun" akan menampilkan dialog "Belum Login".
- [x] **Halaman Utama Tamu**: Verifikasi bahwa mengetuk "Home" akan menavigasi ke `DashboardPage`.
- [x] **Halaman Utama Tamu**: Verifikasi bahwa mengetuk "Official" akan menavigasi ke `OfficialPage`.
- [x] **Halaman Utama Tamu**: Verifikasi dialog konfirmasi keluar aplikasi ditampilkan saat menekan tombol kembali dari sistem.

### "Belum Login" Page
- [x] **Halaman Belum Login**: Verifikasi halaman menampilkan pesan "Anda belum login".
- [x] **Halaman Belum Login**: Verifikasi tombol "Login" mengarah ke halaman permintaan OTP.
- [x] **Halaman Belum Login**: Verifikasi tombol "Daftar" tidak melakukan apa-apa.

### Guest Dashboard
- [x] **Dasbor Tamu**: Verifikasi menu "Penjualan" (Kasir, Catatan, dll.) menampilkan dialog "Belum Login" saat diketuk.
- [x] **Dasbor Tamu**: Verifikasi setiap menu "Isi Ulang" menavigasi ke halaman produk/penyedia yang benar.
- [x] **Dasbor Tamu**: Verifikasi spanduk "Paket Cuan" menavigasi ke halaman yang benar.
- [x] **Dasbor Tamu**: Verifikasi tombol notifikasi membuka tautan WhatsApp.
- [x] **Dasbor Tamu**: Verifikasi tombol bantuan membuka obrolan WhatsApp.
- [x] **Dasbor Tamu**: Verifikasi tombol "Masuk" di header mengarah ke halaman login.

## Member Features

### Main Navigation & Dashboard
- [x] **Halaman Utama Anggota**: Verifikasi 5 tab navigasi bawah dan navigasi yang benar.
- [x] **Halaman Utama Anggota**: Verifikasi data profil, riwayat, dan promo dimuat di initState.
- [x] **Halaman Utama Anggota**: Verifikasi logika tombol kembali sistem.
- [x] **Dasbor Anggota**: Verifikasi fungsi pull-to-refresh memperbarui profil.
- [x] **Dasbor Anggota**: Verifikasi semua menu "Penjualan" menavigasi ke halaman yang benar (Kasir, Catatan, Kalkulator, Favorit, Banner).
- [x] **Dasbor Anggota**: Verifikasi semua menu "Isi Ulang" menavigasi ke halaman anggota yang benar.
- [x] **Dasbor Anggota**: Verifikasi semua menu "PPOB" menavigasi ke halaman anggota yang benar.
- [x] **Dasbor Anggota**: Verifikasi ketukan "Paket Cuan" menavigasi ke halaman paket cuan anggota.
- [x] **Dasbor Anggota**: Verifikasi tombol bantuan memiliki perilaku yang diharapkan (saat ini tampaknya untuk debug).

### Account (Akun) - Detailed
- [ ] **Akun Anggota**: Uji Tarik-ke-Bawah untuk Segarkan (Pull-to-Refresh) memperbarui profil.
- [ ] **Kartu Saldo**: Uji tombol lihat/sembunyikan mengubah visibilitas saldo.
- [ ] **Kartu Saldo**: Uji tombol segarkan memperbarui saldo.
- [ ] **Kartu Saldo**: Uji tombol "Isi Saldo" memulai alur isi stok.
- [ ] **Menu General**: Uji tombol "Detail Akun" menavigasi ke halaman Detail Akun.
- [ ] **Menu General**: Uji tombol "Detail Device" menavigasi ke halaman Daftar Device.
- [ ] **Menu General**: Uji tombol "Daftar Favorit" menavigasi ke halaman Daftar Favorit.
- [ ] **Menu General**: Uji tombol "Beri Penilaian" membuka URL Play Store.
- [ ] **Kartu Pertanyaan**: Uji tombol "Tanya" (verifikasi fungsionalitasnya).
- [ ] **Menu Keamanan**: Uji tombol "Ganti PIN" membuka dialog Ganti PIN.
- [ ] **Dialog Ganti PIN**: Uji validasi input kosong untuk ketiga field (PIN Lama, PIN Baru, Konfirmasi).
- [ ] **Dialog Ganti PIN**: Uji validasi panjang PIN (harus 6 digit) untuk ketiga field.
- [ ] **Dialog Ganti PIN**: Uji validasi PIN baru tidak boleh sama dengan PIN lama.
- [ ] **Dialog Ganti PIN**: Uji validasi Konfirmasi PIN harus cocok dengan PIN Baru.
- [ ] **Dialog Ganti PIN**: Uji tombol "Ganti Pin" dengan input yang valid (verifikasi panggilan API dan penutupan dialog).
- [ ] **Dialog Ganti PIN**: Uji tombol "Ganti Pin" dengan input yang tidak valid (verifikasi pesan kesalahan).
- [ ] **Dialog Ganti PIN**: Uji tampilan pesan kesalahan dari API (misalnya, PIN lama salah).
- [ ] **Menu Keamanan**: Uji tombol "Reset/Lupa PIN" membuka dialog Reset PIN.
- [ ] **Dialog Reset PIN**: Uji tombol "Batal" menutup dialog.
- [ ] **Dialog Reset PIN**: Uji tombol "Reset Pin" (verifikasi panggilan API dan penutupan dialog).
- [ ] **Menu Akun**: Uji tombol "Hapus Akun" membuka URL penghapusan akun.
- [ ] **Tombol Logout**: Uji tombol "Logout" membuka dialog konfirmasi logout.
- [ ] **Dialog Logout**: Uji tombol "Batal" menutup dialog.
- [ ] **Dialog Logout**: Uji tombol "Logout" memanggil fungsi logout dan keluar dari aplikasi.

### Pending Detailed Analysis
- [ ] **Halaman Detail Akun Anggota**: Analisis dan buat TODO.
- [ ] **Halaman Daftar Perangkat Anggota**: Analisis dan buat TODO.
- [ ] **Halaman Daftar Favorit Anggota**: Analisis dan buat TODO.
- [ ] **Halaman Input Penjualan Kasir**: Analisis dan buat TODO.
- [ ] **Halaman Produk Kasir**: Analisis dan buat TODO.
- [ ] **Halaman Pelanggan Kasir**: Analisis dan buat TODO.
- [ ] **Halaman Laporan Kasir**: Analisis dan buat TODO.

### Products (Produk) - Per Product Testing
- [ ] **Produk Isi Ulang: Aktivasi Perdana**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Aktivasi Voucher**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Cek Status Voucher**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Info Kartu**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Masa Aktif**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Paket Data**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Paket Nelpon**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Paket Streaming**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Paket TV**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Pulsa**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Token PLN**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Topup Game**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Voucher Data**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Voucher Digital**: Uji alur transaksi lengkap.
- [ ] **Produk Isi Ulang: Wifi ID**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: BPJS Kesehatan**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: BPJS TKN**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: Dompet Digital**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: E-Commerce**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: E-Samsat**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: HP Pasca**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: Internet & TV**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: PBB**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: PDAM**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: PLN Tagihan**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: Tagihan Gas**: Uji alur transaksi lengkap.
- [ ] **Produk PPOB: Uang Elektronik**: Uji alur transaksi lengkap.

### Top Up (Isi Stok)
- [ ] **Halaman Isi Stok**: Verifikasi navigasi tab (Isi Stok, Riwayat) berfungsi.
- [ ] **Halaman Isi Stok**: Verifikasi daftar metode isi stok (Bank, Alfamart, dll.) ditampilkan.
- [ ] **Halaman Isi Stok**: Verifikasi setiap metode isi stok menavigasi ke alur pembuatan tiket yang benar.
- [ ] **Halaman Isi Stok**: Verifikasi tab Riwayat menampilkan riwayat tiket isi stok.
