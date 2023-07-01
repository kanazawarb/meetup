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

    on_off_line_flg = say_and_gets("どちらかを選択してください。#{on_off_line_text}") {|val|
      v = /\A\d+\z/.match?(val) ? val.to_i : Meetup::KEY_ONLINE
    }

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

    title_key = say_and_gets("次回Meetupのタイプを選択してください。#{title_text}, default: #{Meetup::TITLES[Meetup::KEY_MOKU2]}") do |val|
      val.to_i
    end

    next_title =
      if Meetup::TITLES[title_key].nil?
        say_and_gets('次回Meetupのタイトルを入力してください。') do |val|
          val.empty? ? default_value : val
        end
      else
        Meetup::TITLES[title_key]
      end

    tool_name =
      if title_key != Meetup::KEY_LT
        say_and_gets("今回使用するツールはどちらですか？ #{tool_text}, default: #{Meetup::TOOLS[Meetup::KEY_GATHER]}") do |val|
          tool_id = Meetup::TOOLS.keys.map(&:to_s).include?(val) ? val.to_i : 0
          Meetup::TOOLS[tool_id]
        end
      end

    event = Event.new(number: next_time) do |e|
      e.render_template!(
        index_template_filename(title_key),
        next_time: next_time,
        doorkeeper_id: doorkeeper_id,
        next_date_ja: next_date_ja,
        tool_name: tool_name,
        next_title: next_title,
        title_key: title_key,
        on_off_line_flg: on_off_line_flg,
      )
      e.generate_file(e.dest_dir, 'index.md')
      e.add_next_event_to_layouts(
        next_date_en: next_date_en,
        next_title: next_title,
        next_time: next_time,
        on_off_line_flg: on_off_line_flg,
      )
    end
    event.enable_link_in_prev_index

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
    event.enable_link_in_prev_report

    if exist_index?(current_time)
      event.replace_doorkeeper_guide_wording
    end

    puts "_posts/#{current_time}/report.md が出力されました"

    default_value = 'XXX'
    str = "\e[1m\e[31m_posts/#{current_time}/report.md 内の XXX となっている箇所を実際の値に置換してください\e[0m"
    puts str if %r|#{default_value}|.match?(event.text)
  end
end
