class BaseModel
  include ActiveModel::Model

  alias :read_attribute_for_serialization :send
end
