# Cloudflare deployment order

1. In Cloudflare D1 create ONE database named `velora`.
2. Copy its database ID into `wrangler.toml`:
   `database_id = "YOUR_REAL_ID"`
3. Create ONE R2 bucket named `velora-storage`.
4. In Worker secrets create:
   - `DELIVERY_SECRET`
   - `ADMIN_BOOTSTRAP_SECRET`
   - `FCM_SERVICE_ACCOUNT_JSON`
5. Run schema:
   `npx wrangler d1 execute velora --remote --file=schema.sql`
6. Seed:
   `npx wrangler d1 execute velora --remote --file=seed.sql`
7. Deploy:
   `npx wrangler deploy`
8. Test:
   `GET /api/health`
9. Put the deployed Worker URL into Android `Api.kt` as `BASE_URL`.

Do not put the D1 ID, FCM service-account private key, or delivery secret into the Android APK.
