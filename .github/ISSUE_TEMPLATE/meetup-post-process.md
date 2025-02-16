---
name: meetup イベント後対応
about: meetup イベントの後で実施するタスク
title: meetup XX イベント後対応
labels: ''
assignees: ''

---

## レポートを作成する
- [ ] 運営ブレストログ(github wiki)
- [ ] ツイートまとめ(togetter)
- [ ] 写真アルバム(30days)
- [ ] レポートページ

## レポートをアナウンスする
- [ ] buffer(twitter, facebook, mastodon)
- [ ] ruby-jp slack

---

## 手順補足

### 運営ブレストログについて

* https://github.com/kanazawarb/meetup/wiki の配下にページを追加してください
    * 中身はどのような内容でもかまいません
    * タイトルは `meetup NNN 運用ブレストログ` のように記載ください

* 運営ブレストを実施した際に、その場で wiki ページを作成するのが理想的です
  * 他のやり方として Dropbox の共有スペースにメモを残しておき、それを参照しながら後から wiki 化する場合もあります
  * 運営のお手伝いに手を上げてくださった方は Dropbox の共有スペースに招待させていただいています

### ツイートまとめの作成手順について
* [ツイートまとめ(togetter) 作成手順](https://github.com/kanazawarb/meetup/wiki/how-to-write-together)
* サンプル : https://posfie.com/@kiyohara/p/qLs6U9N

### 写真アルバムの作成手順について
* [写真アルバム(30days) 作成手順](https://github.com/kanazawarb/meetup/wiki/30days-%E3%82%A2%E3%83%AB%E3%83%90%E3%83%A0%E4%BD%9C%E6%88%90%E6%89%8B%E9%A0%86)
* サンプル : https://30d.jp/kzrb/136

### レポートページの作成手順について
* https://github.com/kanazawarb/meetup/ を編集してレポートページ毎に PR を作成してください
* assignee として自分自身を設定してください
* reviewer として `kanazawarb/reviewers` を選択してください
    * 実際のユーザーがランダム選出されます
    * この自動選択の結果によらず「誰でもレビューしてかまわない」です
    * reviewer は approve した際にはそのまま merge してください(公開されます)
* レポート作成補助ツールを使うとレポートの枠組みを作成してくれます
    * https://github.com/kanazawarb/meetup/ を checkout して `$ bundle exec rake meetup:gen_report` コマンドを使用

### Buffer での告知について
* kanazawarb アカウントを利用して設定してください
    * ID/Password は 1Password で管理されています

* 三つの告知を設定します

1. ツイートまとめ
    * 例

```
20XX年X月X日(土) に実施した Kanazawa.rb meetup XX のツイートをまとめました。
次回は 20XX年X月X日(土) を予定しています。

#kzrb

https://togetter.com/li/XXX
```

2. 写真アルバム
    * 例

```
20XX年X月X日(土) に実施した Kanazawa.rb meetup XX の写真を公開しました。
次回は 20XX年X月X日(土) を予定しています。

※30days 様のご厚意により pro アカウントを優待いただいております

#kzrb

http://30d.jp/kzrb/XX
```

3. レポートページ
    * 例

```
20XX年X月X日(土) に実施した Kanazawa.rb meetup XX のレポートを公開しました。
次回は 20XX年X月X日(土) を予定しています。

#kzrb

https://meetup.kzrb.org/XX/report.html
```

### ruby-jp slack での告知について

* `#kanazawarb` というチャネルがあるのでそこでアナウンスを実施してください
* 内容は Buffer でアナウンスした各種ページへのリンクがあればどのようなものでもかまいません
* 例

```
先日 20XX年X月X日(土) に実施した Kanazawa.rb meetup XX のレポートをまとめました。
ツイートまとめ: https://togetter.com/li/XXX
アルバム: http://30d.jp/kzrb/XX
レポート: https://meetup.kzrb.org/XX/report.html
```

