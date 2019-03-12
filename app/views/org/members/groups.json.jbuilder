json.array! @groups do |group|
  json.name group.name
  json.office group.parent&.name
  json.leader_email group.leader_member&.email
end
