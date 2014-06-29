require "#{Rails.root}/db/seeds/#{Rails.env}"

[
  {
    name: 'Mac WiFi',
    kind: 'MacWiFi',
  },
  {
    name: 'Mac Ethernet',
    kind: 'MacEthernet',
  },
  {
    name: 'PC WiFi',
    kind: 'PCWiFi',
  },
  {
    name: 'PC Ethernet',
    kind: 'PCEthernet',
  },
  {
    name: 'Phone',
    kind: 'Phone',
  },
  {
    name: 'Tablet or Pad',
    kind: 'Tablet',
  },
  {
    name: 'Other Device',
    kind: 'OtherBam',
  },
  {
    name: 'Other Computer',
    kind: 'OtherMem',
  },
  {
    name: 'PT Green Homes',
    kind: 'PTG',
  }
].each do |kind|
  Devices::Type.create! kind
end
