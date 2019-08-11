const NodeMediaServer = require('node-media-server')
const axios = require('axios')
const serverAddr = process.env.MEDIA_SERVER || 'localhost:4000'
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
  },
  https: {
    port: 9443,
    allow_origin: '*',
    key: '/etc/ssl/peking.tboevil.top.key',
    cert: '/etc/ssl/peking.tboevil.top.pem',
  }
};

const nms = new NodeMediaServer(config)
nms.run();

nms.on('postPublish', (id, StreamPath, args) => {
  const room_id = StreamPath.replace(/\//g, '')
  const { token } = args
  console.log("lll",StreamPath, room_id, token);
  axios
    .post(`http://${serverAddr}/api/rooms/live_cb`, {
      id: room_id,
      token
    }).then(res => {
    }).catch((err) => {
      console.log(err);
      let session = nms.getSession(id);
      session.reject();
    })


});

nms.on('donePublish', (id, StreamPath, args) => {
  console.log(id);
});
