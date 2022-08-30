require 'date'
require 'erb'
require 'fileutils'
require 'pathname'
require 'nokogiri'

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

    INDENT_SIZE = 10
    BLANK = ' '
    LI_INDENT = BLANK * INDENT_SIZE

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

    def add_next_event_to_layouts(formatted_next_date)
      add_event './_layouts/post.html' do |doc|
        return if already_exist_event?(doc)

        doc.at_css('ul > li').add_previous_sibling(
          "<li><a href=\"../#{@number}/\">#{no_with_sign + BLANK + formatted_next_date}</a></li>\n" + LI_INDENT
        )
      end

      add_event './_layouts/toplevel.html' do |doc|
        return if already_exist_event?(doc)

        doc.at_css('ul > li').add_previous_sibling(
          "<li><a href=\"./#{@number}/\">#{no_with_sign + BLANK + formatted_next_date}</a></li>\n" + LI_INDENT
        )
      end
    end

    private

    def add_event(path)
      doc = Nokogiri::HTML::Document.parse(File.read(path))
      yield doc
      html = doc.to_html(indent: INDENT_SIZE)
      File.write(path, remove_extra_tag(html))
    end

    def no_with_sign
      "##{@number}"
    end

    # TODO:
    # Nokogiri で to_html すると Content-Type の meta tag が追加されてしまうため
    # 削除しているが、Nokogiri 側で制御できないかな？
    def remove_extra_tag(str)
      str.sub(
        "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n",
        ''
      )
    end

    def render_erb(template_name, bind_hash)
      source_path = Pathname(Meetup::TEMPLATE_PATH).join(template_name)
      ERB.new(File.read(source_path)).result_with_hash(bind_hash)
    end
  end
end
