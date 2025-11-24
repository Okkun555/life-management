json.extract! api_body_part, :id, :name
json.parent_id api_body_part.parent_id
# 親要素があれば「親1/親2/自身」のようなスラッシュ区切りの部位名を返す
# 親要素がなければ自身の名前を返す
json.full_name api_body_part.full_name
