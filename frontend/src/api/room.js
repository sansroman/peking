import axios from 'axios'

function getRoomList () {
  return axios({
    url: '/api/rooms',
    method: 'get'
  })
}
function getRoomInfo (id) {
  return axios({
    url: `/api/rooms/${id}`,
    method: 'get'
  })
}

function startLive (data) {
  return axios({
    url: `/api/rooms/start`,
    method: 'post',
    data
  })
}

export { getRoomList, getRoomInfo, startLive }
