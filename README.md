# Composite Keys Demo

Sample Rails app showing tenant-safe composite keys using
[activerecord-multi-tenant](https://github.com/shayonj/activerecord-multi-tenant).

> **Note**: switch to [master](https://github.com/zacharywelch/composite-keys/tree/master) for the `ActsAsTenant` + `query_constraints` approach.

## Problem

Rails supports composite primary keys, but using them directly makes `id` and
`find` array-based. Tenant scoping alone doesn’t guarantee row-targeting
operations (`reload`, `update`, `delete`, `first/last`) stay tenant-safe or
index-friendly.

## Solution

Use activerecord-multi-tenant to enable real composite PK/FKs while keeping
scalar `id` ergonomics. This preserves tenant safety for row targeting and
keeps joins aligned with tenant-leading indexes.

## Setup

```
bundle && bin/rails db:migrate:reset db:seed
```

## Sample Queries

```ruby
MultiTenant.current_tenant = Company.first
# Company Load (1.5ms)  SELECT "companies".* FROM "companies" ORDER BY "companies"."id" ASC LIMIT 1

Artist.count
# Artist Count (2.9ms)  SELECT COUNT(*) FROM "artists" WHERE "artists"."company_id" = 1

artist = Artist.first
# Artist Load (1.1ms)  SELECT "artists".* FROM "artists" WHERE "artists"."company_id" = 1 ORDER BY "artists"."id" ASC LIMIT 1

artist.reload
# Artist Load (1.6ms)  SELECT "artists".* FROM "artists" WHERE "artists"."company_id" = 1 AND "artists"."id" = 1 LIMIT 1

artist.update(name: "Omi")
# Artist Update (2.6ms)  UPDATE "artists" SET "name" = 'Omi', "updated_at" = '...'
#   WHERE "artists"."id" = 1 AND "artists"."company_id" = 1

artist.songs
# Song Load (3.4ms)  SELECT "songs".* FROM "songs" INNER JOIN "albums"
#   ON "songs"."album_id" = "albums"."id" AND "albums"."company_id" = "songs"."company_id"
#   WHERE "songs"."company_id" = 1 AND "albums"."artist_id" = 1 AND "albums"."company_id" = 1

Artist.joins(:albums).count
# Artist Count (1.7ms)  SELECT COUNT(*) FROM "artists" INNER JOIN "albums"
#   ON "albums"."artist_id" = "artists"."id" AND "albums"."company_id" = 1
#   WHERE "artists"."company_id" = 1
```
