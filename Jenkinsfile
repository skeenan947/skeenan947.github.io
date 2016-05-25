node {
  stage 'Checkout'
  checkout scm
  
  stage 'Build'
  sh('jekyll build -d build/')
  
  stage 'Package'
  sh('zip release/skeenan-static-v${BUILD_NUMBER}.zip . -rx build/ release/')
  
  stage 'Release'
  env.GITHUB_ORGANIZATION = 'skeenan947'
  env.GITHUB_REPO = 'skeenan.net'
  withCredentials([[$class: 'StringBinding', credentialsId: 'github_token', variable: 'GITHUB_TOKEN']]) {
    sh("""
    github-release release --user \${GITHUB_ORGANIZATION} --repo \${GITHUB_REPO} --tag \${VERSION_NAME} --name "\${BUILD_NUMBER}"
    github-release upload --user \${GITHUB_ORGANIZATION} --repo \${GITHUB_REPO} --tag \${VERSION_NAME}\
     --name "\${PROJECT_NAME}-\${BUILD_NUMBER}.zip" --file release/skeenan-static-\${BUILD_NUMBER}.zip
    """)
  }
  
  env.DOCKER_HOST = 'tcp://skeenan.net:2367'
  withCredentials([[$class: 'FileBinding', credentialsId: 'docker-cert', variable: 'DOCKER_CERT']]) {
    stage 'Docker Build'
    sh('docker build -t skeenan/static-site:latest')
  
    stage 'Deploy'
    sh('docker run -d -p80:80 skeenan/static-site:latest')
  }
}
