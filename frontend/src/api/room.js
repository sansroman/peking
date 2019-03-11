import axios from 'axios'

function getRoomList () {
  return axios({
    url: '/api/rooms',
    method: 'get'
  })
}

export { getRoomList }
