require 'date'
require 'erb'
require 'fileutils'
require 'pathname'

module Meetup
  ROOT_PATH = './'
  TEMPLATE_PATH = './lib/meetup_template'

  def latest_meetup_count
    path = Pathname(ROOT_PATH).join('_posts/*')
    Dir.glob(path).map {|e| %r|\A_posts/(\d+)\z|.match(e) ? $1.to_i : 0 }.max
  end

  def previous_held_date(current_max)
    path = Pathname(ROOT_PATH).join("_posts/#{current_max}/index.md")
    File.read(path).split("\n").select {|l| /\*\*日時\*\*/.match?(l) }
  end

  def say_and_gets(text)
    puts text
    val = $stdin.gets.chomp
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

  private def exist?(current_max, name)
    File.exist?("_posts/#{current_max}/#{name}.md")
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

    def add_next_event_to_layouts(next_date_en:, next_title:, next_time:)
      add_event './_posts/meetups.md' do |doc|
        return if already_exist_event?(doc)

        card_html = render_erb("_meetup_card.erb", {
          meetup_with_no: "Meetup#{no_with_sign}",
          next_date_en: next_date_en,
          next_title: next_title,
          next_time: next_time,
        })

        doc.sub!("<ul>\n", "<ul>\n#{card_html}\n")
      end
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
      ERB.new(File.read(source_path)).result_with_hash(bind_hash)
    end
  end
end
