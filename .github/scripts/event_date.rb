require 'date'

# meetup の index.md から開催日を読み取り、Slack ログの取得範囲を組み立てる。
#
# 取得対象は開催日の前日・当日・翌日の 3 日間。slapex の --from/--to は終端を
# 含まない半開区間なので、--to は開催日の 2 日後になる。
# GitHub Actions の runner は UTC で動くため、slapex にローカルタイムゾーンを
# 解釈させず、JST のオフセットを明示して渡す。

OFFSET = "+09:00"

index_path = ARGV[0]
abort "usage: event_date.rb <index.md>" if index_path.nil?

line = File.read(index_path, encoding: "UTF-8").lines.find {|l| /\*\*日時\*\*/.match?(l) }
abort "日時の行が #{index_path} に見つかりません" if line.nil?

matched = /(\d{4})年(\d{1,2})月(\d{1,2})日/.match(line)
abort "日時の行から開催日を読み取れません: #{line.strip}" if matched.nil?

begin
  event_date = Date.new(matched[1].to_i, matched[2].to_i, matched[3].to_i)
rescue Date::Error
  abort "開催日として成立しない日付です: #{line.strip}"
end

puts "event_date=#{event_date.strftime('%Y-%m-%d')}"
puts "from=#{(event_date - 1).strftime('%Y-%m-%d')}T00:00:00#{OFFSET}"
puts "to=#{(event_date + 2).strftime('%Y-%m-%d')}T00:00:00#{OFFSET}"
