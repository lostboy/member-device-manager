json.partial! 'members/member', member: @member

json.devices do |json|
  json.array! @member.devices, :id, :mac_address, :type_id
end
