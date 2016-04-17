# -*- mode: ruby -*-

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

desc 'rm unused files'
task :clean do
  Dir.glob(['**/*~', '**/*.bak']).each { |f|
    FileUtils::Verbose.rm(f)
  }
end

desc 'replace shorted url to expanded url'
namespace :travis do
  task :replace_url do # shorted url replace
    sh 'find _build -type f -iregex ".*\(slides\)\.md$" -o -iregex ".*\(report\)\.textile$" -o -iregex ".*\(index\)\.textile$" | xargs -i rake "travis:execute_replace[\'{}\']"'
  end
  task :execute_replace, ['path'] do |task, args|
    sh "ruby replace_url.rb #{args.path}"
  end
end

desc 'markdown to md'
task markdown_to_md: [] do
  Dir.glob(['*/*.markdown']).each do |f|
    dir  = f.split('/')[0]
    file = f.split('/')[1].split('.')[0]
    ext = f.split('/')[1].split('.')[1]
    sh "mv #{f} #{dir}/#{file}.md"
  end
end
