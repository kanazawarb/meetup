[![Build Status](http://img.shields.io/travis/kanazawarb/meetup.svg)](https://travis-ci.org/kanazawarb/meetup)

まずやること
------------

    bundle install --path vendor/bundle --binstubs .bundle/bin

( `guard-livereload` が必要な場合は global に install して使ってください )

作業の進め方
------------

    bundle exec rake -T

もしくは

    .bundle/bin/rake -T

すればだいたい分かるはず

URL設計
------

    /                          meetup そのものの説明
    /positionpaper.html        ポジションペーパーについて、参考
    /meetup                    meetup の説明
    /meetup/:num/index.html    開催告知
                /report.html   開催レポート
    /meetup/slides.html        Kanazawa.rb Slides
