defmodule MyAppWeb.Subdomain.AssetController do
  use MyAppWeb, :controller

  alias MyApp.Subdomain.Assets
  alias MyApp.Assets.Asset

  def index(conn, _params) do
    tenant = conn.private[:subdomain]
    assets = Assets.list_assets(tenant)
    render(conn, "index.html", assets: assets)
  end

  def new(conn, _params) do
    changeset = Assets.change_asset(%Asset{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"asset" => asset_params}) do
    tenant = conn.private[:subdomain]
    case Assets.create_asset(asset_params, tenant) do
      {:ok, asset} ->
        conn
        |> put_flash(:info, "Asset created successfully.")
        |> redirect(to: Routes.asset_path(conn, :show, asset))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tenant = conn.private[:subdomain]
    asset = Assets.get_asset!(id, tenant)
    render(conn, "show.html", asset: asset)
  end

  def edit(conn, %{"id" => id}) do
    tenant = conn.private[:subdomain]
    asset = Assets.get_asset!(id, tenant)
    changeset = Assets.change_asset(asset)
    render(conn, "edit.html", asset: asset, changeset: changeset)
  end

  def update(conn, %{"id" => id, "asset" => asset_params}) do
    tenant = conn.private[:subdomain]
    asset = Assets.get_asset!(id, tenant)

    case Assets.update_asset(asset, asset_params, tenant) do
      {:ok, asset} ->
        conn
        |> put_flash(:info, "Asset updated successfully.")
        |> redirect(to: Routes.asset_path(conn, :show, asset))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", asset: asset, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tenant = conn.private[:subdomain]
    asset = Assets.get_asset!(id, tenant)
    {:ok, _asset} = Assets.delete_asset(asset, tenant)

    conn
    |> put_flash(:info, "Asset deleted successfully.")
    |> redirect(to: Routes.asset_path(conn, :index))
  end
end
