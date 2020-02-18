require 'ipaddr'

module CoreExtensions
  module IPAddr
    def succ_subnet
      n = self.dup
      n.set(self.to_i + (2 << self.prefix-1))
    end

    def +(i)
      self.dup.set(self.to_i + i)
    end

    def -(i)
      self.dup.set(self.to_i - i)
    end

    def to_sub
      self.to_s + "/" + self.prefix.to_s
    end
  end
end

IPAddr.include CoreExtensions::IPAddr
