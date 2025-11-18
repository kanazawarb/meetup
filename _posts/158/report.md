---

layout: report
title: "Meetup #158 report"
nav_exclude: true
published: true
number: 158
next: true
prev: true

---

<div style="text-align: left;"><a href="/158"><strong>アナウンスページはこちら</strong></a></div>

# Meetup #158 report

## 話題

* 自分が書いた原稿を見て「いいこと書いてるな～。しかしこれ本当に自分が書いたのか？まったく記憶にない」ってずっとなってます
* 「昔の自分、結構真面目にやってるな！」ってなる現象、たまにありますね
* 久々に nvim の plugins 更新したら動かなくなってて、それの修正ばかりしている。。。
* upsert_all って Cop に怒られるんだね。Validation が skip されるから。じゃCop無効化したくないでござる。。。となったら activerecord-import 一択じゃねーか
* DB のunique制約は勝手にみてくれるようなので、重複するものが来た場合は、on_duplicate_key_ignore か、 on_duplicate_key_update を true にしてやれば、重複レコードを作りにいかず、しかも、エラーにならずにしれっと処理が進む。
  Rails のほうの upsert_all はオプションで unique_by があって、これで同じようなことができるんじゃないかな？(試してはいない。だってCopに怒られたから
  + [activerecord-import](https://github.com/zdennis/activerecord-import?tab=readme-ov-file#duplicate-key-ignore)
* activerecord-import の recursive を試したかったが、postgres 限定らしい。今から postgres 用意するのダルいので、これは回避して別の手を講じることとする

## 運営ブレストログ

* [meetup 158 運用ブレストログ](https://github.com/kanazawarb/meetup/wiki/meetup-158-%E9%81%8B%E7%94%A8%E3%83%96%E3%83%AC%E3%82%B9%E3%83%88%E3%83%AD%E3%82%B0)

## まとめ

* [Kanazawa.rb meetup 158 - SUZURIアルバム](http://30d.jp/kzrb/146)

## 収支

* 前回の meetup 開催後から今回 meetup 開催後までのお金の出入り

| 項目                      |      金額 | 補足         |
|:------------------------|--------:|:-----------|
| 前回繰越金                   | 44,635円 |            |
| meetup 160 施設費用 | -4,370円 | cotton 支払済 |

**次回繰越**  40,265 円
