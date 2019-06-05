json.extract! member,
              :id,
              :name,
              :avatar_url,
              :join_on,
              :identity,
              :number,
              :created_at
json.organ_token member.get_organ_grant.token
json.organ member.organ, :name, :organ_uuid
