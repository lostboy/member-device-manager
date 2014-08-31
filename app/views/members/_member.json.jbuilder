json.extract! member, :id, :first_name, :last_name, :email, :active,
  :membership_status, :membership_level, :membership_renewal_date

json.full_name member.full_name
