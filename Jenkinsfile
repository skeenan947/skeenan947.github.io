node {
  stage 'checkout'
  def buildNumber = env.BUILD_NUMBER
  def workspace = env.WORKSPACE
  checkout scm
  stage 'Ruby setup'
  sh '''#!/bin/bash
        ./rvm.sh
        source ~/.rvm/scripts/rvm
        bundle install --standalone'''
  stage 'Build'
  sh '''#!/bin/bash
        source ~/.rvm/scripts/rvm 
        bundle exec rake build'''
  stage 'Publish Docker image'
  sh '''#!/bin/bash
        source ~/.rvm/scripts/rvm 
        bundle exec rake publish'''
}
