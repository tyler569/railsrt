module IpRoute
  def self.kernel_routes
    rs = `ip -6 route | grep via | awk '{print $1, $3}'`.split "\n"
    rs.map { |r|
      to, via = r.split.map(&:strip)
      to = '::/0' if to == 'default'
      {:to => to, :via => via}
    }
  end
  
  def self.diff(new_table)
    add = new_table - kernel_routes
    remove = kernel_routes - new_table

    { add: add, remove: remove }
  end

  def self.add_kernel_route(route)
    return if route[:to] == "::1"
    `sudo ip route add #{route[:to]} via #{route[:via]}`
  end

  def self.del_kernel_route(route)
    return if route[:to] == "::1"
    `sudo ip route del #{route[:to]}`
  end

  def self.apply_diff(d)
    d[:add].each do |r|
      add_kernel_route r
    end

    d[:remove].each do |r|
      del_kernel_route r
    end
  end

  def self.update_with_table(new_table)
    apply_diff(diff(new_table))
  end
end

