import axios from 'axios'

function updateUserInfo ({ id, user }) {
  return axios({
    url: `/api/users/${id}`,
    method: 'put',
    data: { user }
  })
}

function getUserList () {
  return axios({
    url: '/api/users',
    method: 'get'
  })
}

function addTODO (data) {
  return axios({
    url: `/api/todos/`,
    method: 'post',
    data: data
  })
}

export { updateUserInfo, getUserList, addTODO }
