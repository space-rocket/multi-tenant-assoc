defmodule MyAppWeb.Subdomain.UserController do
  use MyAppWeb, :controller

  alias MyApp.Subdomain.Accounts
  alias MyApp.Accounts.User

  def index(conn, _params) do
    tenant = conn.private[:subdomain]
    users = Accounts.list_users(tenant)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    tenant = conn.private[:subdomain]
    case Accounts.create_user(user_params, tenant) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tenant = conn.private[:subdomain]
    user = Accounts.get_user!(id, tenant)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    tenant = conn.private[:subdomain]
    user = Accounts.get_user!(id, tenant)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    tenant = conn.private[:subdomain]
    user = Accounts.get_user!(id, tenant)

    case Accounts.update_user(user, user_params, tenant) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tenant = conn.private[:subdomain]
    user = Accounts.get_user!(id, tenant)
    {:ok, _user} = Accounts.delete_user(user, tenant)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
