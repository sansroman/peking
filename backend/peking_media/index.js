const NodeMediaServer = require('node-media-server')
const axios = require('axios')
const redis = require('redis')
const serverAddr = 'localhost:4000'
let streamArr = [];
const config = {
  rtmp: {
    port: 1935,
    chunk_size: 60000,
    gop_cache: true,
    ping: 60,
    ping_timeout: 30
  },
  http: {
    port: 9090,
    allow_origin: '*'
  }
};

const nms = new NodeMediaServer(config)
const client = redis.createClient();
nms.run();

nms.on('postPublish', (_, StreamPath, args) => {
  let [, id, token] = StreamPath.split('/')
  console.log("params", id, token);
  axios
    .post(`http://${serverAddr}/api/rooms/live_cb`, {
      id,
      token
    }).then(res => {
      console.log(res)

    }).catch((err) => {
      // console.log(err);
    })


});

nms.on('donePublish', (id, StreamPath, args) => {
  client.hgetall(`room_${id}`, (err, obj) => {
    if (obj !== null || obj.status) client.HMSET(`room_${id}`, {
      status: false,
      online: obj.online
    });
  })
});
