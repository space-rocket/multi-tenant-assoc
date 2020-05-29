# MyApp

```bash
mix phx.gen.html Accounts User users username:string:unique
```

```bash
mix phx.gen.context Accounts Credential credentials \
email:string:unique \
user_id:references:users
```

```bash
mix ecto.gen.migration
```