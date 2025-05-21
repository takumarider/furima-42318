#users テーブル

|      カラム名      	| データ型 	|            制約           	|
|:------------------:	|:--------:	|:-------------------------:	|
| nickname           	| string   	| null: false               	|
| email              	| string   	| null: false, unique: true 	|
| encrypted_password 	| string   	| null: false               	|
| last_name          	| string   	| null: false               	|
| first_name         	| string   	| null: false               	|
| last_name_kana     	| string   	| null: false               	|
| first_name_kana    	| string   	| null: false               	|
| birth_date         	| date     	| null: false               	|

Association
has_many :items
has_many :orders

ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

items テーブル
|     カラム名    	|  データ型  	|              制約              	|
|:---------------:	|:----------:	|:------------------------------:	|
| name            	| string     	| null: false                    	|
| description     	| text       	| null: false                    	|
| price           	| integer    	| null: false                    	|
| category_id     	| integer    	| null: false                    	|
| status_id       	| integer    	| null: false                    	|
| shipping_fee_id 	| integer    	| null: false                    	|
| area_id         	| integer    	| null: false                    	|
| day_id          	| integer    	| null: false                    	|
| user_id         	| references 	| null: false, foreign_key: true 	|

Association
belongs_to :user
has_one :order

ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

orders テーブル
| カラム名 	|  データ型  	|              制約              	|
|:--------:	|:----------:	|:------------------------------:	|
| user_id  	| references 	| null: false, foreign_key: true 	|
| item_id  	| references 	| null: false, foreign_key: true 	|

Association
belongs_to :user
belongs_to :item
has_one :address

ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

addresses テーブル
|    カラム名   	|  データ型  	|              制約              	|
|:-------------:	|:----------:	|:------------------------------:	|
| postal_code   	| string     	| null: false                    	|
| prefecture_id 	| integer    	| null: false                    	|
| city          	| string     	| null: false                    	|
| house_number  	| string     	| null: false                    	|
| building      	| string     	|                                	|
| phone_number  	| string     	| null: false                    	|
| order_id      	| references 	| null: false, foreign_key: true 	|

Association
belongs_to :order


