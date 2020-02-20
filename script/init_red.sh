
# red

LOCAL_LO='[5:1::2]'

LOCAL_CONFIG='
{
  "local_asn": 11,
  "routes": [
    {
      "to": "5:1::/64",
      "via": "::1"
    }
  ],
  "neighbors": [
    "4:0:0:1::2"
  ]
}
'

bundle exec rails server -b "[::]" -P "tmp/red.pid" &
sleep 2

curl -XPOST "http://${LOCAL_LO}:3000/config" --data "$LOCAL_CONFIG"

wait

