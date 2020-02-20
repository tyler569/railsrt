class Config < BaseModel
  include Singleton

  attr_accessor :local_asn

  def initialize
    @local_asn = -1
  end

  def self.local_asn
    instance.local_asn
  end
end
