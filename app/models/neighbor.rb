require 'net/http'

class Neighbor < BaseModel
  attr_reader :ip

  def initialize(**params)
    @ip = params[:ip]
  end

  def as_uripart
    if ip.ipv6?
      "[#{ip.to_s}]"
    else
      ip.to_s
    end
  end

  def as_uri
    URI("http://#{as_uripart}:3000/routes")
  end

  def send_update(routes)
    uri = as_uri
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.body = routes.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    p res
  end
end
