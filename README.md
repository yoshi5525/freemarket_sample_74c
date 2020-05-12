# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|birth_year|date|null: false|
|birth_month|date|null: false|
|birth_day|date|null: false|
|tell_number|integer|null: false|
|email|string|null: false|

### Association
- has_many :items, dependent: :destroy
- has_many :addresses, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_one :card

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|category|references|null: false, foreign_key: true|
|brand|references|foreign_key: true|
|condition|string|null: false|
|area_id|integer|null: false|
|size|string|
|price|integer|null: false|
|preparation_day|integer|null: false|
|postage|integer|null: false|
|user|references|null: false|

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- has_many :images, dependent: :destroy
- has_many :comments, dependent: :destroy

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|post_code|integer|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|apartment|string|
|user|references|null:false, foreign_key: true|

### Association
- belongs_to :user

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null:false, unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
|user|references|null:false, foreign_key: true|

### Association
- belongs_to :user

## categorysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|ancestry|string|null:false|

### Association
- has_many :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association
- has_many :items

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|item|references|null:false, foreign_key: true|

### Association
- belongs_to :item

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null:false|
|user|references|null:false, foreign_key: true|
|item|references|null:false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item