import { getToken } from '@/utils/auth'
import { Message } from 'element-ui'
import store from './store'
import router from './router'

function hasPermission (roles, permissionRoles) {
  if (roles.indexOf('admin') >= 0) return true // admin permission passed directly
  if (!permissionRoles) return true
  return roles.some(role => permissionRoles.indexOf(role) >= 0)
}
const whiteList = ['/login', '/auth-redirect']// no redirect whitelist

router.beforeEach((to, from, next) => {
  if (getToken()) { // determine if there has token
    /* has token */
    if (to.path === '/login') {
      next({ path: '/' })
    } else if (store.getters.roles.length === 0) { // 判断当前用户是否已拉取完user_info信息
      store.dispatch('GetUserInfo').then(res => { // 拉取user_info
        const roles = res.data.roles // note: roles must be a array! such as: ['editor','develop']
        store.dispatch('GenerateRoutes', { roles }).then(() => { // 根据roles权限生成可访问的路由表
          router.addRoutes(store.getters.addRouters) // 动态添加可访问路由表
          next({ ...to, replace: true })
        })
      }).catch(err => {
        store.dispatch('FedLogOut').then(() => {
          Message.error(err)
          next({ path: '/' })
        })
      })
    } else if (hasPermission(store.getters.roles, to.meta.roles)) {
      next()
    } else next({ path: '/401', replace: true, query: { noGoBack: true } })
  } else if (whiteList.indexOf(to.path) !== -1) {
    next()
  } else {
    next(`/login?redirect=${to.path}`) // 否则全部重定向到登录页
  }
})
