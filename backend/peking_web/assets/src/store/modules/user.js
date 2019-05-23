/* eslint-disable prefer-promise-reject-errors */
import { loginByEmail, logout, getUserInfo } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'
const ROLE = ['student', 'teacher', 'admin']

const user = {
  state: {
    uid: '',
    user: '',
    status: '',
    code: '',
    token: getToken(),
    name: '',
    avatar: '',
    introduction: '',
    roles: [],
    room: {},
    setting: {
      articlePlatform: []
    }
  },

  mutations: {
    SET_CODE: (state, code) => {
      state.code = code
    },
    SET_TOKEN: (state, token) => {
      state.token = token
    },
    SET_INTRODUCTION: (state, introduction) => {
      state.introduction = introduction
    },
    SET_SETTING: (state, setting) => {
      state.setting = setting
    },
    SET_STATUS: (state, status) => {
      state.status = status
    },
    SET_NAME: (state, name) => {
      state.name = name
    },
    SET_AVATAR: (state, avatar) => {
      state.avatar = avatar
    },
    SET_ROLES: (state, roles) => {
      state.roles = roles
    },
    SET_UID: (state, uid) => {
      state.uid = uid
    },
    SET_ROOM: (state, room) => {
      state.room = room
    },
    SET_TODO: (state, todos) => {
      state.todos = {
        todo: todos.map(todo => ({ id: todo.id, name: todo.content })).filter(todo => todo.id === 0),
        doing: todos.map(todo => ({ id: todo.id, name: todo.content })).filter(todo => todo.id === 1),
        done: todos.map(todo => ({ id: todo.id, name: todo.content })).filter(todo => todo.id === 2)
      }
    }
  },

  actions: {
    LoginByEmail ({ commit }, userInfo) {
      const email = userInfo.email.trim()
      return new Promise((resolve, reject) => {
        loginByEmail(email, userInfo.password)
          .then(response => {
            const { data, status, error } = response.data
            if (!status) throw (error)
            commit('SET_TOKEN', data.uid)
            setToken(data.uid)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    // 获取用户信息
    GetUserInfo ({ commit, state }) {
      return new Promise((resolve, reject) => {
        getUserInfo(state.token)
          .then(response => {
            // 由于mockjs 不支持自定义状态码只能这样hack
            const data = response.data.data
            if (data.status) {
              reject('Verification failed, please login again.')
            }

            commit('SET_ROLES', [ROLE[data.role]])
            commit('SET_UID', data.id)
            commit('SET_NAME', data.nickname)
            commit('SET_AVATAR', data.avatar)
            commit('SET_INTRODUCTION', data.introduction)
            commit('SET_ROOM', data.room)
            commit('SET_TODO', data.todos)
            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    // 登出
    LogOut ({ commit, state }) {
      return new Promise((resolve, reject) => {
        logout(state.token)
          .then(() => {
            commit('SET_TOKEN', '')
            commit('SET_ROLES', [])
            removeToken()
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    // 前端 登出
    FedLogOut ({ commit }) {
      return new Promise(resolve => {
        commit('SET_TOKEN', '')
        removeToken()
        resolve()
      })
    },

    // 动态修改权限
    ChangeRoles ({ commit, dispatch }, role) {
      return new Promise(resolve => {
        commit('SET_TOKEN', role)
        setToken(role)
        getUserInfo(role).then(response => {
          const data = response.data
          commit('SET_ROLES', data.roles)
          commit('SET_NAME', data.name)
          commit('SET_AVATAR', data.avatar)
          commit('SET_INTRODUCTION', data.introduction)
          dispatch('GenerateRoutes', data) // 动态修改权限后 重绘侧边菜单
          resolve()
        })
      })
    }
  }
}

export default user
