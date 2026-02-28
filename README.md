# Composite Keys Demo

Sample Rails app showing a tenant-safe alternative to full composite primary keys
using Rails [query constraints](https://guides.rubyonrails.org/v7.1/active_record_composite_primary_keys.html) alongside [ActsAsTenant](https://github.com/ErwinM/acts_as_tenant).

> **Note**: switch to [activerecord-multi-tenant](https://github.com/zacharywelch/composite-keys/tree/activerecord-multi-tenant) to see the same app using
activerecord-multi-tenant with true composite PK/FKs instead of query_constraints.

## Problem

Rails supports composite primary keys, but using them directly makes `id` and
`find` array-based. `ActsAsTenant` scopes normal queries, but row-targeting
operations like `reload`, `update`, `delete`, and default `first/last` ordering
still key off `id` alone. That can miss tenant-leading indexes and enable
cross-tenant access patterns.

## Solution

Keep `ActsAsTenant` for default scoping and add `query_constraints`
plus tenant-leading unique indexes for composite keys and foreign keys. This
keeps scalar ids, makes row targeting tenant-safe, and stays index-friendly.
The app also extends `acts_as_tenant` with a `composite_keys` option for per-model
migration.

## Setup

```
bundle && bin/rails db:migrate:reset db:seed
```

## Sample Queries

```ruby
ActsAsTenant.current_tenant = Company.first

# Count scoped by tenant.
Artist.count
# Artist Count (2.4ms)  SELECT COUNT(*) FROM "artists" WHERE "artists"."company_id" = 1

# Load uses tenant + id for ordering.
artist = Artist.first
# Artist Load (1.0ms)  SELECT "artists".* FROM "artists"
#   WHERE "artists"."company_id" = 1
#   ORDER BY "artists"."company_id" ASC, "artists"."id" ASC LIMIT 1

# Reload targets tenant + id.
artist.reload
# Artist Load (1.9ms)  SELECT "artists".* FROM "artists"
#   WHERE "artists"."company_id" = 1 AND "artists"."id" = 1 LIMIT 1

# Update is tenant-safe.
artist.update(name: "Omi")
# Artist Update (1.9ms)  UPDATE "artists" SET "name" = 'Omi', "updated_at" = '...'
#   WHERE "artists"."company_id" = 1 AND "artists"."id" = 1

# Associations/joins include tenant key.
artist.songs
# Song Load (3.2ms)  SELECT "songs".* FROM "songs"
#   INNER JOIN "albums"
#     ON "songs"."company_id" = "albums"."company_id"
#    AND "songs"."album_id" = "albums"."id"
#   WHERE "songs"."company_id" = 1 AND "albums"."company_id" = 1 AND "albums"."artist_id" = 1

Artist.joins(:albums).count
# Artist Count (2.5ms)  SELECT COUNT(*) FROM "artists"
#   INNER JOIN "albums"
#     ON "albums"."company_id" = 1
#    AND "albums"."company_id" = "artists"."company_id"
#    AND "albums"."artist_id" = "artists"."id"
#   WHERE "artists"."company_id" = 1
```
