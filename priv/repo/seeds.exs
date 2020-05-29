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

Enum.each(subdomains, fn(data) ->
	MyApp.Tenants.new(data)
end)

# MyApp.Tenants.new("site-1")