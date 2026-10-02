# VeloraGames Backend v10

Backend Cloudflare Worker + D1 untuk VeloraGames.

## Fitur
- Login/register Gmail
- Remember session 90 hari + refresh
- Profile avatar URL / default initials
- VIP + blue verification badge
- Marketplace/products
- Transactions + transaction group chat
- Direct chat user ↔ user
- Chat user ↔ admin/support
- Admin bootstrap + verify payment/seller
- Seller withdrawal
- Delivery credential terenkripsi dengan AES-GCM

## D1 yang sudah ada
Gunakan database `velora` yang sama. Jangan membuat database baru hanya untuk deploy ulang.

### Database baru
Jalankan:
```bash
npx wrangler d1 execute velora --remote --file=schema.sql
```

### Database v9 lama
Jalankan sekali:
```bash
npx wrangler d1 execute velora --remote --file=migration_v10.sql
```
Jika kolom avatar sudah pernah ditambahkan, pesan duplicate column untuk kolom tersebut dapat diabaikan.

## Secrets
Buat secret Worker:
```bash
npx wrangler secret put DELIVERY_SECRET
npx wrangler secret put ADMIN_BOOTSTRAP_SECRET
```
Jangan commit nilai secret ke GitHub.

## Bootstrap admin
1. Buat akun biasa lewat APK.
2. Ambil user ID dari `/api/me` atau database.
3. Panggil `/api/admin/bootstrap` dengan header Authorization user tersebut dan body:
```json
{"userId":"USER_ID","secret":"ISI_ADMIN_BOOTSTRAP_SECRET"}
```
Setelah itu akun menjadi `admin`, `VIP`, dan `blue_verified`.

## APK
Ubah `app/.../Api.kt`:
```kotlin
const val BASE_URL = "https://YOUR-WORKER.workers.dev"
```
Token disimpan di SharedPreferences dan session backend berlaku 90 hari. APK otomatis memanggil refresh jika sisa masa session kurang dari 7 hari.
