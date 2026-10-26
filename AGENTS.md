# Instruksi & Konteks Proyek

## 1. Gambaran Umum Proyek
- Repositori ini membangun Docker image: **`nimdasx/apache-php7-phalcon4`** (juga di-mirror ke `ghcr.io/nimdasx/apache-php7-phalcon4`).
- Image ini digunakan untuk lingkungan produksi aplikasi web legacy berbasis framework Phalcon 4.
- Arsitektur: **Apache 2.4 (`mod_php`) + PHP 7.4.33 + Phalcon 4.1.2 + IonCube Loader** di atas Debian 11 (Bullseye).

---

## 2. Konteks Tugas: Backport Keamanan RCE PHP (CVE-2026-109618 & CVE-2026-109619)
- **Tujuan Utama:** Menutup kerentanan kritis Remote Code Execution (RCE) tanpa autentikasi (*PHP2Shell*) pada PHP 7.4 legacy tanpa mengubah kode sumber aplikasi.
- **Rujukan Resmi:** PHP Security Advisory 21 & 23 Oktober 2026 ([php.net Archive 2026](https://www.php.net/archive/2026.php#2026-10-21-5)).
- **Branch Patch Resmi:** [`PHP-7.4-CVE-2026-109618-109619`](https://github.com/php/php-src/tree/PHP-7.4-CVE-2026-109618-109619).
- **File Patch Tersedia:** Berkas patch lokal sudah disimpan di repositori ini: `CVE-2026-109618-109619.patch`.
- **Kompatibilitas ABI:** Patch ini 100% ABI-compatible dengan PHP 7.4.33, sehingga seluruh ekstensi (`phalcon-4.1.2`, `ioncube_loader`, `pdo_mysql`, dll.) tetap berfungsi normal.

---

## 3. Catatan Teknis Lingkungan Build
1. **Debian Bullseye Archive:** Repositori Debian Bullseye sudah masuk status arsip. Dalam `Dockerfile`, sumber apt wajib diarahkan ke `archive.debian.org`:
   ```bash
   sed -i 's|deb.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list
   sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list
   echo 'Acquire::Check-Valid-Until false;' > /etc/apt/apt.conf.d/99no-check-valid-until
   ```
2. **Rebuild Flow PHP:**
   - Ekstrak source bawaan: `docker-php-source extract` (lokasi di `/usr/src/php`).
   - Terapkan patch: `patch -p1 < CVE-2026-109618-109619.patch` (atau via curl).
   - Jalankan `./configure` dengan opsi yang sesuai bawaan image `php:7.4-apache-bullseye`.
   - Jalankan `make -j "$(nproc)" && make install`.
   - Bersihkan source (`docker-php-source delete`) dan purge build dependencies.
3. **Pemasangan Ekstensi:** Ekstensi tetap di-install via `install-php-extensions`:
   `ioncube_loader pdo_mysql pdo_pgsql gd zip mysqli xmlrpc psr redis sqlsrv pdo_sqlsrv phalcon-4.1.2 calendar bcmath`

---

## 4. Batasan & Aturan Kerja
- Hanya lakukan commit dan push ke Git jika ada instruksi eksplisit dari maintainer.
- Jangan melakukan `docker push` ke Docker Hub / GHCR kecuali setelah disetujui dan diperintahkan oleh maintainer.
- Pastikan setiap perubahan tetap mempertahankan kompatibilitas penuh dengan framework Phalcon 4.1.2 dan IonCube Loader.
