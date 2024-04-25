## users テーブル


|Column               |Type  |Options                  |
|---------------------|------|-------------------------|
|nick_name            |string|null:false               |
|email                |string|null:false, unique: true |
|encrypted_password   |string|null:false               |
|last_name            |string|null:false               |
|first_name           |string|null:false               |
|last_name_kana       |string|null:false               |
|first_name_kana      |string|null:false               | 
|birth                |date  |null:false               |


### Association

* has_many :items
* has_many :orders

### なぜそのアソシエーションやカラム名,型,オプションになるのか

#### アソシエーション
* `has_many :items` : 1人のユーザーは複数のitem(商品)を出品できるため
* `has_many :orders` : 複数のorders(購入)が可能であるため。

#### カラム名と型
(カラム名の説明は省略。一言で言うと「ユーザー登録に必要な情報」)
* `string型` : 文字列を含む情報を保存するため
* `date型` : 日付情報を含むため

#### オプション
* `email`カラムが`unique`である理由 : メールアドレスがデータベース上で一意(唯一無二)である必要があるため。

## items テーブル


|Column                  |Type      |Options                       |
|------------------------|----------|------------------------------|
|item_name               |string    |null:false                    |
|category_id             |integer   |null:false                    |
|situation_id            |integer   |null:false                    |
|delivery_fee_payment_id |integer   |null:false                    |
|region_id               |integer   |null:false                    |
|deadline_id             |integer   |null:false                    |
|price                   |integer   |null:false                    |
|item_text               |text      |null:false                    |
|user                    |references|null:false,  foreign_key: true|



### Association

* belongs_to :user
* has_one :order

### なぜそのアソシエーションやカラム名,型,オプションになるのか

#### アソシエーション
* `belongs_to :user` : 存在する商品は1人のユーザーによって出品されたものであるため。(ユーザーに依存するため)
* `has_one :order` : 一つの商品が一つの注文情報を持つため。

#### カラム名と型
(カラム名の説明は省略。一言で言うと「出品する際に必要な情報」)
* `string型` : 文字列を含む情報を保存するため
* `integer型` : 値が固定の選択肢から選ばれるため
* `text型` : 256文字以上の入力をできるようにするため
* `references型` : 他のテーブル(user)のレコードと関連付けするため

#### オプション
* `user`カラムが`foreign_key`である理由 : belongs_toで参照を行う側に記述しなければならないから


## addresses テーブル

|Column        |Type      |Options                      |
|--------------|----------|-----------------------------|
|post_code     |string    |null:false                   |
|region_id     |integer   |null:false                   |
|municipalities|string    |null:false                   |
|banchi        |string    |null:false                   |
|building_name |string    |                             |
|number        |string    |null:false                   |
|order         |references|null:false, foreign_key: true|

### Association

* belongs_to :order

### なぜそのアソシエーションやカラム名,型,オプションになるのか

#### アソシエーション
* `belongs_to :order` : 配送先情報が特定の注文に関連しているため

#### カラム名と型
(カラム名の説明は省略。一言で言うと「注文した際の配送先情報」)
* `string型` : 文字列を含む情報を保存するため
* `integer型` : 値が固定の選択肢から選ばれるため
* `references型` : 他のテーブル(order)のレコードと関連付けするため

#### オプション
* `order`カラムが`foreign_key`である理由 : belongs_toで参照を行う側に記述しなければならないから


## orders テーブル


|Column|Type      |Options                      |
|------|----------|-----------------------------|
|user  |references|null:false, foreign_key: true|
|item  |references|null:false, foreign_key: true|



### Association

* belongs_to :user
* belongs_to :item
* has_one :address

### なぜそのアソシエーションやカラム名,型,オプションになるのか

#### アソシエーション
* `belongs_to :user` : 注文は特定のユーザーによるものからである(関連している)ため
* `belongs_to :item` : 注文は特定の商品と関連しているため

#### カラム名と型
(カラム名の説明は省略。一言で言うと「誰(user)が何(item)を注文したか」)
* `references型` : 他のテーブル(user/order)のレコードと関連付けするため

#### オプション
* `user``user`カラムが`foreign_key`である理由 : belongs_toで参照を行う側に記述しなければならないから

## 各テーブルの説明
### usersテーブル
- ニックネーム
- メールアドレス
- 暗号化パスワード
- 姓(漢字) 
- 名(漢字)
- 姓(カナ)
- 名(カナ)
- 誕生年月日

### itemsテーブル
- カテゴリーID (Activehash)
- 価格
- 出品者
- 商品説明
- 商品状態ID (Activehash)
- 配送料負担ID (Activehash)
- 都道府県ID (Activehash)
- 発送までの日数ID (Activehash)

### favoritesテーブル
-ユーザーID (ユーザーの外部キーカラム)
商品ID (商品の外部キーカラム)

### Purchase_historyテーブル
- ユーザーID (ユーザーの外部キーカラム) 
- 商品ID (商品の外部キーカラム)

### addressesテーブル
- 購入履歴
- 郵便番号
- 都道府県ID (Activehash)
- 市区町村
- 番地
- 建物名
- 電話番号