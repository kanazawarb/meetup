---
name: online meetup pre process
about: meetup イベント(オンライン開催)の前に実施するタスク
title: meetup XX イベント前対応
labels: ''
assignees: ''

---
## イベント概要の決定
- [ ] 日程を決定する
- [ ] 内容を決定する
- [ ] 場所を決定する

## オンライン開催準備
- [ ] Zoom の URL を予約する
- [ ] Slack に専用チャネルを作成する
    - チャネルトピックに Zoom URL をセットする
- [ ] ifttt の twitter-slack 連携の投稿先チャネルを変更する

## 申し込みページを作成する
- [ ] Doorkeeper イベントを未公開状態で作成
    - meetup ページ URL は仮で
    - オンライン開催として Zoom URL を設定する
- [ ] meetup ページ PR を作成
    - Doorkeeper イベントのウィジェットをいれこむ
- [ ] meetup ページを公開
    - PRをマージ
- [ ] Doorkeeper イベントを公開

## 告知活動を行う
- イベント概要決定時
    - [ ] イベント日をカレンダーに登録する
- イベント公開時
    - [ ] Doorkeeper(告知メール)
    - [ ] Twitter
    - [ ] Facebook
    - [ ] ruby-jp slack
- イベント一週間前
    - [ ] Doorkeeper(告知メール)
    - [ ] Twitter
    - [ ] Facebook
- イベント前々日
    - [ ] Twitter
    - [ ] Facebook
