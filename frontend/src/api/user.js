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

export { updateUserInfo, getUserList }
