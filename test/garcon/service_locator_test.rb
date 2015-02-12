require_relative '../test_helper'
require_relative '../../lib/garcon/service_locator'

describe Garcon::ServiceLocator do
  subject { Garcon::ServiceLocator.new }

  CONSTANT = "HELLO".freeze
  let(:factory) { stub 'Factory' }
  let(:value1) { stub 'Value1' }
  let(:value2) { stub 'Value2' }

  it "registers constants" do
    subject.register "constant" do
      CONSTANT
    end

    subject['constant'].must_equal CONSTANT
  end

  it "registers dynamic objects" do
    factory.expects(:new).with(1).returns(value1)
    factory.expects(:new).with(2).returns(value2)

    count = 0
    subject.register 'dynamic' do 
      count += 1
      factory.new(count)
    end

    subject['dynamic'].must_equal value1
    subject['dynamic'].must_equal value2
  end
end
