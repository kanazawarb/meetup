まずやること
------------

    bundle install --path vendor

もしくは

    bundle install --path vendor --without livereload

( guard-livereload を install したくない場合 )

作業の進め方
------------

    bundle exec rake -T

すればだいたい分かるはず

URL設計
------

    /                          meetup そのものの説明
    /positionpaper.html        ポジションペーパーについて、参考
    /meetup                    meetup の説明
    /meetup/:num/index.html    開催告知
                /report.html   開催レポート
