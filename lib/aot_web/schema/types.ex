defmodule AotWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :project do
    field :name, :string
    field :archive_url, :string
    field :recent_url, :string
    field :first_observation, :string
    field :latest_observation, :string
    field :bbox, :string
    field :hull, :string
  end

  object :node do
    field :id, :string
    field :location, :string
    field :latitude, :float
    field :longitude, :float
    field :description, :string
    field :address, :string
    field :commissioned_on, :string
    field :decommissioned_on, :string
  end

  object :sensor do
    field :ontology, :string
    field :subsystem, :string
    field :sensor, :string
    field :parameter, :string
    field :uom, :string
    field :min, :float
    field :max, :float
    field :data_sheet, :string
  end

  object :observation do
    field :timestamp, :string
    field :value, :float
  end
end
