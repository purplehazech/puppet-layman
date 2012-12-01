require 'spec_helper'

describe 'layman::overlay' do
  let(:title) { 'foo-bar-overlay' }
  context "normal call" do
    it {
      should include_class('layman')
      
      should contain_exec('layman::overlay-add-repo-foo-bar-overlay').with({
        :command => '/usr/bin/layman -a foo-bar-overlay'
      })
      should contain_exec('layman::overlay-sync-repo-foo-bar-overlay').with({
        :command  => '/usr/bin/layman -s foo-bar-overlay',
        :schedule => 'layman-daily'
      })
    }
  end
end