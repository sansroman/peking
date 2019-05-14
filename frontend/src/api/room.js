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

export { getRoomList, getRoomInfo }
