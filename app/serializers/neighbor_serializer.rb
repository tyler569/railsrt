class NeighborSerializer < ActiveModel::Serializer
  attributes :ip

  def ip
    object.ip.to_s
  end
end
