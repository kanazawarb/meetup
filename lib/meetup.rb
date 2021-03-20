require 'date'
require 'erb'
require 'fileutils'
require 'pathname'

module Meetup
  ROOT_PATH = './'
  TEMPLATE_PATH = './_meetup_template'

  def latest_meetup_count
    path = Pathname(ROOT_PATH).join('*')
    Dir.glob(path).select {|e| /\d+/.match?(e) }.map(&:to_i).max
  end

  def previous_held_date(current_max)
    path = Pathname(ROOT_PATH).join("#{current_max}/index.md")
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

  def exist_index?(current_max)
    exist?(current_max, :index)
  end

  def exist_report?(current_max)
    exist?(current_max, :report)
  end

  private def exist?(current_max, name)
    File.exist?("#{current_max}/#{name}.md")
  end

  class Event
    attr_reader :text

    def initialize(number:, template_name:)
      @number = number
      @template_name = template_name

      yield self if block_given?
    end

    def render_text!(bind_hash)
      source_path = Pathname(Meetup::TEMPLATE_PATH).join(@template_name)
      @text = ERB.new(File.read(source_path)).result_with_hash(bind_hash)
    end

    def dest_dir
      Pathname(Meetup::ROOT_PATH).join(@number.to_s)
    end

    def generate_file(dest_dir, dest_filename)
      path = Pathname(dest_dir).join(dest_filename)
      FileUtils.mkdir_p dest_dir
      File.write(path, @text)
    end
  end
end
