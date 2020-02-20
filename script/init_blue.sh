
# blue

LOCAL_LO='[5::2]'

LOCAL_CONFIG='
{
  "local_asn": 10,
  "routes": [
    {
      "to": "::/0",
      "via": "4::1"
    },
    {
      "to": "5::/64",
      "via": "::1"
    }
  ],
  "neighbors": [
    "4:0:0:1::1"
  ]
}
'

bundle exec rails server -b "[::]" -P "tmp/blue.pid" &
sleep 2

curl -XPOST "http://${LOCAL_LO}:3000/config" --data "$LOCAL_CONFIG"

wait

