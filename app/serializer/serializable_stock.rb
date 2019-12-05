class SerializableStock < JSONAPI::Serializable::Resource
  type 'stocks'
  has_one :bearer
  attributes :name, :created_at, :updated_at
end
