import axios from 'axios'

export function loginByUsername(username, password) {
  const data = {
    username,
    password,
  }
  return axios({
    url: '/login/login',
    method: 'post',
    data,
  })
}

export function logout() {
  return axios({
    url: '/login/logout',
    method: 'post',
  })
}

export function getUserInfo(token) {
  return axios({
    url: '/user/info',
    method: 'get',
    params: { token },
  })
}

