# -*- mode: ruby -*-
require_relative './meetup'

desc 'jekyll serve -w'
task :serve do
  puts <<HEADER
############################################################
#   After boot jekyll server, open http://localhost:4000   #
############################################################
HEADER
  sh 'jekyll serve -w -H 0.0.0.0 -l'
end

desc 'rm unused files'
task :clean do
  Dir.glob(['**/*~', '**/*.bak']).each { |f|
    FileUtils::Verbose.rm(f)
  }
end

namespace :meetup do
  include Meetup

  desc 'create index.md template'
  task gen_index: [] do
    current_max = latest_meetup_count
    previous_number = exist_index?(current_max) ? current_max : current_max - 1

    puts "\e[1m#{previous_number}, 前回の開催日: #{previous_held_date(previous_number)}\e[0m"

    next_time = previous_number + 1

    is_yes = say_and_gets("#{next_time} を作成しますか？ (Y)") {|val|
      /y/i =~ val
    }
    next unless is_yes

    default_value = '## TODO ##'

    doorkeeper_id = say_and_gets('Doorkeeper の event_id を入力してください') {|val|
      /\A\d+\z/.match?(val) ? val : default_value
    }

    next_date = say_and_gets('開催日を yyyy-mm-dd 形式で入力してください') {|val|
      if /\A\d{4}-\d{2}-\d{2}\z/.match?(val)
        val
      else
        default_value
      end
    }
    next_date_ja = format_date_ja(next_date) unless next_date == default_value
    next_date_en = format_date_en(next_date) unless next_date == default_value

    event = Event.new(number: next_time) {|e|
      e.render_template!('index.md.erb', next_time: next_time, doorkeeper_id: doorkeeper_id, next_date_ja: next_date_ja)
      e.generate_file(e.dest_dir, 'index.md')
      # e.add_next_event_to_layouts(next_date_en)
    }

    puts "_posts/#{next_time}/index.md が出力されました"
    puts "\e[1m\e[31m## TODO ## のある箇所を実際の値に置換してください\e[0m" if %r|#{default_value}|.match?(event.text)
  end

  desc 'create report.md template'
  task gen_report: [] do
    current_time = latest_meetup_count

    puts "\e[1m#{current_time}, 前回の開催日: #{previous_held_date(current_time)}\e[0m"

    if exist_report?(current_time)
      puts "既に _posts/#{current_time}/report.md は存在しています"
      next
    end

    event = Event.new(number: current_time) {|e|
      e.render_template!('report.md.erb', current_time: current_time)
      e.generate_file(e.dest_dir, 'report.md')
    }

    puts "_posts/#{current_time}/report.md が出力されました"

    default_value = 'XXX'
    str = "\e[1m\e[31m_posts/#{current_time}/report.md 内の XXX となっている箇所を実際の値に置換してください\e[0m"
    puts str if %r|#{default_value}|.match?(event.text)
  end
end
