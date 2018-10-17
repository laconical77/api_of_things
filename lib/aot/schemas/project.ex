defmodule Aot.Project do
  @moduledoc """
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Aot.{
    ProjectNode,
    ProjectSensor,
    Node,
    Sensor
  }

  alias Geo.PostGIS.Geometry

  @primary_key {:slug, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :slug}
  schema "projects" do
    field :name, :string

    # source info
    field :archive_url, :string
    field :recent_url, :string

    # provenance metadata
    field :first_observation, :naive_datetime, default: nil
    field :latest_observation, :naive_datetime, default: nil

    # node metadata
    field :bbox, Geometry, default: nil
    field :hull, Geometry, default: nil

    # reverse relationships
    many_to_many :nodes, Node,
      join_through: ProjectNode,
      join_keys: [project_slug: :slug, node_vsn: :vsn]

    many_to_many :sensors, Sensor,
      join_through: ProjectSensor,
      join_keys: [project_slug: :slug, sensor_path: :path]
  end

  @attrs ~W( name bbox hull archive_url recent_url bbox hull first_observation latest_observation ) |> Enum.map(&String.to_atom/1)
  @reqd ~W( name archive_url recent_url ) |> Enum.map(&String.to_atom/1)

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, @attrs)
    |> validate_required(@reqd)
    |> unique_constraint(:name)
    |> unique_constraint(:archive_url)
    |> unique_constraint(:recent_url)
    |> put_slug()
  end

  defp put_slug(%Ecto.Changeset{valid?: true, changes: %{name: name}} = cs) do
    slug = Slug.slugify(name)
    put_change(cs, :slug, slug)
  end

  defp put_slug(cs), do: cs
end