#users テーブル

|+--------------------+--------+---------------------------+
|       ç       |  Type  |           Options         |
+--------------------+--------+---------------------------+
| nickname           | string | null: false               |
+--------------------+--------+---------------------------+
| email              | string | null: false, unique: true |
+--------------------+--------+---------------------------+
| encrypted_password | string | null: false               |
+--------------------+--------+---------------------------+
| family_name        | string | null: false               |
+--------------------+--------+---------------------------+
| first_name         | string | null: false               |
+--------------------+--------+---------------------------+
| family_name_kana   | string | null: false               |
+--------------------+--------+---------------------------+
| first_name_kana    | string | null: false               |
+--------------------+--------+---------------------------+
| birthday           | date   | null: false               |
+--------------------+--------+---------------------------+

Association
has_many :items
has_many :orders

ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

items テーブル
+------------------------+------------+--------------------------------+
|          Type          |    Type    |             Options            |
+------------------------+------------+--------------------------------+
| name                   | string     | null: false                    |
+------------------------+------------+--------------------------------+
| description            | text       | null: false                    |
+------------------------+------------+--------------------------------+
| category_id            | integer    | null: false                    |
+------------------------+------------+--------------------------------+
| status_id              | integer    | null: false                    |
+------------------------+------------+--------------------------------+
| shipping_fee_status_id | integer    | null: false                    |
+------------------------+------------+--------------------------------+
| prefecture_id          | integer    | null: false                    |
+------------------------+------------+--------------------------------+
| scheduled_delivery_id  | integer    | null: false                    |
+------------------------+------------+--------------------------------+
| price                  | integer    | null: false                    |
+------------------------+------------+--------------------------------+
| user                   | references | null: false, foreign_key: true |
+------------------------+------------+--------------------------------+

Association
belongs_to :user
has_one :order

ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

orders テーブル
| Column 	|    Type    	|             Options            	|
|:------:	|:----------:	|:------------------------------:	|
| user   	| references 	| null: false, foreign_key: true 	|
| item   	| references 	| null: false, foreign_key: true 	|

Association
belongs_to :user
belongs_to :item
has_one :address

ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

addresses テーブル
|    Column    	|    Type    	|             Options            	|
|:------------:	|:----------:	|:------------------------------:	|
| postal_code  	| string     	| null: false                    	|
| prefecture   	| string     	| null: false                    	|
| city         	| string     	| null: false                    	|
| house_number 	| string     	| null: false                    	|
| building     	| string     	|                                	|
| phone_number 	| string     	| null: false                    	|
| order        	| references 	| null: false, foreign_key: true 	|

Association
belongs_to :order

users ──< items
users ──< orders ──1─1── addresses
          └────> items
