import { asyncRouters } from '@/router'

function hasPermission (roles, route) {
  if (route.meta && route.meta.roles) {
    return roles.some(role => route.meta.roles.includes(role))
  }
  return true
}
function filterRouter (routes, roles) {
  const res = []
  routes.forEach(route => {
    const tmp = { ...route }
    if (hasPermission(roles, tmp)) {
      if (tmp.children) {
        tmp.children = filterRouter(tmp.children, roles)
      }
      res.push(tmp)
    }
  })
  return res
}
const permission = {
  state: {
    routers: [],
    addRouters: []
  },
  mutations: {
    SET_ROUTERS: (state, routers) => {
      state.addRouters = routers
      state.routers = state.routers.concat(routers)
    }
  },
  actions: {
    GenerateRoutes ({ commit }, data) {
      return new Promise(resolve => {
        const { roles } = data
        let accessedRoutes = []
        if (roles.includes('admin')) {
          accessedRoutes = asyncRouters
        } else {
          accessedRoutes = filterRouter(asyncRouters, roles)
        }
        commit('SET_ROUTERS', accessedRoutes)
        resolve()
      })
    }
  }
}
export default permission
