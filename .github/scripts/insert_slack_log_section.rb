# report.md の「## 話題」セクションの直後に Slack アーカイブへのリンクを挿入する。
#
# 挿入位置は「## 話題」の次に現れる `## ` 見出しの直前とする。レポートの
# テンプレートには HTML コメントで囲まれた `## 運営ブレストログ` が含まれる
# ことがあり、これをアンカーにするとコメントの内側に挿入してリンクが表示され
# なくなるため、コメント内の見出しは無視する。
#
# 位置を一意に決められない場合は、別の場所に挿入せず異常終了させて人が気付ける
# ようにする。
#
# 将来的にはこの挿入をやめ、report のレイアウトで file_exists による存在判定を
# 使ってリンクを描画する方式へ移行する予定。

SECTION_HEADING = "## Slack ログ"

report_path, number = ARGV
if report_path.nil? || number.nil?
  abort "usage: insert_slack_log_section.rb <report.md> <meetup number>"
end

lines = File.readlines(report_path, encoding: "UTF-8")

if lines.any? {|l| l.start_with?(SECTION_HEADING) }
  warn "#{report_path} には既に #{SECTION_HEADING} があるため何もしません"
  exit 0
end

# 各行の「行頭時点」で HTML コメントの内側かどうかを求める。見出しは行頭から
# 始まるため、行頭の状態だけ分かれば判定できる。
in_comment = false
inside_comment = lines.map do |line|
  starts_inside = in_comment
  pos = 0
  loop do
    if in_comment
      idx = line.index("-->", pos)
      break if idx.nil?
      pos = idx + 3
      in_comment = false
    else
      idx = line.index("<!--", pos)
      break if idx.nil?
      pos = idx + 4
      in_comment = true
    end
  end
  starts_inside
end

topic_index = lines.each_index.find do |i|
  !inside_comment[i] && /\A##\s+話題\s*\z/.match?(lines[i].chomp)
end
abort "「## 話題」の見出しが #{report_path} に見つかりません" if topic_index.nil?

insert_at = ((topic_index + 1)...lines.size).find do |i|
  !inside_comment[i] && lines[i].start_with?("## ")
end
abort "「## 話題」に続く見出しが #{report_path} に見つかりません" if insert_at.nil?

section = <<~SECTION
  #{SECTION_HEADING}

  * <a href="/#{number}/slack_archive/" target="_blank" rel="noopener">#meetup#{number} チャンネルのログ（別ウィンドウで開きます）</a>

SECTION

lines.insert(insert_at, section)
File.write(report_path, lines.join, encoding: "UTF-8")

puts "#{report_path} の #{insert_at + 1} 行目に #{SECTION_HEADING} を挿入しました"
