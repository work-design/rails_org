json.array! @members do |member|
  json.id member.id
  json.name member.name
  json.email member.email
  json.section member.section&.name
  json.group member.group&.name
  json.office member.office&.name
  json.status member.enabled ? 'Activate' : 'Disabled'
  json.skype member.skype
  json.join_date member.join_on
  json.formal_date member.formal_on
  json.department member.department&.name
  json.text "#{member.name} (#{member.profile&.real_name})"
end
