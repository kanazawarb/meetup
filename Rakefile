# -*- mode: ruby -*-
require 'fileutils'
require 'erb'
require 'date'

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

desc 'markdown to md'
task markdown_to_md: [] do
  Dir.glob(['*/*.markdown']).each do |f|
    dir  = f.split('/')[0]
    file = f.split('/')[1].split('.')[0]
    ext = f.split('/')[1].split('.')[1]
    sh "mv #{f} #{dir}/#{file}.md"
  end
end

desc 'textile to md'
task textile_to_md: [] do
  Dir.glob(['*/*.textile']).each do |f|
    dir  = f.split('/')[0]
    file = f.split('/')[1].split('.')[0]
    ext = f.split('/')[1].split('.')[1]
    # p "pandoc #{f} -o #{dir}/#{file}.md"
    sh "pandoc #{f} -o #{dir}/#{file}.md"
  end
end

namespace :meetup do
  desc 'create index.md template'
  task gen_index: [] do
    current_max = latest_meetup_count
    previous = exist_index?(current_max) ? current_max : current_max - 1

    puts "\e[1m#{previous}, 前回の開催日: #{previous_held_date(previous)}\e[0m"

    next_time = previous + 1

    is_yes = show_text "#{next_time} を作成しますか？ (Y)" do |val|
      /y/i =~ val
    end
    next unless is_yes

    default_value = '## TODO ##'

    doorkeeper_id = show_text 'Doorkeeper の event_id を入力してください' do |val|
      /\A\d+\z/.match?(val) ? val : default_value
    end

    next_date_ja = show_text '開催日を yyyy-mm-dd 形式で入力してください' do |val|
      if /\A\d{4}-\d{2}-\d{2}\z/ =~ val
        v = Date.parse(val)
        day = '日月火水木金土'[v.wday]
        v.strftime("%Y年%m月%d日(#{day})")
      else
        default_value
      end
    end

    FileUtils.mkdir_p "#{next_time}"
    index = ERB.new(File.read('./_meetup_template/index.md.erb')).result(binding)
    File.write("./#{next_time}/index.md", index)

    puts "#{next_time}/index.md が出力されました"
    puts "\e[1m\e[31m## TODO ## のある箇所を実際の値に置換してください\e[0m" if %r|#{default_value}|.match?(index)
  end

  desc 'create report.md template'
  task gen_report: [] do
    current_time = latest_meetup_count

    puts "\e[1m#{current_time}, 前回の開催日: #{previous_held_date(current_time)}\e[0m"

    if exist_report?(current_time)
      puts "既に #{current_time}/report.md は存在しています"
      next
    end

    default_value = 'XXX'

    report = ERB.new(File.read('./_meetup_template/report.md.erb')).result(binding)
    File.write("./#{current_time}/report.md", report)

    puts "#{current_time}/report.md が出力されました"
    puts "\e[1m\e[31m#{current_time}/report.md 内の XXX となっている箇所を実際の値に置換してください\e[0m" if %r|#{default_value}|.match?(report)
  end
end

private

def latest_meetup_count
  Dir.glob('*').select {|e| /\d+/ =~ e }.map(&:to_i).max
end

def exist?(current_max, name)
  File.exist?("#{current_max}/#{name}.md")
end

def exist_index?(current_max)
  exist?(current_max, :index)
end

def exist_report?(current_max)
  exist?(current_max, :report)
end

def previous_held_date(current_max)
  File.read("#{current_max}/index.md").split("\n").select {|l| l =~ /\*\*日時\*\*/ }
end

def show_text(text)
  puts text
  val = $stdin.gets.chomp
  yield val
end
