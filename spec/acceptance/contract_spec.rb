require 'spec_helper'

describe Contractinator::Contract do
  before do
    spec_data <<-END
      class A
        attr_acessor :b

        def doit
          b.thing
        end
      end
    END
  end

  it 'stubs out a method on a double' do
    spec_data <<-END
      describe A do
        it do
          a = A.new
          a.b = double(:b)
          stipulate(b).must
        end
      end
    END
  end
end
