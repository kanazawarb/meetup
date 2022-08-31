[![Netlify Status](https://api.netlify.com/api/v1/badges/5369b4f4-7b1f-4bf6-8768-1cfe88b071e7/deploy-status)](https://app.netlify.com/sites/kzrb-org/deploys)
[![Netlify Status](https://api.netlify.com/api/v1/badges/77e1119d-dceb-4a1d-a4d1-cc4a4546385b/deploy-status)](https://app.netlify.com/sites/meetup-kzrb-org/deploys)

まずやること
------------

    bundle install --path vendor/bundle --binstubs .bundle/bin

作業の進め方
------------

    bundle exec rake -T

もしくは

    .bundle/bin/rake -T

すればだいたい分かるはず

Dockerで動かしたい場合
---------------------
```
# イメージをビルド
$ make build

# ポート 4000 番でサーバを起動
$ make up

# イベントの index.md のテンプレートを出力する
$ make index

# イベントの report.md のテンプレートを出力する
$ make report
