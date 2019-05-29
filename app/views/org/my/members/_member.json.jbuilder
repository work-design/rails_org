json.extract! member,
              :id,
              :name,
              :avatar_url,
              :join_on,
              :identity,
              :number,
              :created_at
json.organs member.organs do |organ|
  json.extract! organ, :name, :organ_uuid
  json.organ_token organ.get_organ_grant(member).token
end
