# Pantry

A kitchen inventory app: items with par levels, suppliers, and purchase orders.
Rails 8, server-rendered ERB, Propshaft with plain CSS (design tokens in
`app/assets/stylesheets/tokens.css`, documented in `DESIGN.md`), SQLite.

Used as an Impeccable test repository.

## Accounts

The seeds create two users:

| Role    | Email                 | Password         | Can see                          |
| ------- | --------------------- | ---------------- | -------------------------------- |
| Manager | `manager@pantry.test` | `pantry-manager` | everything, including `/orders`  |
| Cook    | `cook@pantry.test`    | `pantry-cook`    | everything except `/orders`      |

Plus 21 items, 5 suppliers and 8 orders.

## Run it

Needs Ruby 3.3 (see `.ruby-version`) and Bundler.

```sh
bin/setup --skip-server   # bundle install, then db:prepare (creates, migrates and seeds a new database)
bin/rails db:seed         # optional: the seeds are idempotent, run again to reset the demo data
bin/rails server          # http://localhost:3000
```

`bin/setup` without `--skip-server` starts the server for you.

## Pages

| Path                    | What it is                             | Who        |
| ----------------------- | -------------------------------------- | ---------- |
| `/session/new`          | Sign in                                | anyone     |
| `/about`                | What Pantry is                         | anyone     |
| `/`                     | Dashboard: stats, below-par items      | signed in  |
| `/items`                | Item cards, filter by location         | signed in  |
| `/items/:id`, `/items/new`, `/items/:id/edit` | Item detail and form | signed in  |
| `/suppliers`, `/suppliers/:id` | Supplier table and detail       | signed in  |
| `/orders`               | Purchase orders table                  | manager    |
