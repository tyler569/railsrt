require 'core_extensions/ipaddr'

class RouteSerializer < ActiveModel::Serializer
  attributes :to, :via, :metric

  def to
    object.to.to_sub
  end

  def via
    object.via.to_s
  end
end
