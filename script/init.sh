
LOCAL_LO='[5::2]'

LOCAL_CONFIG='
{
  "local_asn": 10,
  "routes": [
    {
      "to": "::/0",
      "via": "4::1"
    }
  ],
  "neighbors": []
}
'

bundle exec rails server -b "$LOCAL_LO" &
sleep 2

curl -XPOST "http://${LOCAL_LO}:3000/config" --data "$LOCAL_CONFIG"

wait

