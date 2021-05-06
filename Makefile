current_dir := $(notdir $(shell pwd))

#
# meetup用コンテナのイメージをビルドする
#
.PHONY: build
build:
	docker build . -t meetup

#
# ポート番号4000番でサーバコンテナを起動する
#
.PHONY: up
up:
	docker run -it -p 4000:4000 -p 35729:35729 -v $(current_dir):/tmp meetup

#
# イベントの index.md のテンプレートを出力する
#
.PHONY: index
index:
	docker run -it -v $(current_dir):/tmp meetup bundle exec rake meetup:gen_index

#
# イベントの report.md のテンプレートを出力する
#
.PHONY: report
report:
	docker run -it -v $(current_dir):/tmp meetup bundle exec rake meetup:gen_report
