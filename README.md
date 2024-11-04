# README
## アプリ名称
 楽器演奏アウトプット支援SNS「Solist」

## URL
 [solist-music.org](solist-music.org)

## 目的
 楽器の演奏を趣味にしたいと思う方、楽器店で簡単な楽器を買ったことのある方、もらいものでいい楽器を持っている方は意外と多いように思います。
 けれども、趣味として続けている方は、とても少ないように思います。
 なぜだろうと考えたとき、アウトプットのハードルが非常に高いことが一つの原因ではないかと思い、気軽にスマートフォンから練習の音源を投稿できるSNSアプリを作成しました。

 音楽もプログラミングと同じで、インプットとアウトプットのバランスが重要です。
 間違っていても、下手でもいいのでどんどん投稿し、応援しあえる場を提供できればと思っています。

## 技術仕様
フレームワーク: Ruby on Rails ver7.0.0  
データベース: MySQL  
サーバー: AWS EC2  

### データベース設計等

#### User
- Deviseを使用
- 気軽に登録できるよう、最低限のemailとpasswordのみに設計

Column | Type | Options
-------|------|--------
email | string | null: false, unique: true
encrypted_password | string | null: false

##### Association
- has_many :profiles


#### Profile
- Sessionを使用
- サブアカウントのような感覚で気軽に作成できる仕様

Column | Type | Options
-------|------|--------
name | string | null: false
text | string | null: false
user_id | references | null: false, foreign_key: true

その他、ActiveStrage機能によるAvatar画像

##### Association
- belongs_to :user
- has_many :sounds
- has_many :comments


#### Sound
- ActiveStrageを使用
- MP3ほか、iPhoneボイスメモのM4A形式対応
- (追加実装予定)1週間で自動的にデータが削除される仕様

Column | Type | Options
-------|------|--------
text | string | null: false
profile_id | references | null: false, foreign_key: true

その他、ActiveStrage機能による音源ファイル

##### Association
- belongs_to :profile
- has_many :comments


#### Comment
- コンパクトなUIとなるよう投稿されたsoundに隣接して、formと表示、削除リンクを配置

Column | Type | Options
-------|------|--------
text | string | null: false
profile_id | references | null: false, foreign_key: true
sound_id | references | null: false, foreign_key: true

##### Association
- belongs_to :profile
- belongs_to :sound

