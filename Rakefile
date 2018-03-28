require 'rake'
require 'docker'
require 'rspec/core/rake_task'
require 'json'
require 'uri'

IMAGE_NAME = 'skeenan/skeenan.net'
IMAGE_VERSION = '1.1'

def run_command(command)
  IO.popen(command) do |data|
    while line = data.gets
      puts line
    end
  end
end

def build
  builder = Docker::Image.build_from_dir('site')
  container = Docker::Container.create('Image' => builder.id)
  container.delete(:force => true)
  builder
end

def published_versions
  raw = URI.parse("https://registry.hub.docker.com/v2/repositories/#{IMAGE_NAME}/tags").read
  response = JSON.parse(raw)
  ret = {}
  ret[:tags] = []
  ret[:name] = IMAGE_NAME
  if !response["results"].kind_of?(Array)
    ret = []
  else
    response["results"].each do |r|
      ret[:tags].push(r["name"])
    end
  end
  puts "Return: #{ret}\n"
  ret
end

task :default => :spec

task :spec => :build
desc 'Run serverspec tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

desc 'Build Image from the Dockerfile'
task :build => [:docker_env] do |t, args|
  image = build()
  tag = image.tag('repo' => "#{IMAGE_NAME}", 'tag' => "#{IMAGE_VERSION}")
  puts tag
  image.id
end

desc 'Run the Image'
task :run => [:docker_env] do |t, args|
  arguments = args.extras.join " "

  image = build()
  run_command("docker run #{arguments} -d #{image.id}")
end

desc 'Publish The Image'
task :publish => [:spec, :build] do |t, args|
  existing_tags = published_versions()
  if existing_tags[:tags].member? IMAGE_VERSION
    abort("The version #{IMAGE_VERSION} has already been published.")
  end
  image = build
  image.tag('repo' => "#{IMAGE_NAME}", 'tag' => "latest", force: true)

  run_command("docker push #{IMAGE_NAME}:#{IMAGE_VERSION}")
  run_command("docker push #{IMAGE_NAME}:latest")
end

desc 'Get list of published versions'
task :list do
  tags = published_versions()
  puts tags[:name] + ':'
  puts tags[:tags].map { |e| "\t" + e }
end

task :docker_env do
  windows = ((/cgwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil)
  osx = (/darwin/ =~ RUBY_PLATFORM) != nil
end