# users テーブル

| カラム名           | データ型   | 制約                          |
|:------------------|:----------|:------------------------------|
| nickname          | string    | null: false                   |
| email             | string    | null: false, unique: true     |
| encrypted_password| string    | null: false                   |
| last_name         | string    | null: false                   |
| first_name        | string    | null: false                   |
| last_name_kana    | string    | null: false                   |
| first_name_kana   | string    | null: false                   |
| birth_date        | date      | null: false                   |

### Association
- has_many :items
- has_many :orders

---

# items テーブル

| カラム名              | データ型   | 制約                          |
|:---------------------|:----------|:------------------------------|
| name                 | string    | null: false                   |
| description          | text      | null: false                   |
| price                | integer   | null: false                   |
| category             | integer   | null: false                   |
| status               | integer   | null: false                   |
| shipping_fee         | integer   | null: false                   |
| prefecture           | integer   | null: false                   |
| shipping_day         | integer   | null: false                   |
| user                 | references| null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :order

---

# orders テーブル

| カラム名  | データ型   | 制約                          |
|:----------|:----------|:------------------------------|
| user      | references| null: false, foreign_key: true|
| item      | references| null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

---

# addresses テーブル

| カラム名      | データ型   | 制約                          |
|:-------------|:----------|:------------------------------|
| postal_code  | string    | null: false                   |
| prefecture   | integer   | null: false                   |
| city         | string    | null: false                   |
| house_number | string    | null: false                   |
| building     | string    |                               |
| phone_number | string    | null: false                   |
| order        | references| null: false, foreign_key: true|

### Association
- belongs_to :order

---

## ER図リレーション

- users has_many items
- users has_many orders
- items belongs_to user
- items has_one order
- orders belongs_to user
- orders belongs_to item
- orders has_one address
- addresses belongs_to order

```text
users ──< items
users ──< orders
orders ──1─1── addresses
orders ──> items
```


