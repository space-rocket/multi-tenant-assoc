# Script for populating the database. You can run it as:
#
#     mix run priv/repo/subdomain_seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyApp.Repo.insert!(%MyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

subdomains = [
 "site-1",
 "site-2"
]

assets = [
	%{name: "asset 1 (should only display on main site)"},
	%{name: "asset 2 (should only display on main site)"}
]

users = [
	%{
		username: "user 1 (should only display on main site)",
		credential: %{
			email: "user1@user.com"
		}
	},
	%{
		username: "user 2 (should only display on main site)",
		credential: %{
			email: "user2@user.com"
		}
	}
]

site1_assets = [
	%{
		name: "asset 1 (should only display on site-1)"
	},
	%{
		name: "asset 2 (should only display on site-1)"
	}
]

site2_assets = [
	%{
		name: "asset 1 (should only display on site-2)"
	},
	%{
		name: "asset 2 (should only display on site-2)"
	}
]

site1_users = [
	%{
		username: "user 1 (should only display on site-1)",
		credential: %{
			email: "user1@user.com"
		}
	},
	%{
		username: "user 2 (should only display on site-1)",
		credential: %{
			email: "user2@user.com"
		}
	}
]

site2_users = [
	%{
		username: "user 1 (should only display on site-2)",
		credential: %{
			email: "user1@user.com"
		}
	},
	%{
		username: "user 2 (should only display on site-2)",
		credential: %{
			email: "user2@user.com"
		}
	}
]

Enum.each(subdomains, fn(data) ->
	MyApp.Tenants.new(data)
end)

Enum.each(assets, fn(data) ->
	MyApp.Assets.create_asset(data)
end)

Enum.each(users, fn(data) ->
	MyApp.Accounts.create_user(data)
end)

Enum.each(site1_assets, fn(data) ->
	MyApp.Subdomain.Assets.create_asset(data, "site-1")
end)

Enum.each(site2_assets, fn(data) ->
	MyApp.Subdomain.Assets.create_asset(data, "site-2")
end)

Enum.each(site1_users, fn(data) ->
	MyApp.Subdomain.Accounts.create_user(data, "site-1")
end)

Enum.each(site2_users, fn(data) ->
	MyApp.Subdomain.Accounts.create_user(data, "site-2")
end)