json.extract! member,
              :id,
              :name,
              :avatar_url,
              :join_on,
              :identity,
              :number,
              :created_at,
              :updated_at
if member.department
  json.department member.department, :names, :full_name
end
if member.office
  json.office member.office, :name, :area
end
