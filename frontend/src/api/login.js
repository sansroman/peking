import axios from 'axios'

function loginByEmail (email, password) {
  const data = {
    email,
    password
  }
  return axios({
    url: '/api/login',
    method: 'post',
    data
  })
}
function logout () {
  return axios({
    url: '/api/logout',
    method: 'get'
  })
}
function getUserInfo (id) {
  return axios({
    url: `/api/users/${id}`,
    method: 'get'
  })
}

export { loginByEmail, logout, getUserInfo }
