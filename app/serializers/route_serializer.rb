class RouteSerializer < ActiveModel::Serializer
  attributes :to, :via, :metric

  def to
    object.to.to_s
  end

  def via
    object.via.to_s
  end
end
