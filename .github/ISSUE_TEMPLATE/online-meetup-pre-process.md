---
name: meetup イベント前対応(オンライン版)
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
- [ ] イベント日をカレンダーに登録する
- [ ] Doorkeeper 告知メール
    - イベント公開時に送付すると同時に、イベント前々日に予約送信を設定する
- [ ] Buffer(Twitter, Facebook, Mastodon)
    - イベント公開時, イベント実施週の日曜(6日前)、イベント前々日の3回をセット
- [ ] ruby-jp slack
