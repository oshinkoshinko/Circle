# Circle
![サイトロゴ](https://github.com/oshinkoshinko/Circle/blob/main/app/assets/images/Circle_logo.png)
![スクリーンショット](https://github.com/oshinkoshinko/Circle/blob/main/app/assets/images/readme_image.png)
( https://circle-app.work )

## サイト概要
近くにいる、趣味や勉強していることが同じ人が知り合うきっかけを作るサイト。
場所と趣味を共に呟くことで近くにいる人と繋がる、話し掛けるきっかけを作る。
イベント開催もでき勉強会や交流会もできる。
同士を見つけて楽しみながら高め合える。

### サイトテーマ
昨日までの他人が、一生の仲間に。
趣味がある、輪が広がる。

### 制作背景、制作への想い
自分の周りには本当は友達になれるはずの人が沢山いると思いました。

カフェでプログラミング勉強を毎日している中で、rubyの技術書で勉強している方がいました。
別日にも何回か居合わし、同じことを勉強しているし仲良くなれたらなと思いました。
結局、話しかけるのは警戒されると思い、他人のままで終わりました。

海外に住んでいた時、外国人は横にいる他人とすぐ打ち解けて自然と繋がりが広がっていたなあと思い出しました。
でも、日本人は国民性的にシャイで話しかけることに抵抗を感じるのでなかなか難しい。
一度きりの人生で、本当は親友になれたかもしれない人たちが他人のままで終わるのは、寂しいし、勿体無いと感じました。

そこで、日本人はグループ(同士の集まり)に入ると仲良くなれるものだと思いました。(例:学校、部活、サークル等)
同じことをしている、同じ方向に向かっている、それだけで人は仲良くなれると気付きました。
そういうきっかけ作りをアプリで実現できないかと思い、Circleを制作しました。

### ターゲットユーザ
趣味や勉強してるものがある大学生から、趣味や豊富な知識のある高齢者まで。
自分の能力や知識を拡散したい人、セミナー等を開きたい人。
人脈を広げたい人。
転勤や引越し等で、友人が少ない場所に来て友達を探している人。

### 主な利用シーン
1.一緒に切磋琢磨できる人、趣味を共有できる人と繋がりたい
  近くに勉強や趣味が同じ人がいれば、リクエストを送って話しかけるきっかけを作り、
  実際に会話して交流する。

2.誰かとスポーツや体験を共有したい
  検索して近くにやりたいスポーツをしている人がいれば、リクエストを送り参加させてもらう。

3.セミナーやイベントを開きたい、参加したい
  経験のある会員がイベントを企画して、参加者を募れる。
  有料にもできる為、お小遣い稼ぎにもピッタリ。
  参加者は経験者から学べたり、イベントを通して新たな人脈作りができる。

## 設計書
- ER図 ( https://drive.google.com/file/d/1VVnNZQ9R5pePl0HchQv_W1yoUzxHhD2C/view?usp=sharing )
- テーブル定義書 ( https://drive.google.com/file/d/1prES21JV5X0q-unlHV08AXQVFQQoa_xJ/view?usp=sharing )
- 詳細設計書( https://drive.google.com/file/d/1wEPNH3dlWfgtepja0h00UAVYfwi2dW5W/view?usp=sharing )
- ワイヤーフレーム ( https://drive.google.com/file/d/1zaO6gKAwjxkeehgjT0PWE3ST8gxB3ZVm/view?usp=sharing )

## 機能一覧
https://docs.google.com/spreadsheets/d/1nOtbKOEhYkcLXsklNgLzM1dDRuaOE5gJDA1Ie5T6-9E/edit?usp=sharing

### 主な機能
- Google Maps API (ピン表示、情報ウインドウ実装)
- Google Natural Language API (ネガポジ判定)
- 非同期通信
- https通信
- Action Mailer (会員登録時メール送信)
- お問い合わせ
- 通知
- チャット
- フォロー
- 投稿、コメント
- ゲストログイン
- RSpec単体テスト (Model, Controller)

## 開発環境
- OS：Linux2(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails(ver: 5.2.4.5), Bulma
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- Adobe stock
https://stock.adobe.com/jp/
- undraw
https://undraw.co/illustrations