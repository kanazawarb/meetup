# -*- mode: ruby; coding: utf-8 -*-

JEKYLL_BUILD_DIR = File.join(
                        (ENV['TMP'] || ENV['TEMP'] || '/tmp'),
                        'kanazawa-rb-meetup')
JEKYLL_BRANCH_STATIC = 'gh-pages-test'

desc 'jekyll serve -w'
task :serve do
  puts <<HEADER
############################################################
#   After boot jekyll server, open http://localhost:4000   #
############################################################
HEADER
  sh 'jekyll serve -w'
end

if system('gem which guard/livereload > /dev/null 2>&1')
  desc 'livereload'
  task :livereload do
    sh 'guard'
  end
end

namespace :git do
  desc 'git ls-files -o'
  task :untracked do
    sh 'git ls-files -o -X .gitignore'
  end
end

desc 'rm unused files and products'
task :clean do
  Dir.glob(['**/*~', '**/*.bak']).each { |f|
    FileUtils::Verbose.rm(f)
  }
end

task :pre_build => :clean do
  mkdir_p(JEKYLL_BUILD_DIR) unless File.exist?(JEKYLL_BUILD_DIR)
  rm_r(Dir.glob('JEKYLL_BUILD_DIR/*'))
end

desc 'build pages'
task :build => :pre_build do
  sh "jekyll build -d #{JEKYLL_BUILD_DIR}"
end

task :build_commit => :build do
  stat   = false
  @hash   = `git reflog -n 1 | awk '{print $1}'`.chomp
  @branch = `git show-ref | awk '/^#{@hash}/ {sub("refs/heads/", "", \$NF); print $NF}'`.chomp
  sh "git checkout #{JEKYLL_BRANCH_STATIC}"
  if !File.exist?('commit') || (open('commit').read.chomp != hash)
    cp_r(Dir.glob("#{JEKYLL_BUILD_DIR}/*"), '.')
    open('commit', 'w') {|f| f.puts hash}
    sh <<EOD
git add -A
git commit -q -m 'update with #{@hash}'
EOD
    stat = true
  else
    STDERR.puts 'Nothing to commit'
  end
  sh "git checkout #{@branch}"

  fail unless stat
end

desc "build site and push #{JEKYLL_BRANCH_STATIC}"
task :deploy => :build_commit do
  sh <<EOD
git push origin #{JEKYLL_BRANCH_STATIC}
EOD
end
