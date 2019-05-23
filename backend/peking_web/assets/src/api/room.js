import axios from 'axios'

function getRoomList () {
  return axios({
    url: '/api/rooms',
    method: 'get'
  })
}

function getRoomUsers (roomid) {
  return axios({
    url: `/api/rooms/users?room_id=${roomid}`,
    method: 'get'
  })
}

function deleteRoom (id) {
  return axios({
    url: `/api/rooms/${id}`,
    method: 'delete'
  })
}

function getHotList () {
  return axios({
    url: '/api/rooms/hot',
    method: 'get'
  })
}

function getStarList () {
  return axios({
    url: '/api/rooms/my_collect',
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

function stopLive (data) {
  return axios({
    url: `/api/rooms/stop`,
    method: 'get',
    data
  })
}
function startDiscuss (data) {
  return axios({
    url: `/api/rooms/discuss`,
    method: 'post',
    data
  })
}

function startQuiz (data) {
  return axios({
    url: `/api/quizs`,
    method: 'post',
    data
  })
}

function commitQuiz (data) {
  return axios({
    url: `/api/answers`,
    method: 'post',
    data
  })
}

function collect (roomid) {
  return axios({
    url: `/api/rooms/collect/${roomid}`,
    method: 'get'
  })
}

function cancelCollect (roomid) {
  return axios({
    url: `/api/rooms/collect/${roomid}`,
    method: 'delete'
  })
}

export { getRoomList, getRoomUsers, getHotList, getStarList, getRoomInfo, startLive, startDiscuss, startQuiz, commitQuiz, collect, cancelCollect, stopLive, deleteRoom }
