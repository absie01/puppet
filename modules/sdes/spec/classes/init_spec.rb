require 'spec_helper'
describe 'sdes' do
  context 'with default values for all parameters' do
    it { should contain_class('sdes') }
  end
end
