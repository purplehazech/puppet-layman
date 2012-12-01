require 'spec_helper'

describe 'layman', :type => 'class' do
  context "normal include call" do
    it {
      should contain_package('layman').with_ensure('present')
      
      should contain_layman__repository('http://godin-gentoo-repository.googlecode.com/svn/trunk/layman.xml').with({
        :schedule => 'never'
      })
      should contain_layman__repository('http://intranet.rabe.ch/portage-overlay/repositories.xml').with({
        :schedule => 'never'
      })
      
      should contain_file('/var/lib/infra/layman').with({
        :ensure  => 'directory'
      })
      
      should contain_file('/etc/layman/layman.cfg').with({
        :ensure  => 'file'
      })
      
      should contain_file('/var/lib/infra/layman/make.conf').with({
        :ensure => 'file',
        :mode   => '0555'
      })
      
      should contain_schedule('layman-daily').with({
        :period => 'daily',
        :range  => '2-4'
      })

      should contain_exec('update-layman-cfg-overlays').with({
        :command  => '/usr/bin/layman -S && touch /var/lib/puppet/state/eix.stale',
        :onlyif   => '/bin/ls -al /var/lib/infra/layman/cache*xml && exit 1 || exit 0',
        :schedule => 'layman-daily'
      })
      
    }
  end
  
  context "With an ensure param specified" do
    let :params do
      {
        :ensure => 'present'
      }
    end

    it {
      should contain_package('layman').with_ensure('present')
    }
  end
  
  context "with sync = true" do
    let :params do
      {
        :sync => true
      }
    end
    it {
      should contain_package('layman').with_ensure('present')
      
      should contain_layman__repository('http://godin-gentoo-repository.googlecode.com/svn/trunk/layman.xml').with({
        :schedule => 'layman-daily'
      })
      should contain_layman__repository('http://intranet.rabe.ch/portage-overlay/repositories.xml').with({
        :schedule => 'layman-daily'
      })
      
      should contain_file('/var/lib/layman').with({
        :ensure  => 'directory'
      })
      
      should contain_file('/etc/layman/layman.cfg').with({
        :ensure  => 'file'
      })
      
      should contain_file('/var/lib/layman/make.conf').with({
        :ensure => 'file',
        :mode   => '0555'
      })
      
      should contain_schedule('layman-daily').with({
        :period => 'daily',
        :range  => '2-4'
      })

      should contain_exec('update-layman-cfg-overlays').with({
        :command  => '/usr/bin/layman -S && touch /var/lib/puppet/state/eix.stale',
        :onlyif   => '/bin/ls -al /var/lib/layman/cache*xml && exit 1 || exit 0',
        :schedule => 'layman-daily'
      })
      
    }
    
  end
end
