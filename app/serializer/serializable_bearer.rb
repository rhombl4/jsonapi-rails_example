class SerializableBearer < JSONAPI::Serializable::Resource
  type 'bearers'
  has_many :stocks
  attributes :name, :created_at, :updated_at
  id { @object.name }
end
