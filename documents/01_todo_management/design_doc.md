# 01.ToDO管理機能の仕様
## ユーザーストーリー
- ユーザーは1日の始まりに、その日やりたい事を書き出せる
- ユーザーは書き出したTODOの進捗を管理できる
- ユーザーは1日の最後に、1日を振り返る事ができる

## 仕様
- 毎日0時にTODOリストを自動で作成する
  - n月n日に紐づいているTODOを別日に移動する事はできない（あくまでその日やるべき事を整理する機能）
  - 作成に失敗した場合の再実行ボタンを用意する（すでに該当の日付がある場合はスキップされる）
- 1日前にステータスが完了になっていないものは翌日に一覧表示する
- ステータスは（未完了・完了）の2種類
- TODOリストには振り返りコメントを記録できる

## テーブル設計
### todo_listsテーブル
| 論理名     | 物理名     | データ型 | デフォルト        | null許可 | キー | 備考       |
| ---------- | ---------- | -------- | ----------------- | -------- | ---- | ---------- |
| ID         | id         | bigint   |                   |          | PK   |            |
| ユーザーID | user_id    | bigint   |                   |          | FK   |            |
| タイトル   | title      | varchar  |                   |          |      |            |
| 有効判定   | is_current | boolean  | false             |          |      | 当日有効なリストかどうか |
| 作成日時   | created_at | datetime | CURRENT_TIMESTAMP |          |      |            |
| 更新日時   | updated_at | datetime | CURRENT_TIMESTAMP | ⚪︎     |      |            |

#### 制約
- 同一ユーザーで同タイトルのTODOリストは作成できない

### todo_itemsテーブル
| 論理名       | 物理名       | データ型     | デフォルト        | null許可 | キー | 備考              |
| ------------ | ------------ | ------------ | ----------------- | -------- | ---- | ----------------- |
| ID           | id           | bigint       |                   |          | PK   |                   |
| TODOリストID | todo_list_id | bigint       |                   |          | FK   |  
| ユーザーID | user_id    | bigint   |                   |          | FK |      |                 |
| 内容         | content      | varchar(140) |                   |          |      |                   |
| ステータス   | status       | smallint     | 1                 |          |      | 1: 未完了, 2:完了 |
| 作成日時     | created_at   | datetime     | CURRENT_TIMESTAMP |          |      |                   |
| 更新日時     | updated_at   | datetime     | CURRENT_TIMESTAMP |    ⚪︎      |      |                   |

### todo_reviewsテーブル
| 論理名       | 物理名       | データ型 | デフォルト | null許可 | キー | 備考 |
| ------------ | ------------ | -------- | ---------- | -------- | ---- | ---- |
| ID           | id           | bigint   |            |          | PK   |      |
| TODOリストID | todo_list_id | bigint   |            |          | FK   |      |
| ユーザーID | user_id    | bigint   |                   |          | FK |      |
| 振り返り     | review       | text     |            |          |      |      |
| 作成日時 | created_at | datetime | CURRENT_TIMESTAMP |          |      |      |
| 更新日時 | updated_at | datetime | CURRENT_TIMESTAMP | ⚪︎     |      |      |

#### 制約
- 同一TODOリストには1つの振り返りのみつけられる

#### メモ
- よりシンプルに```todo_lists_table```に振り返りコメントカラムを持たせる事も考えたが、登録タイミングが別ものになるので正規化した形で保持する。

