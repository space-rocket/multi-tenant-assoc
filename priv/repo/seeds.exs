# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
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

Enum.each(subdomains, fn(data) ->
	MyApp.Tenants.new(data)
end)

Enum.each(assets, fn(data) ->
	MyApp.Assets.create_asset(data)
end)

Enum.each(users, fn(data) ->
	MyApp.Accounts.create_user(data)
end)

# MyApp.Tenants.new("site-1")