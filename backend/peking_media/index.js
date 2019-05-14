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

nms.on('postPublish', (id, StreamPath, args) => {
  let token = StreamPath.split('/')[2]

  axios
    .post(`http://${serverAddr}/api/verify`, {
      id,
      token
    }).then(res => {
      client.hgetall(`room_${id}`, (err, obj) => {
        if (!obj || !obj.status) client.HMSET(`room_${id}`, {
          status: true,
          online: obj.online
        });
      });

    }).catch((err) => {
      console.log(err);
    })


});

nms.on('donePublish', (id, StreamPath, args) => {
  client.hgetall(`room_${id}`, (err, obj) => {
    if (obj || obj.status) client.HMSET(`room_${id}`, {
      status: false,
      online: obj.online
    });
  })
});
