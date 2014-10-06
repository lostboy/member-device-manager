require "#{Rails.root}/db/seeds/#{Rails.env}"

[
  {
    name: 'Mac WiFi',
    kind: 'MacWiFi',
    hotspot: 'hsv1-mem'
  },
  {
    name: 'Mac Ethernet',
    kind: 'MacEthernet',
    hotspot: 'hsv1-mem'
  },
  {
    name: 'PC WiFi',
    kind: 'PCWiFi',
    hotspot: 'hsv1-mem'
  },
  {
    name: 'PC Ethernet',
    kind: 'PCEthernet',
    hotspot: 'hsv1-mem'
  },
  {
    name: 'Phone',
    kind: 'Phone',
    hotspot: 'hsv2-bam'
  },
  {
    name: 'Tablet or Pad',
    kind: 'Tablet',
    hotspot: 'hsv2-bam'
  },
  {
    name: 'Other Device',
    kind: 'OtherBam',
    hotspot: 'hsv2-bam'
  },
  {
    name: 'Other Computer',
    kind: 'OtherMem',
    hotspot: 'hsv1-mem'
  },
  {
    name: 'PT Green Homes',
    kind: 'PTG',
    hotspot: 'hsv1-mem'
  }
].each do |kind|
  Devices::Type.create! kind
end
