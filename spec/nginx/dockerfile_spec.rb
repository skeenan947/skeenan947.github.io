require 'serverspec'

describe 'Dockerfile' do
  it 'should install the right version of nginx' do
    expect(nginx_version).to include('1.10')
  end
  
  it 'should have a resume available' do
    expect(file('/usr/share/nginx/html/resume/index.html')).to be_file
  end

  it 'should have a main index.html' do
    expect(file('/usr/share/nginx/html/index.html')).to be_file
  end

  it 'should have an about page' do
    expect(file('/usr/share/nginx/html/about/index.html')).to be_file
  end

  it 'should have newrelic' do
    expect(file('/usr/share/nginx/html/js/newrelic.js')).to be_file
  end

  def nginx_version
    command('nginx -v').stderr
  end
end
