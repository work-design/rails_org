json.array! @sections do |section|
  json.name section.name
  json.office section.leader_member&.office&.name
  json.leader_email section.leader_member&.email
end
