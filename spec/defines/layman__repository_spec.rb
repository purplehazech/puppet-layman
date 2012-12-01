require 'spec_helper'

describe 'layman::repository' do
  let(:title) { 'foo-bar-repository' }
  context "normal call" do
    it {
      should include_class('layman::params')
      
      should contain_file_line('layman::repository-layman.cfg-foo-bar-repository').with({
        :ensure  => 'present',
        :line    => '            foo-bar-repository',
        :path    => '/etc/layman/layman.cfg'
      })
    }
  end
end