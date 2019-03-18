import { param2Obj } from '@/utils'
const userMap = {
  admin: {
    roles: ['admin'],
    token: 'admin',
    introduction: '我是超级管理员',
    avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
    name: 'Super Admin'
  },
  student: {
    roles: ['student'],
    token: 'student',
    introduction: '我是学生',
    avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
    name: 'Normal student'
  },
  teacher: {
    roles: ['teacher'],
    token: 'teacher',
    introduction: '我是老师',
    avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
    name: 'Normal teacher'
  }
}

function loginByUsername (config) {
  const { username } = JSON.parse(config.body)
  return userMap[username]
}
function getUserInfo (config) {
  const { token } = param2Obj(config.url)
  if (userMap[token]) return userMap[token]
  return false
}
function logout () {
  return 'success'
}
export { loginByUsername, getUserInfo, logout }
