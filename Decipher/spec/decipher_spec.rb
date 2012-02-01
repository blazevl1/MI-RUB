require 'decipher'

describe Decipher do
  before(:each) do
    @decipher = Decipher.new
  end

  it "should correctly decipher string" do
    @decipher.decipher_string("1JKJ'pz'{ol'{yhklthyr'vm'{ol'Jvu{yvs'Kh{h'Jvywvyh{pvu5").should eql "*CDC is the trademark of the Control Data Corporation."
  end

  it "should correctly decipher string" do
    @decipher.decipher_string("1PIT'pz'h'{yhklthyr'vm'{ol'Pu{lyuh{pvuhs'I|zpulzz'Thjopul'Jvywvyh{pvu5").should eql "*IBM is a trademark of the International Business Machine Corporation."
  end

  it "should correctly decipher string" do
    @decipher.decipher_string("1KLJ'pz'{ol'{yhklthyr'vm'{ol'Kpnp{hs'Lx|pwtlu{'Jvywvyh{pvu5").should eql "*DEC is the trademark of the Digital Equipment Corporation."
  end
end

