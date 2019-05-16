json.extract! member,
              :id,
              :name,
              :avatar_url,
              :join_on,
              :identity,
              :number,
              :organ_token,
              :created_at,
if member.organ
  json.organ member.organ, :name, :organ_uuid
end
