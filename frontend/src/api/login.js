import axios from 'axios'

function loginByUsername(username, password) {
  const data = {
    username,
    password,
  }
  return axios({
    url: '/api/login',
    method: 'post',
    data,
  })
}
function logout() {
  return axios({
    url: '/api/logout',
    method: 'post',
  })
}
function getUserInfo(token) {
  return axios({
    url: '/api/user/info',
    method: 'get',
    params: { token },
  })
}

export { loginByUsername, logout, getUserInfo }
