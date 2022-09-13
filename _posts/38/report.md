---

layout: report
nav_exclude: true
title: "#38 report"
number: 38
next: true
prev: true
---

<p> <a href="/38/"><strong>アナウンスページはこちら</strong></a></p>

meetup #38 report
==================

話題
----

-   「明日は経験者とあまり経験のない人が半々くらいになるのかな？ いいバランスかもしんない。」
-   「今日のハンズオン、Railsにある程度慣れてて余裕のある方は Cloud9 IDE c9.io も試しておいてもらって、もしインストールに手こずる人がいたらサポートしてもらえるとありがたいです。」
-   「やってますよ Dmm.com ラボ [instagram.com/p/86-IClQep9/](https://instagram.com/p/86-IClQep9/) 」
-   「今日は新しい人がたくさんいる予感なので、ぽわんちゃんシールとwaponシールもってくればよかった・・・」
-   「今回はトラブルからネット環境が乏しいので、 Cloud9 ( [c9.io](https://c9.io/) ) を推奨するながれ。初めてみたけど、これすごいね。」
-   「「北陸先端大の学生をやっている…」「そっちかい！！」」
-   「今日は工大生とか高専生とか学生がいつもより多く参加してる」
-   「午後の部始まってます。ワタナベ先生のイントロセッション。 Dmm.com ラボ [instagram.com/p/87O2IXQelA/](https://instagram.com/p/87O2IXQelA/) 」
-   「初めての人が結構いる。嬉しいね。 Dmm.com ラボ [instagram.com/p/87PNB4wela/](https://instagram.com/p/87PNB4wela/) 」
-   「Herokuが…若干競合の人がいますが」
-   「Rails をとりまく「歴史」の話からスタート。」「すごくわかりやすい」
-   「最初は app, config, public ディレクトリ配下を見ればええよ。」
-   「困ったときは tmp の中身を全部消すといいよ」
-   「config 配下で触るのはおもに routes.rb」
-   「bundle exec rails generate scaffold todo description:string due:datetime note:text を実行してる」
-   「scaffoldすると、ぜんぶいいがにできるらしい。」
-   「rails コマンドってのがあるよ。 「\$ rails」って打ったら出来ること一覧がでるよ。rake コマンドってのもあるよ。 「\$ rake -T」って打ったら出来ること一覧がでるよ。」
-   「cloud9の人は、\$ rails s -p \$PORT -b \$IP これでいけるぽい。」
-   「ブラウザを通さなくても \$ rails console から DB の中身みれたり操作できたりするよ。」
-   「ブラウザの <URL>/todos に関して /app/controllers/todos\_controller.rb の def index がコントローラー /app/views/todos/index.html.erb がビュー」
-   「コントローラー側で作成したインスタンス変数の中身をビュー側で参照する感じ。」
-   「\$ rake routes でパス一覧がみれるよ。」
-   「\_form.erb ってのは共通部品の view だよ。パーシャルっていうよ。詳しくはおググりください。」
-   「erb は `<% %>` の間が ruby のコードだよ。 `<%= %>` としておくと出力が html として出てくるよ。基本はエスケープされるよ。 エスケープさせたくなかったら `<%== %>` って書いたらいいよ。」
-   「rails のお勉強によいドキュメントRails Guides ( [railsguides.jp](http://railsguides.jp/) )」
-   「こうやっておくと勝手につくられる。こうやっておくと勝手に関連付けられる。こうやっておくと勝手にいいがにしてくれる。これが rails の神髄。」
-   「\$ rails generate scaffold note body:text した後に /db/migrate/*\_notes.rb を編集して t.interger :todo\_id を3行目の下に追加して \$ rake db:migrate」
-   「/app/models/todo.rb に has\_many :notes を追加 /app/models/note.rb に belongs\_to :todo を追加 その後 \$ rails console で Todo.first.notes」
-   「で、次の編集は… こちらをご参照ください。 [github.com/wtnabe/rails-h…](https://github.com/wtnabe/rails-handson-todosample/commit/98f1090ca110147593a49d61340410018e5bc42f) わからないところがあると思うので、担当者がまわります！」
-   「もっと進めたい人は、ここを参照するといいよ。 Rails Girls ( [railsgirls.jp](http://railsgirls.jp/) )。特に「イベントの後: どのようにプログラミングを続けて行くか ( [railsgirls.jp/how-to-continu…](http://railsgirls.jp/how-to-continue-with-programming/) )」ってページがよいよ。」
-   「要望が多かったら、「脱初心者編」も考えてるよ！興味のあるひとは [@wtnabe](https://twitter.com/wtnabe) か #kzrb で是非ツイートしてね！」
-   「富山から来てたのは私です。今日はとりあえず雰囲気掴めたから良かった〜。来月も参加したい」
-   「MVCの関係性が全然だから、動くけどしっかりわからなかった、でもそこら辺をある程度わかれば色々便利に使えそう！ rails」
-   「脱初心者向けでasset pipelineとか turbolinksの話を聞いてみたい…」

まとめ
------

-   [kanazawa.rb meetup 38 - Togetter](http://togetter.com/li/888277)
-   [Kanazawa.rb meetup 38 - 30days](http://30d.jp/kzrb/28)

スライド
--------

-   [Railsハンズオン初級編](https://speakerdeck.com/wtnabe/hello-rails-and-more)
-   [今さらBundler補講](https://speakerdeck.com/wtnabe/afresh-bundler-extra-lesson)

参加者のブログ
--------------

-   [kanazawa.rb meetup #38 - 過ぎたるは及ばざるが如し](http://cotton-desu.hatenablog.com/entry/2015/10/18/232408)

収支
----

 | 項目                   | 金額       | 補足      |
 | ---------------------- | ---------- | --------- |
 | 部屋代 + 冷暖房費      | 0円        |           |
 | 参加費合計             | 11,000円   | 2名社割   |
 | meetup40施設料         | -6,780円   |           |
 | 二次会のおつり         | 615円      |           |
 | meetup #37 くり越し    | 51,045円   |           |
 | 差額                   | 55,880円   |           |


