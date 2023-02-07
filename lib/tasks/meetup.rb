require 'date'
require 'erb'
require 'fileutils'
require 'pathname'

module Meetup
  ROOT_PATH = File.expand_path("../../", __dir__)
  TEMPLATE_PATH = File.join(ROOT_PATH, "./lib/meetup_template")

  KEY_MOKU2 = 0
  KEY_LT = 1
  KEY_OTHER = 2
  TITLES = { KEY_MOKU2 => '意識高いもくもく会', KEY_LT => '〇〇LT大会', KEY_OTHER => nil }.freeze

  KEY_GATHER = 0
  KEY_ZOOM = 1
  TOOLS = { KEY_GATHER => "Gather", KEY_ZOOM => "Zoom" }.freeze

  KEY_OFFLINE = 0
  KEY_ONLINE = 1
  ON_OFF_LINES = { KEY_OFFLINE => "オフライン開催", KEY_ONLINE => "オンライン開催" }.freeze

  def erb_source_path(filename)
    Pathname(Meetup::TEMPLATE_PATH).join(filename)
  end
  module_function :erb_source_path

  def latest_meetup_count
    path = Pathname(ROOT_PATH).join('_posts/*')
    Dir.glob(path).map {|e| %r|_posts/(\d+)\z|.match(e) ? $1.to_i : 0 }.max
  end

  def previous_held_date(current_max)
    path = Pathname(ROOT_PATH).join("_posts/#{current_max}/index.md")
    File.read(path).split("\n").select {|l| /\*\*日時\*\*/.match?(l) }
  end

  def say_and_gets(text)
    puts text
    val = $stdin.gets.chomp.strip
    yield val
  end

  def format_date_ja(date_str)
    v = Date.parse(date_str)
    day = '日月火水木金土'[v.wday]
    v.strftime("%Y年%m月%d日(#{day})")
  end

  def format_date_en(date_str)
    v = Date.parse(date_str)
    day = %w(Sun Mon Tue Wed Thu Fri Sat)[v.wday]
    v.strftime("%Y-%m-%d (#{day})")
  end

  def exist_index?(current_max)
    exist?(current_max, :index)
  end

  def exist_report?(current_max)
    exist?(current_max, :report)
  end

  def title_text
    Meetup::TITLES.map {|k, v|
      if k == Meetup::KEY_OTHER
        "#{k}: 自由入力"
      else
        "#{k}: #{v}"
      end
    }.join(", ")
  end

  def tool_text
    Meetup::TOOLS.map {|k, v| "#{k}: #{v}" }.join(", ")
  end

  def on_off_line_text
    Meetup::ON_OFF_LINES.map {|k, v| "#{k}: #{v}" }.concat(["default: #{Meetup::ON_OFF_LINES[Meetup::KEY_OFFLINE]}"]).join(", ")
  end

  def index_template_filename(title_key)
    title_key == Meetup::KEY_LT ? 'lt_index.md.erb' : 'index.md.erb'
  end

  private def exist?(current_max, name)
    path = Pathname(ROOT_PATH).join("_posts/#{current_max}/#{name}.md")
    File.exist?(path)
  end

  class Event
    attr_reader :text

    BLANK = ' '

    def initialize(number:)
      @number = number

      yield self if block_given?
    end

    def render_template!(template_name, bind_hash)
      @text = render_erb(template_name, bind_hash)
    end

    def dest_dir
      Pathname(Meetup::ROOT_PATH).join("_posts/#{@number}")
    end

    def generate_file(dest_dir, dest_filename)
      path = Pathname(dest_dir).join(dest_filename)
      FileUtils.mkdir_p dest_dir
      File.write(path, @text)
    end

    def add_next_event_to_layouts(next_date_en:, next_title:, next_time:, on_off_line_flg:)
      add_event File.join(ROOT_PATH, "./_posts/meetups.md") do |doc|
        return if already_exist_event?(doc)

        card_html = render_erb("_meetup_card.erb", {
          meetup_with_no: "Meetup#{no_with_sign}",
          next_date_en: next_date_en,
          next_title: next_title,
          next_time: next_time,
          on_off_line_flg: on_off_line_flg,
        })

        doc.sub!("<ul>\n", "<ul>\n#{card_html}\n")
      end

      add_event File.join(ROOT_PATH, "./_posts/index.md") do |doc|
        return if already_exist_event?(doc)

        html = <<~HTML
        <div>
          <p class="d-inline-block label label-red ml-0">注目</p>
          <a href="/#{next_time}" class="home__latest-meetup-link">
            最新の Meetup##{next_time} はこちらへ
          </a>
        </div>
        HTML

        doc.sub!(%r{<div>(\w|\W)*</div>}, html.chomp)
      end
    end

    def enable_link_in_prev_index
      prev_index_path = File.join(ROOT_PATH, "_posts", "#{@number - 1}", "index.md")
      str = File.read(prev_index_path).sub("#next", "next")
      File.write(prev_index_path, str)
    end

    def enable_link_in_prev_report
      prev_report_path = File.join(ROOT_PATH, "_posts", "#{@number - 1}", "report.md")
      str = File.read(prev_report_path).sub("#next", "next")
      File.write(prev_report_path, str)
    end

    private

    def add_event(path)
      doc = File.read(path)
      yield doc
      File.write(path, doc)
    end

    def no_with_sign
      "##{@number}"
    end

    def already_exist_event?(doc)
      doc.include?(no_with_sign + BLANK)
    end

    def render_erb(template_name, bind_hash)
      source_path = Pathname(Meetup::TEMPLATE_PATH).join(template_name)
      ERB.new(File.read(source_path), trim_mode: '-').result_with_hash(bind_hash)
    end
  end
end
