json.extract!(
  member,
  :id,
  :name,
  :avatar_url,
  :join_on,
  :identity,
  :number,
  :created_at
)
json.organ member.organ, :name, :organ_uuid
